// Count the exact phases of maps retained by the lower-dimensional sieve.
#include <array>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <map>
#include <stdexcept>
#include <string>
#include <vector>

constexpr int max_words = 32;
constexpr int max_properties = 5;
constexpr int max_dimension = 50;
constexpr int quadratic_words = 20;
using Word = uint64_t;
using Form = std::array<Word, quadratic_words>;

struct Phase {
    std::array<Word, max_words> value{};
    std::array<Word, max_properties> signature{};
};

struct Moment {
    std::array<Word, max_words> mask{};
    unsigned modulus_mask = 0;
    unsigned residue = 0;
    int first = max_words;
    int stop = 0;
};

struct Statistics {
    Word tasks = 0;
    Word inconsistent = 0;
    Word deferred = 0;
    Word tested_maps = 0;
    Word maps = 0;
    Word functions = 0;
    Word phase_trials = 0;
    std::map<int, Word> residual_dimensions;
    std::map<int, Word> deferred_dimensions;
};

template<class T>
void read(std::istream& in, T& value) {
    if (!in.read(reinterpret_cast<char*>(&value), sizeof(T)))
        throw std::runtime_error("Truncated phase input");
}

Phase read_phase(std::istream& in, int words, int properties) {
    Phase phase;
    for (int i = 0; i < words; ++i) read(in, phase.value[i]);
    for (int i = 0; i < properties; ++i) read(in, phase.signature[i]);
    return phase;
}

void add(Phase& a, const Phase& b, int words, int properties) {
    for (int i = 0; i < words; ++i) a.value[i] ^= b.value[i];
    for (int i = 0; i < properties; ++i) a.signature[i] ^= b.signature[i];
}

unsigned weight(const Phase& phase, const Moment& moment) {
    unsigned result = 0;
    for (int i = moment.first; i < moment.stop; ++i)
        result += __builtin_popcountll(phase.value[i] & moment.mask[i]);
    return result;
}

bool pair(const Phase& a, const Phase& b, const Moment& moment) {
    Word result = 0;
    for (int i = moment.first; i < moment.stop; ++i)
        result ^= a.value[i] & b.value[i] & moment.mask[i];
    return __builtin_parityll(result);
}

int leading(const Form& row) {
    for (int i = quadratic_words - 1; i >= 0; --i)
        if (row[i]) return 64 * i + 63 - __builtin_clzll(row[i]);
    return -1;
}

void insert(Form& row, int i) { row[i / 64] ^= Word(1) << (i % 64); }

bool reduce_quadratics(Phase& root, std::vector<Phase>& directions,
                       const std::vector<Moment>& moments, int words, int properties) {
    // Low bits are constant and linear. Pivots on quadratic monomials
    // eliminate all possible quadratic terms before solving the linear rows.
    const int d = directions.size();
    const int slots = 1 + d + d * (d - 1) / 2;
    std::vector<Form> basis(slots);
    for (const Moment& moment : moments) {
        Form row{};
        if (((weight(root, moment) ^ moment.residue) & 2) != 0) insert(row, 0);
        for (int i = 0; i < d; ++i) {
            if (((weight(directions[i], moment) >> 1) & 1) ^ pair(root, directions[i], moment))
                insert(row, 1 + i);
        }
        int k = 1 + d;
        for (int i = 0; i < d; ++i)
            for (int j = i + 1; j < d; ++j, ++k)
                if (pair(directions[i], directions[j], moment)) insert(row, k);
        int p;
        while ((p = leading(row)) >= 0) {
            if (p == 0) return false;
            if (!basis[p][p / 64]) {
                basis[p] = row;
                break;
            }
            for (int j = 0; j <= p / 64; ++j) row[j] ^= basis[p][j];
        }
    }
    Word particular = 0;
    std::vector<Word> null;
    const Word constant = 1;
    for (int i = 1; i <= d; ++i) {
        if (!basis[i][0]) {
            null.push_back(Word(1) << i);
            continue;
        }
        Word equation = basis[i][0];
        if (__builtin_parityll(equation & (particular | constant))) particular |= Word(1) << i;
        for (Word& v : null)
            if (__builtin_parityll(equation & v)) v |= Word(1) << i;
    }
    if (int(null.size()) == d) return true;
    for (int i = 0; i < d; ++i)
        if (particular & (Word(1) << (i + 1))) add(root, directions[i], words, properties);
    std::vector<Phase> moved;
    for (Word v : null) {
        Phase phase;
        for (int i = 0; i < d; ++i)
            if (v & (Word(1) << (i + 1))) add(phase, directions[i], words, properties);
        moved.push_back(phase);
    }
    directions = std::move(moved);
    return true;
}

bool compatible(const Phase& phase, const std::vector<Moment>& moments, int properties) {
    for (int i = 0; i < properties; ++i) if (!phase.signature[i]) return false;
    for (const Moment& moment : moments)
        if ((weight(phase, moment) & moment.modulus_mask) != moment.residue) return false;
    return true;
}

void print_histogram(std::ostream& out, const std::map<int, Word>& data) {
    out << '{';
    bool comma = false;
    for (const auto& [dimension, count] : data) {
        if (comma) out << ',';
        out << '"' << dimension << "\":" << count;
        comma = true;
    }
    out << '}';
}

