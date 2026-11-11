// Exact map and phase enumeration for the two invariant four-dimensional V.
#include <array>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

using Bits = std::array<uint64_t, 4>;

struct Column {
    std::array<uint64_t, 16> map{};
    Bits phase{};
};

struct LinearSystem {
    int variables;
    int rank = 0;
    bool consistent = true;
    std::array<uint64_t, 22> pivots{};

    explicit LinearSystem(int n) : variables(n) {}

    void insert(uint32_t row, bool rhs) {
        uint64_t augmented = row | (uint64_t(rhs) << variables);
        for (int i = 0; i < variables; ++i) {
            if (!(augmented & (uint64_t(1) << i))) continue;
            if (!pivots[i]) {
                pivots[i] = augmented;
                ++rank;
                return;
            }
            augmented ^= pivots[i];
        }
        if (augmented) consistent = false;
    }

    uint32_t particular() const {
        uint32_t result = 0;
        for (int i = variables - 1; i >= 0; --i) {
            if (!pivots[i]) continue;
            bool bit = ((pivots[i] >> variables) & 1) ^ __builtin_parityll(pivots[i] & result);
            if (bit) result |= uint32_t(1) << i;
        }
        return result;
    }

    std::vector<uint32_t> kernel() const {
        std::vector<uint32_t> result;
        for (int j = 0; j < variables; ++j) {
            if (pivots[j]) continue;
            uint32_t v = uint32_t(1) << j;
            for (int i = variables - 1; i >= 0; --i)
                if (pivots[i] && __builtin_parityll(pivots[i] & v))
                    v ^= uint32_t(1) << i;
            result.push_back(v);
        }
        return result;
    }
};

struct Statistics {
    uint64_t tested = 0;
    uint64_t balanced = 0;
    uint64_t first_moments = 0;
    uint64_t second_moments = 0;
    uint64_t linear_compatible = 0;
    uint64_t admitting_phases = 0;
    uint64_t functions = 0;
    uint64_t nonlinear_systems = 0;
    std::array<uint64_t, 22> free_dimensions{};
};

uint32_t read32(std::istream& source) {
    uint32_t value;
    source.read(reinterpret_cast<char*>(&value), sizeof(value));
    return value;
}

void add(Bits& a, const Bits& b) {
    for (int i = 0; i < 4; ++i) a[i] ^= b[i];
}

Bits combine(const std::vector<Bits>& basis, uint32_t code) {
    Bits result{};
    while (code) {
        int i = __builtin_ctz(code);
        add(result, basis[i]);
        code &= code - 1;
    }
    return result;
}

bool bit_at(const Bits& bits, int x) {
    return (bits[x / 64] >> (x % 64)) & 1;
}

int weight(const Bits& a, const Bits& mask) {
    int total = 0;
    for (int i = 0; i < 4; ++i) total += __builtin_popcountll(a[i] & mask[i]);
    return total;
}

bool product(const Bits& a, const Bits& b, const Bits& mask) {
    int parity = 0;
    for (int i = 0; i < 4; ++i) parity ^= __builtin_parityll(a[i] & b[i] & mask[i]);
    return parity;
}

