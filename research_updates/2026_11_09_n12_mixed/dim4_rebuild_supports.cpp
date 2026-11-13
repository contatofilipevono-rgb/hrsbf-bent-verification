#include <array>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <vector>

template<typename T> T read(std::istream& in) {
    T value;
    if (!in.read(reinterpret_cast<char*>(&value), sizeof(value))) throw std::runtime_error("Truncated input");
    return value;
}

using Map = std::array<uint64_t, 16>;

int main(int argc, char** argv) {
    if (argc != 3) return 2;
    std::ifstream input(argv[1], std::ios::binary);
    std::ofstream output(argv[2], std::ios::binary);
    const auto charts = read<uint32_t>(input);
    std::array<uint64_t, 256> moments{};
    for (unsigned x = 0; x < 256; ++x) {
        moments[x] = x;
        unsigned bit = 8;
        for (unsigned i = 0; i < 8; ++i)
            for (unsigned j = i+1; j < 8; ++j, ++bit)
                if ((x >> i & 1) && (x >> j & 1)) moments[x] |= uint64_t(1) << bit;
    }
    uint64_t tested = 0, survived = 0;
    for (unsigned chart = 0; chart < charts; ++chart) {
        const auto dimension = read<uint32_t>(input);
        if (dimension > 25) throw std::runtime_error("Invalid chart dimension");
        auto code = read<uint64_t>(input);
        auto labels = read<Map>(input);
        std::vector<uint64_t> code_directions(dimension);
        std::vector<Map> directions(dimension);
        for (unsigned i = 0; i < dimension; ++i) {
            code_directions[i] = read<uint64_t>(input);
            directions[i] = read<Map>(input);
        }
        for (unsigned x = 0; x < (1u << dimension); ++x) {
            if (x) {
                const unsigned j = __builtin_ctz(x);
                code ^= code_directions[j];
                for (unsigned i = 0; i < 16; ++i) labels[i] ^= directions[j][i];
            }
            ++tested;
            std::array<uint8_t, 16> size{};
            std::array<uint64_t, 16> sums{};
            bool balanced = true;
            for (unsigned i = 0; i < 256; ++i) {
                const unsigned label = (labels[i / 16] >> (4 * (i % 16))) & 15;
                if (++size[label] > 16) {
                    balanced = false;
                    break;
                }
                sums[label] ^= moments[i];
            }
            if (!balanced) continue;
            bool self_orthogonal = true;
            for (auto sum : sums) if (sum) self_orthogonal = false;
            if (self_orthogonal) {
                ++survived;
                output.write(reinterpret_cast<const char*>(&code), sizeof(code));
            }
        }
    }
    if (!output) throw std::runtime_error("Failed to write survivors");
    std::cout << "Tested " << tested << " reduced maps, reconstructed " << survived << " supports.\n";
}