int main(int argc, char** argv) {
    if (argc != 4 && argc != 5) {
        std::cerr << "Usage: lower_dim_phase_count TASKS OUTPUT_PREFIX MAX_RESIDUAL_DIMENSION [PHASES]\n";
        return 2;
    }
    auto start = std::chrono::steady_clock::now();
    std::ifstream input(argv[1], std::ios::binary);
    std::string magic(8, '\0');
    input.read(magic.data(), 8);
    if (magic.compare(0, 7, "PHS3451") != 0) throw std::runtime_error("Bad phase plan");
    uint32_t space, words, properties, reserved;
    read(input, space);
    read(input, words);
    read(input, properties);
    read(input, reserved);
    if (!words || words > max_words || !properties || properties > max_properties || reserved)
        throw std::runtime_error("Invalid dimensions");
    const std::string prefix = argv[2];
    const int max_residual_dimension = std::stoi(argv[3]);
    const char* shard_env = std::getenv("PHASE_SHARD");
    const char* shards_env = std::getenv("PHASE_SHARDS");
    const Word shard = shard_env ? std::stoull(shard_env) : 0;
    const Word shards = shards_env ? std::stoull(shards_env) : 1;
    if (!shards || shard >= shards) throw std::runtime_error("Invalid phase shard");
    std::ofstream witnesses(prefix + ".witnesses.bin", std::ios::binary);
    std::ofstream deferred(prefix + ".deferred.bin", std::ios::binary);
    std::ofstream phases;
    if (argc == 5) phases.open(argv[4], std::ios::binary);
    if (argc == 5 && !phases) throw std::runtime_error("Cannot open phase output");
    Statistics result;
    while (input.peek() != EOF) {
        Word code;
        uint32_t d, multiplier, size;
        read(input, code);
        read(input, d);
        read(input, multiplier);
        read(input, size);
        if (d > max_dimension || multiplier + d > max_dimension || size > 4096)
            throw std::runtime_error("Invalid phase task");
        Phase root = read_phase(input, words, properties);
        std::vector<Phase> directions;
        for (unsigned i = 0; i < d; ++i) directions.push_back(read_phase(input, words, properties));
        std::vector<Moment> moments(size);
        for (Moment& moment : moments) {
            for (unsigned i = 0; i < words; ++i) {
                read(input, moment.mask[i]);
                if (moment.mask[i]) {
                    if (int(i) < moment.first) moment.first = i;
                    moment.stop = i + 1;
                }
            }
            uint8_t mask, residue;
            read(input, mask);
            read(input, residue);
            moment.modulus_mask = mask;
            moment.residue = residue;
        }
        result.tasks++;
        bool consistent = true;
        for (;;) {
            const auto before = directions.size();
            if (!reduce_quadratics(root, directions, moments, words, properties)) {
                consistent = false;
                break;
            }
            if (directions.size() == before) break;
        }
        if (!consistent) {
            result.inconsistent++;
            continue;
        }
        int residual = directions.size();
        result.residual_dimensions[residual]++;
        if (residual > max_residual_dimension) {
            result.deferred++;
            result.deferred_dimensions[residual]++;
            deferred.write(reinterpret_cast<char*>(&code), 8);
            continue;
        }
        result.tested_maps++;
        const Word trials = Word(1) << residual;
        const Word first_ordinal = trials * shard / shards;
        const Word stop_ordinal = trials * (shard + 1) / shards;
        const Word initial_gray = first_ordinal ^ (first_ordinal >> 1);
        for (int i = 0; i < residual; ++i)
            if (initial_gray & (Word(1) << i)) add(root, directions[i], words, properties);
        result.phase_trials += stop_ordinal - first_ordinal;
        Word count = 0;
        Phase first;
        for (Word word = first_ordinal; word < stop_ordinal; ++word) {
            if (word != first_ordinal) add(root, directions[__builtin_ctzll(word)], words, properties);
            if (!compatible(root, moments, properties)) continue;
            if (!count) first = root;
            if (argc == 5) {
                phases.write(reinterpret_cast<char*>(&code), 8);
                phases.write(reinterpret_cast<char*>(root.value.data()), 8 * words);
            }
            count++;
        }
        if (count) {
            result.maps++;
            count <<= multiplier;
            result.functions += count;
            witnesses.write(reinterpret_cast<char*>(&code), 8);
            witnesses.write(reinterpret_cast<char*>(&count), 8);
            witnesses.write(reinterpret_cast<char*>(first.value.data()), 8 * words);
        }
    }
    if (!witnesses || !deferred || (argc == 5 && !phases))
        throw std::runtime_error("Cannot write phase output");
    std::ofstream out(prefix + ".json");
    out << "{\n\"space\":" << space << ",\"tasks\":" << result.tasks
        << ",\"phase_shard\":" << shard << ",\"phase_shards\":" << shards
        << ",\"inconsistent\":" << result.inconsistent << ",\"deferred\":" << result.deferred
        << ",\"tested_maps\":" << result.tested_maps << ",\"maps\":" << result.maps
        << ",\"functions\":" << result.functions << ",\"phase_trials\":" << result.phase_trials
        << ",\"seconds\":" << std::chrono::duration<double>(std::chrono::steady_clock::now() - start).count()
        << ",\"residual_dimensions\":";
    print_histogram(out, result.residual_dimensions);
    out << ",\"deferred_dimensions\":";
    print_histogram(out, result.deferred_dimensions);
    out << "}\n";
    if (!out) throw std::runtime_error("Cannot write phase report");
    std::cout << "tasks " << result.tasks << " maps " << result.maps << " functions "
              << result.functions << " deferred " << result.deferred << '\n';
}