uint64_t count_phases(const std::array<std::array<uint8_t, 16>, 16>& fibres,
                      const Bits& reference, const std::vector<Bits>& phase_kernel,
                      const std::array<uint32_t, 256>& phase_evaluation,
                      Bits& witness, Statistics& statistics) {
    const int n = phase_kernel.size();
    LinearSystem linear(n);
    std::array<Bits, 16> masks{};
    for (int label = 0; label < 16; ++label) {
        std::array<uint32_t, 9> rows{};
        std::array<int, 9> reference_sums{};
        std::array<int, 8> weights{};
        for (int x : fibres[label]) {
            masks[label][x / 64] |= uint64_t(1) << (x % 64);
            const uint32_t evaluation = phase_evaluation[x];
            const bool h = bit_at(reference, x);
            rows[0] ^= evaluation;
            reference_sums[0] ^= h;
            for (int i = 0; i < 8; ++i) {
                if (!(x & (1 << i))) continue;
                rows[1 + i] ^= evaluation;
                reference_sums[1 + i] ^= h;
                weights[i]++;
            }
        }
        linear.insert(rows[0], reference_sums[0]);
        for (int i = 0; i < 8; ++i)
            linear.insert(rows[1 + i], reference_sums[1 + i] ^ ((weights[i] / 2) & 1));
        if (!linear.consistent) return 0;
    }
    statistics.linear_compatible++;
    const uint32_t root = linear.particular();
    std::vector<Bits> free;
    for (uint32_t code : linear.kernel()) free.push_back(combine(phase_kernel, code));
    const int dimension = free.size();
    statistics.free_dimensions[dimension]++;
    Bits base = reference;
    add(base, combine(phase_kernel, root));

    uint16_t constant = 0;
    std::vector<uint16_t> coefficients(dimension);
    std::vector<std::vector<std::pair<int, uint16_t>>> neighbours(dimension);
    bool quadratic = false;
    for (int label = 0; label < 16; ++label) {
        const Bits& mask = masks[label];
        if (((weight(base, mask) / 2) & 1) != 1) constant |= uint16_t(1) << label;
        for (int i = 0; i < dimension; ++i) {
            bool coefficient = ((weight(free[i], mask) / 2) & 1) ^ product(base, free[i], mask);
            if (coefficient) coefficients[i] |= uint16_t(1) << label;
        }
    }
    for (int i = 0; i < dimension; ++i) {
        for (int j = i + 1; j < dimension; ++j) {
            uint16_t cross = 0;
            for (int label = 0; label < 16; ++label)
                if (product(free[i], free[j], masks[label])) cross |= uint16_t(1) << label;
            if (!cross) continue;
            quadratic = true;
            neighbours[i].push_back({j, cross});
            neighbours[j].push_back({i, cross});
        }
    }

    if (!quadratic) {
        LinearSystem equations(dimension);
        for (int label = 0; label < 16; ++label) {
            uint32_t row = 0;
            for (int i = 0; i < dimension; ++i)
                if (coefficients[i] & (1 << label)) row |= uint32_t(1) << i;
            equations.insert(row, constant & (1 << label));
        }
        if (!equations.consistent) return 0;
        witness = base;
        add(witness, combine(free, equations.particular()));
        return uint64_t(1) << (dimension - equations.rank);
    }

    statistics.nonlinear_systems++;
    uint16_t value = constant;
    uint32_t selected = 0;
    uint32_t first_solution = 0;
    uint64_t solutions = 0;
    for (uint32_t word = 0; word < (uint32_t(1) << dimension); ++word) {
        if (word) {
            int i = __builtin_ctz(word);
            value ^= coefficients[i];
            for (const auto& item : neighbours[i]) coefficients[item.first] ^= item.second;
            selected ^= uint32_t(1) << i;
        }
        if (value) continue;
        if (!solutions) first_solution = selected;
        solutions++;
    }
    if (solutions) {
        witness = base;
        add(witness, combine(free, first_solution));
    }
    return solutions;
}

