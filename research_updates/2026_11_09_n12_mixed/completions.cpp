#include <algorithm>
#include <array>
#include <bit>
#include <chrono>
#include <cstdint>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <map>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

namespace {
constexpr unsigned n = 12;
constexpr unsigned point_count = 1u << n;
constexpr unsigned mask = point_count - 1;
constexpr unsigned words = 6;
constexpr unsigned lower_count = 25;
constexpr unsigned top_count = 43;
using Packed = std::array<std::uint64_t, words>;
using Orbits = std::vector<std::vector<unsigned>>;

void require(bool condition, const std::string& message) {
    if (!condition) throw std::runtime_error(message);
}

unsigned rotate(unsigned x) {
    return ((x << 1) | (x >> (n - 1))) & mask;
}

Orbits orbits(int degree = -1) {
    std::array<bool, point_count> visited{};
    Orbits out;
    for (unsigned x = 0; x < point_count; ++x) {
        if (visited[x] || (degree >= 0 && std::popcount(x) != degree)) continue;
        std::vector<unsigned> orbit;
        unsigned y = x;
        do {
            orbit.push_back(y);
            visited[y] = true;
            y = rotate(y);
        } while (y != x);
        out.push_back(std::move(orbit));
    }
    return out;
}

void xor_into(Packed& a, const Packed& b) {
    for (unsigned j = 0; j < words; ++j) a[j] ^= b[j];
}

bool value(const Packed& p, unsigned i) {
    return (p[i / 64] >> (i % 64)) & 1u;
}

struct Term {
    unsigned word;
    std::uint64_t bits;
    int coefficient;
};

struct FourierTest {
    unsigned frequency;
    std::vector<Term> terms;

    int sum(const Packed& p) const {
        int result = 0;
        for (const auto& term : terms) {
            result += term.coefficient * std::popcount(p[term.word] & term.bits);
        }
        return result;
    }
};

struct Basis {
    Orbits input = orbits();
    Orbits lower = orbits(2);
    Orbits top = orbits(4);
    std::array<unsigned, point_count> point_orbit{};
    std::array<Packed, lower_count> lower_tables{};
    std::array<Packed, top_count> top_tables{};
    std::array<bool, 65536> admissible{};
    std::vector<FourierTest> tests;
    std::vector<std::pair<unsigned, Packed>> roots;
    std::vector<unsigned> kernel_codes;
    std::vector<Packed> kernel;
    unsigned quadratic_code = 0;

    Basis() {
        const auto cubic = orbits(3);
        lower.insert(lower.end(), cubic.begin(), cubic.end());
        require(input.size() == 352 && lower.size() == lower_count &&
                top.size() == top_count, "Unexpected orbit counts");
        std::stable_sort(input.begin(), input.end(),
                         [](const auto& a, const auto& b) { return a.size() < b.size(); });
        for (unsigned i = 0; i < input.size(); ++i) {
            for (unsigned x : input[i]) point_orbit[x] = i;
        }
        for (unsigned i = 0; i < lower.size(); ++i) {
            lower_tables[i] = polynomial(lower[i]);
            if (lower[i].front() == 65) quadratic_code = 1u << i;
        }
        require(quadratic_code != 0, "Missing antipodal orbit");
        for (unsigned i = 0; i < top.size(); ++i) top_tables[i] = polynomial(top[i]);
        make_tests();
        make_charts();
    }

    Packed polynomial(const std::vector<unsigned>& supports) const {
        Packed table{};
        for (unsigned i = 0; i < input.size(); ++i) {
            const unsigned x = input[i].front();
            bool bit = false;
            for (unsigned m : supports) bit ^= (x & m) == m;
            if (bit) table[i / 64] |= std::uint64_t{1} << (i % 64);
        }
        return table;
    }

    template <std::size_t count>
    static Packed combine(const std::array<Packed, count>& tables, std::uint64_t code) {
        Packed result{};
        while (code) {
            const unsigned i = std::countr_zero(code);
            xor_into(result, tables[i]);
            code &= code - 1;
        }
        return result;
    }

    unsigned projection(const Packed& p) const {
        unsigned t = 0;
        for (unsigned x = 0; x < 16; ++x) {
            t |= unsigned(value(p, point_orbit[273 * x])) << x;
        }
        return t;
    }

