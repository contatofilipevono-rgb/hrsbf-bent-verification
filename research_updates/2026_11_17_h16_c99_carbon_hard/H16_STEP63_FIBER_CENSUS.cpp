// Exhaustively test a specified affine slice of a reduced H16 fiber.
#include <algorithm>
#include <array>
#include <bit>
#include <chrono>
#include <cstdint>
#include <iostream>
#include <stdexcept>
#include <vector>

using Word = std::uint64_t;
using Matrix = std::array<Word, 24>;

struct Tail {
    Word transfer = 0;
    Word rhs = 0;
    Tail& operator^=(const Tail& other) {
        transfer ^= other.transfer;
        rhs ^= other.rhs;
        return *this;
    }
};
struct Term {
    std::uint32_t mask;
    Tail value;
};

bool consistent(const Matrix& a, const Tail& b) {
    Word pivots[63] = {};
    for (int col = 0; col < 25; ++col) {
        Word value = col < 24 ? a[col] : b.transfer;
        while (value) {
            auto lead = std::countr_zero(value);
            if (!pivots[lead]) {
                pivots[lead] = value;
                break;
            }
            value ^= pivots[lead];
        }
    }
    for (Word remainder = b.rhs; remainder;) {
        auto lead = std::countr_zero(remainder);
        if (!pivots[lead]) return false;
        remainder ^= pivots[lead];
    }
    return true;
}

struct RowCheck {
    bool consistent;
    std::uint32_t model;
};

RowCheck row_check(const Matrix& a, const Tail& b) {
    std::uint32_t pivots[25] = {};
    for (int row = 0; row < 63; ++row) {
        std::uint32_t value = ((b.transfer >> row) & 1) << 24;
        value |= ((b.rhs >> row) & 1) << 25;
        for (int c = 0; c < 24; ++c) value |= ((a[c] >> row) & 1) << c;
        while (value & ((1u << 25) - 1)) {
            auto lead = std::countr_zero(value);
            if (!pivots[lead]) {
                pivots[lead] = value;
                break;
            }
            value ^= pivots[lead];
        }
        if (value == 1u << 25) return {false, 0};
    }
    std::uint32_t model = 0;
    for (int i = 24; i >= 0; --i)
        if (pivots[i] &&
            ((std::popcount(pivots[i] & model) ^ (pivots[i] >> 25)) & 1))
            model |= 1u << i;
    Word product = (model >> 24) & 1 ? b.transfer : 0;
    for (int i = 0; i < 24; ++i)
        if (model >> i & 1) product ^= a[i];
    if (product != b.rhs) throw std::runtime_error("invalid reconstructed model");
    return {true, model};
}

int main() {
    int dim, count;
    if (!(std::cin >> dim >> count) || dim < 1 || dim > 30) return 2;
    std::vector<Matrix> slopes(dim + 1);
    for (auto& a : slopes)
        for (auto& column : a) std::cin >> column;
    std::vector<Term> terms(count);
    for (auto& t : terms) std::cin >> t.mask >> t.value.transfer >> t.value.rhs;
    if (!std::cin) return 3;

    const auto start = std::chrono::steady_clock::now();
    const int low = dim < 10 ? dim : 10;
    const auto low_count = 1u << low;
    const auto low_mask = low_count - 1;
    std::vector<Matrix> offsets(low_count);
    for (unsigned p = 1; p < low_count; ++p) {
        const auto k = std::countr_zero(p);
        offsets[p] = offsets[p & (p - 1)];
        for (int c = 0; c < 24; ++c) offsets[p][c] ^= slopes[k + 1][c];
    }
    std::vector<Tail> values(low_count);
    const auto upper_count = 1u << (dim - low);
    std::uint64_t survivors = 0, checks = 0;
    for (unsigned hi = 0; hi < upper_count; ++hi) {
        const auto head = hi << low;
        auto base = slopes[0];
        for (auto p = head; p; p &= p - 1) {
            const auto k = std::countr_zero(p);
            for (int c = 0; c < 24; ++c) base[c] ^= slopes[k + 1][c];
        }
        std::fill(values.begin(), values.end(), Tail{});
        for (auto term : terms) {
            const auto high = term.mask & ~low_mask;
            if ((high & head) == high) values[term.mask & low_mask] ^= term.value;
        }
        for (unsigned bit = 1; bit < low_count; bit <<= 1)
            for (unsigned block = 0; block < low_count; block += 2 * bit)
                for (unsigned q = block; q < block + bit; ++q)
                    values[q + bit] ^= values[q];

        for (unsigned lo = 0; lo < low_count; ++lo) {
            const auto p = head | lo;
            Matrix a;
            for (int c = 0; c < 24; ++c) a[c] = base[c] ^ offsets[lo][c];
            const auto& value = values[lo];
            const bool sat = consistent(a, value);
            if (sat || (lo == (hi & low_mask) && hi % 16 == 0)) {
                Matrix direct = slopes[0];
                for (auto m = p; m; m &= m - 1) {
                    const auto k = std::countr_zero(m);
                    for (int c = 0; c < 24; ++c) direct[c] ^= slopes[k + 1][c];
                }
                Tail direct_rhs;
                for (auto term : terms)
                    if ((p & term.mask) == term.mask) direct_rhs ^= term.value;
                const auto checked = row_check(direct, direct_rhs);
                if (a != direct || value.transfer != direct_rhs.transfer ||
                    value.rhs != direct_rhs.rhs || sat != checked.consistent)
                    throw std::runtime_error("evaluation or rank mismatch");
                ++checks;
                if (sat) {
                    std::cout << "MODEL " << p << ' ' << checked.model << '\n';
                    ++survivors;
                }
            }
        }
    }
    const std::chrono::duration<double> elapsed = std::chrono::steady_clock::now() - start;
    std::cout << "COUNTS " << (1ULL << dim) << ' ' << survivors << ' ' << checks
              << ' ' << elapsed.count() << '\n';
}