int main(int argc, char** argv) {
    if (argc != 6) {
        std::cerr << "Usage: dim4_count MODEL START COUNT OUTPUT_PREFIX SUPPORT_ONLY\n";
        return 2;
    }
    const auto start_time = std::chrono::steady_clock::now();
    std::ifstream source(argv[1], std::ios::binary);
    char magic[8];
    source.read(magic, 8);
    if (!source || std::string(magic, 7) != "DIM4V01") throw std::runtime_error("Bad model header");
    uint32_t space = read32(source);
    int dimension = read32(source);
    int nphase = read32(source);
    if (dimension > 33 || nphase > 21) throw std::runtime_error("Model dimensions");
    std::vector<Bits> phase_kernel(nphase);
    for (Bits& b : phase_kernel) source.read(reinterpret_cast<char*>(b.data()), 32);
    std::vector<Column> columns(dimension);
    for (Column& v : columns) {
        source.read(reinterpret_cast<char*>(v.map.data()), 128);
        source.read(reinterpret_cast<char*>(v.phase.data()), 32);
    }
    if (!source) throw std::runtime_error("Truncated model");
    const uint64_t first = std::stoull(argv[2]);
    const uint64_t count = std::stoull(argv[3]);
    if (first > (uint64_t(1) << dimension) || count > (uint64_t(1) << dimension) - first)
        throw std::runtime_error("Range outside map space");
    const bool support_only = std::stoi(argv[5]) != 0;
    const std::string prefix = argv[4];
    std::ofstream solutions_file(prefix + ".solutions.bin", std::ios::binary);
    std::array<uint32_t, 256> phase_evaluation{};
    for (int x = 0; x < 256; ++x)
        for (int i = 0; i < nphase; ++i)
            if (bit_at(phase_kernel[i], x)) phase_evaluation[x] |= uint32_t(1) << i;

    Column current;
    uint64_t gray = first ^ (first >> 1);
    for (int i = 0; i < dimension; ++i) {
        if (!(gray & (uint64_t(1) << i))) continue;
        for (int j = 0; j < 16; ++j) current.map[j] ^= columns[i].map[j];
        add(current.phase, columns[i].phase);
    }

    Statistics statistics;
    std::array<std::array<uint8_t, 16>, 16> fibres{};
    for (uint64_t word = first; word < first + count; ++word) {
        if (word != first) {
            int i = __builtin_ctzll(word);
            for (int j = 0; j < 16; ++j) current.map[j] ^= columns[i].map[j];
            add(current.phase, columns[i].phase);
        }
        statistics.tested++;
        std::array<int, 16> sizes{};
        std::array<int, 16> sums{};
        bool valid = true;
        for (int x = 0; x < 256; ++x) {
            int label = (current.map[x / 16] >> (4 * (x % 16))) & 15;
            int index = sizes[label]++;
            if (index >= 16) {
                valid = false;
                break;
            }
            fibres[label][index] = x;
            sums[label] ^= x;
        }
        if (!valid) continue;
        statistics.balanced++;
        for (int s : sums) if (s) valid = false;
        if (!valid) continue;
        statistics.first_moments++;
        for (const auto& fibre : fibres) {
            std::array<uint16_t, 8> rows{};
            for (int j = 0; j < 16; ++j)
                for (int i = 0; i < 8; ++i)
                    if (fibre[j] & (1 << i)) rows[i] |= uint16_t(1) << j;
            for (int i = 0; i < 8; ++i)
                for (int j = 0; j < i; ++j)
                    if (__builtin_parity(rows[i] & rows[j])) valid = false;
            if (!valid) break;
        }
        if (!valid) continue;
        statistics.second_moments++;
        if (support_only) continue;
        Bits witness{};
        uint64_t solutions = count_phases(fibres, current.phase, phase_kernel, phase_evaluation,
                                          witness, statistics);
        if (!solutions) continue;
        statistics.admitting_phases++;
        statistics.functions += solutions;
        uint64_t code = word ^ (word >> 1);
        solutions_file.write(reinterpret_cast<char*>(&code), 8);
        solutions_file.write(reinterpret_cast<char*>(&solutions), 8);
        solutions_file.write(reinterpret_cast<char*>(witness.data()), 32);
    }
    solutions_file.close();
    if (!solutions_file) throw std::runtime_error("Solution output failure");
    const double seconds = std::chrono::duration<double>(std::chrono::steady_clock::now() - start_time).count();
    std::ofstream output(prefix + ".json");
    output << "{\n\"space\":" << space << ",\"map_dimension\":" << dimension
           << ",\"start\":" << first << ",\"count\":" << count << ",\"support_only\":"
           << (support_only ? "true" : "false") << ",\n";
    output << "\"tested\":" << statistics.tested << ",\"balanced\":" << statistics.balanced
           << ",\"first_moments\":" << statistics.first_moments
           << ",\"second_moments\":" << statistics.second_moments
           << ",\"linear_compatible\":" << statistics.linear_compatible
           << ",\"admitting_phases\":" << statistics.admitting_phases
           << ",\"functions\":" << statistics.functions
           << ",\"nonlinear_systems\":" << statistics.nonlinear_systems
           << ",\"seconds\":" << seconds << ",\"free_dimensions\":{";
    bool comma = false;
    for (int i = 0; i <= nphase; ++i) {
        if (!statistics.free_dimensions[i]) continue;
        if (comma) output << ',';
        output << '"' << i << "\":" << statistics.free_dimensions[i];
        comma = true;
    }
    output << "}}\n";
    if (!output) throw std::runtime_error("Report output failure");
    std::cout << "space " << space << " tested " << statistics.tested << " supports "
              << statistics.second_moments << " maps " << statistics.admitting_phases
              << " functions " << statistics.functions << " seconds " << seconds << '\n';
}