    void make_charts() {
        std::map<unsigned, unsigned> image{{0, 0}};
        for (unsigned i = 0; i < lower_count; ++i) {
            const unsigned t = projection(lower_tables[i]);
            if (image.contains(t)) {
                const unsigned c = image.at(t) ^ (1u << i);
                kernel_codes.push_back(c);
                kernel.push_back(combine(lower_tables, c));
                require(projection(kernel.back()) == 0, "Invalid kernel vector");
                continue;
            }
            const auto snapshot = image;
            for (const auto& [key, c] : snapshot) image[key ^ t] = c ^ (1u << i);
        }
        require(kernel.size() == 21 && image.size() == 16, "Unexpected period-four rank");
        for (const auto& [key, c] : image) {
            auto v = combine(lower_tables, c);
            require(projection(v) == key, "Invalid root");
            roots.emplace_back(c, v);
        }
        for (unsigned t = 0; t < admissible.size(); ++t) {
            bool good = true;
            for (unsigned u = 0; u < 16 && good; ++u) {
                int w = 0;
                for (unsigned x = 0; x < 16; ++x) {
                    const unsigned bit = ((t >> x) ^ std::popcount(x & u)) & 1u;
                    w += bit ? -1 : 1;
                }
                good = w % 3 != 0;
            }
            admissible[t] = good;
        }
    }

    void make_tests() {
        std::array<bool, point_count> used{};
        auto add = [&](unsigned u) {
            if (used[u]) return;
            unsigned v = u;
            do {
                used[v] = true;
                v = rotate(v);
            } while (v != u);
            std::array<std::array<std::uint64_t, 25>, words> bins{};
            for (unsigned i = 0; i < input.size(); ++i) {
                int total = 0;
                for (unsigned x : input[i]) total += std::popcount(u & x) % 2 ? -1 : 1;
                bins[i / 64][total + 12] |= std::uint64_t{1} << (i % 64);
            }
            FourierTest test{u, {}};
            for (unsigned j = 0; j < words; ++j) {
                for (int w = -12; w <= 12; ++w) {
                    if (w != 0 && bins[j][w + 12]) test.terms.push_back({j, bins[j][w + 12], w});
                }
            }
            tests.push_back(std::move(test));
        };
        for (unsigned u : {0u, 4095u, 1u, 3u, 5u, 7u, 15u, 9u, 11u, 17u, 273u, 819u}) add(u);
        for (unsigned u = 0; u < point_count; ++u) add(u);
        require(tests.size() == 352 && tests.front().frequency == 0, "Incomplete Fourier tests");
    }

    bool full_walsh(const Packed& table) const {
        std::array<int, point_count> s{};
        for (unsigned x = 0; x < point_count; ++x) {
            s[x] = value(table, point_orbit[x]) ? -1 : 1;
        }
        for (unsigned step = 1; step < point_count; step <<= 1) {
            for (unsigned start = 0; start < point_count; start += 2 * step) {
                for (unsigned i = start; i < start + step; ++i) {
                    const int a = s[i], b = s[i + step];
                    s[i] = a + b;
                    s[i + step] = a - b;
                }
            }
        }
        return std::all_of(s.begin(), s.end(), [](int a) { return a == 64 || a == -64; });
    }

    std::uint64_t control_top() const {
        std::uint64_t code = 0;
        for (unsigned i = 0; i < top.size(); ++i) {
            unsigned m = top[i].front();
            unsigned y = (m & 63u) | (m >> 6);
            if (std::popcount(y) != 4) continue;
            for (unsigned j = 0; j < 6; ++j) {
                const unsigned support = ((15u << j) | (15u >> (6 - j))) & 63u;
                if (y == support) code |= std::uint64_t{1} << i;
            }
        }
        return code;
    }

