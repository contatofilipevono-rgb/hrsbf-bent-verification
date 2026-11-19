#include <algorithm>
#include <cstdint>
#include <iostream>
#include <vector>

using Word = uint64_t;

int rank_through(const std::vector<Word>& rows, int cutoff) {
    Word pivots[64] = {};
    int rank = 0;
    for (Word row : rows) {
        while (row) {
            const int lead = 63 - __builtin_clzll(row);
            if (!pivots[lead]) {
                pivots[lead] = row;
                if (++rank > cutoff) return rank;
                break;
            }
            row ^= pivots[lead];
        }
    }
    return rank;
}

void visit(const std::vector<std::vector<Word>>& slices, std::vector<Word>& sum,
           int start, int remaining, Word mask) {
    if (!remaining) {
        const int rank = rank_through(sum, 10);
        if (rank <= 10) std::cout << mask << ' ' << rank << '\n';
        return;
    }
    for (int k = start; k + remaining <= int(slices.size()); ++k) {
        for (size_t r = 0; r < sum.size(); ++r) sum[r] ^= slices[k][r];
        visit(slices, sum, k + 1, remaining - 1, mask | (Word(1) << k));
        for (size_t r = 0; r < sum.size(); ++r) sum[r] ^= slices[k][r];
    }
}

int main() {
    int slices, rows, limit;
    if (!(std::cin >> slices >> rows >> limit) || slices < 1 || slices > 63) return 2;
    std::vector<std::vector<Word>> matrices(slices, std::vector<Word>(rows));
    for (auto& slice : matrices) for (Word& row : slice) if (!(std::cin >> row)) return 2;
    std::vector<Word> sum(rows);
    for (int weight = 1; weight <= limit; ++weight)
        visit(matrices, sum, 0, weight, 0);
}