    void validate_control() const {
        const auto c = control_top();
        auto truth = combine(top_tables, c);
        xor_into(truth, combine(lower_tables, quadratic_code));
        require(c != 0 && admissible[projection(truth)] && full_walsh(truth),
                "Positive quartic control failed");
        const auto weight = tests.front().sum(truth);
        require(weight == 2016 || weight == 2080, "Packed weight disagrees with positive control");
        for (auto it = tests.begin() + 1; it != tests.end(); ++it) {
            const int a = it->sum(truth);
            require(a == 32 || a == -32, "Packed Fourier test disagrees with full control");
        }
        require(!full_walsh(combine(top_tables, c)), "Homogeneous control unexpectedly bent");
    }
};

struct Result {
    std::uint64_t trials = 0;
    std::uint64_t pass_weight = 0;
    std::uint64_t solutions = 0;
    std::uint64_t cubic = 0;
    std::uint64_t quadratic = 0;
};

Result enumerate(const Basis& b, std::uint64_t top_code, std::ostream& hits) {
    Result result;
    const Packed top = Basis::combine(b.top_tables, top_code);
    const unsigned projection = b.projection(top);
    const unsigned limit = 1u << b.kernel.size();
    for (const auto& [root, shift] : b.roots) {
        if (!b.admissible[projection ^ b.projection(shift)]) continue;
        Packed current = top;
        xor_into(current, shift);
        unsigned low_code = root;
        result.trials += limit;
        for (unsigned step = 0; step < limit; ++step) {
            if (step) {
                const unsigned j = std::countr_zero(step);
                xor_into(current, b.kernel[j]);
                low_code ^= b.kernel_codes[j];
            }
            const int weight = b.tests.front().sum(current);
            if (weight != 2016 && weight != 2080) continue;
            ++result.pass_weight;
            bool bent = true;
            for (auto it = b.tests.begin() + 1; it != b.tests.end(); ++it) {
                const int a = it->sum(current);
                if (a != 32 && a != -32) {
                    bent = false;
                    break;
                }
            }
            if (!bent) continue;
            auto check = Basis::combine(b.lower_tables, low_code);
            xor_into(check, top);
            require(check == current && b.full_walsh(check), "Independent Walsh replay failed");
            hits << top_code << '\t' << low_code << '\n';
            ++result.solutions;
            if (top_code == 0) {
                if (low_code >> 6) ++result.cubic;
                else ++result.quadratic;
            }
        }
    }
    require(result.trials == (1u << 23), "Unexpected number of lower completions");
    if (top_code == 0) {
        require(result.cubic == 14320 && result.quadratic == 16, "Cubic enumeration disagrees");
    }
    return result;
}
}  // namespace

int main(int argc, char** argv) {
    try {
        require(argc == 5 || argc == 6,
                "Usage: completions representatives.tsv shard shard_count output [limit]");
        const unsigned shard = std::stoul(argv[2]);
        const unsigned shard_count = std::stoul(argv[3]);
        const unsigned limit = argc == 6 ? std::stoul(argv[5]) : ~0u;
        require(shard < shard_count, "Invalid shard");
        std::ifstream data(argv[1]);
        require(bool(data), "Could not open representatives");
        const std::filesystem::path dir(argv[4]);
        std::filesystem::create_directories(dir);
        std::ofstream summary(dir / "summary.tsv");
        std::ofstream hits(dir / "bent.tsv");
        require(bool(summary) && bool(hits), "Could not write results");
        summary << "top\torbit_size\ttrials\tpass_weight\tsolutions\tseconds\n";
        const Basis basis;
        basis.validate_control();
        std::cout << "Positive control top " << basis.control_top()
                  << ", lower " << basis.quadratic_code << std::endl;
        unsigned i = 0;
        unsigned processed = 0;
        std::uint64_t total_hits = 0;
        std::uint64_t top;
        unsigned size;
        while (data >> top >> size) {
            require(top < (std::uint64_t{1} << top_count) &&
                    size > 0 && 512 % size == 0, "Malformed representative");
            if (i++ % shard_count != shard) continue;
            if (processed >= limit) break;
            const auto start = std::chrono::steady_clock::now();
            const auto r = enumerate(basis, top, hits);
            const double sec = std::chrono::duration<double>(
                std::chrono::steady_clock::now() - start).count();
            summary << top << '\t' << size << '\t' << r.trials << '\t'
                    << r.pass_weight << '\t' << r.solutions << '\t' << sec << '\n';
            summary.flush();
            hits.flush();
            require(bool(summary) && bool(hits), "Write failure");
            ++processed;
            total_hits += r.solutions;
            if (processed <= 4 || processed % 50 == 0) {
                std::cout << "shard " << shard << " processed " << processed
                          << ", latest " << top << " in " << sec
                          << " s, cumulative bent " << total_hits << std::endl;
            }
        }
        require(data.eof() || processed == limit, "Error reading representatives");
        std::cout << "FINISHED shard " << shard << ", processed " << processed
                  << ", bent " << total_hits << std::endl;
    } catch (const std::exception& error) {
        std::cerr << error.what() << '\n';
        return 1;
    }
}
