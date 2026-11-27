// buscar_fast.cpp — High-speed C++20/OpenMP polar census for H16 B0_00
// Exact optimizations:
//  1. Eliminates x_22 ^ x_29 = 0 (proven identical to Local 1 z=0x33), treating {22,29} as a weight-2 unit.
//  2. Variable-support outer split: A (21 vars, Local 0 z=0x01, prunes 61.4%) ->
//     B (8 vars, Local 3 z=0x11, prunes 25.8%) -> P ({22,29}) -> C (17 vars).
//  3. Incremental 64-bit low-word Pfaffian derivative vector lin_c[0..16] giving O(1) 1-XOR leaf checks;
//     full 128-bit verification runs only on 64-bit zero hits.
//  4. OpenMP parallelization over valid A states + optional shard_idx/num_shards CLI args for CI matrix runs.
//
// Build: g++ -O3 -march=native -std=c++20 -fopenmp buscar_fast.cpp -o buscar_fast
// Usage: ./buscar_fast <instancia.txt> <limit> <survivors.txt> [--exact-weight] [--min-weight W] [--shard S] [--n-shards N]

#include <algorithm>
#include <array>
#include <bit>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#ifdef _OPENMP
#include <omp.h>
#endif

constexpr int N = 48;
constexpr int K = 6;
constexpr int NA = 21;
constexpr int NB = 8;
constexpr int NC = 17;
constexpr int OFF_B = 21;
constexpr int OFF_P = 29; // 29 -> orig 22, 30 -> orig 29
constexpr int OFF_C = 31; // 31..47 -> C[0..16]

using u64 = std::uint64_t;
using u32 = std::uint32_t;
using u8  = std::uint8_t;

static int perm[N], invPerm[N];
static u64 bitMask[N];

static u64 constLo = 0, constHi = 0;
static u64 L_lo[N]{}, L_hi[N]{};
static u64 Q_lo[N * N]{}, Q_hi[N * N]{};
static u64 T_lo[N * N * N]{}, T_hi[N * N * N]{};
alignas(64) static u64 Q_c[N * NC]{};
alignas(64) static u64 T_c[N * N * NC]{};

static u32 d0[N]{}, d2[N]{}, d3[N]{}, d4[N]{}, d5[N]{};
static std::vector<u8> l0, l2, l3, l4, l5;

struct AState {
    u64 mask;
    u32 p2, p3, p4, p5;
    u32 bitsA;
    int w;
};

static std::vector<AState> validA;

static void collectA(int start, int w, int maxW, u64 mask, u32 bitsA,
                     u32 p0, u32 p2, u32 p3, u32 p4, u32 p5) {
    if (l0[p0]) {
        validA.push_back({mask, p2, p3, p4, p5, bitsA, w});
    }
    if (w == maxW) return;
    for (int i = start; i < NA; ++i) {
        collectA(i + 1, w + 1, maxW,
                 mask | bitMask[i], bitsA | (1u << i),
                 p0 ^ d0[i], p2 ^ d2[i], p3 ^ d3[i], p4 ^ d4[i], p5 ^ d5[i]);
    }
}

static bool verifyFull128(const int* sel, int w) {
    u64 lo = constLo, hi = constHi;
    for (int i = 0; i < w; ++i) {
        int a = sel[i];
        lo ^= L_lo[a]; hi ^= L_hi[a];
        int na = a * N;
        for (int j = i + 1; j < w; ++j) {
            int b = sel[j];
            int nab = na + b;
            lo ^= Q_lo[nab]; hi ^= Q_hi[nab];
            int nabN = nab * N;
            for (int k = j + 1; k < w; ++k) {
                int idx = nabN + sel[k];
                lo ^= T_lo[idx]; hi ^= T_hi[idx];
            }
        }
    }
    return (lo | hi) == 0;
}

static inline u64 addVar(const int* sel, int w, int u, u64 valLo,
                         const u64* __restrict linIn, u64* __restrict linOut) {
    u64 dv = L_lo[u];
    for (int i = 0; i < w; ++i) {
        int vi = sel[i];
        dv ^= Q_lo[vi * N + u];
        const u64* tRow = &T_lo[(vi * N + u) * N];
        for (int j = i + 1; j < w; ++j) {
            dv ^= tRow[sel[j]];
        }
    }
    const u64* qRow = &Q_c[u * NC];
    for (int ci = 0; ci < NC; ++ci) linOut[ci] = linIn[ci] ^ qRow[ci];
    for (int i = 0; i < w; ++i) {
        const u64* tRow = &T_c[(sel[i] * N + u) * NC];
        for (int ci = 0; ci < NC; ++ci) linOut[ci] ^= tRow[ci];
    }
    return valLo ^ dv;
}

struct ThreadCtx {
    u64 cShort[N + 1]{};
    u64 cPf[N + 1]{};
    std::vector<u64> surv;
    int sel[N]{};
    alignas(64) u64 linStack[N + 2][NC]{};
    int minW = 0, maxW = 0;

    void searchC(int startC, int w, u64 mask, u32 p2, u32 p4, u32 p5,
                 u64 valLo, int depth) {
        const u64* lin = linStack[depth];
        if (w >= minW) {
            if (l2[p2] && l4[p4] && l5[p5]) {
                ++cShort[w];
                if (valLo == 0 && verifyFull128(sel, w)) {
                    ++cPf[w];
                    surv.push_back(mask);
                }
            }
        }
        if (w == maxW) return;
        if (w + 1 == maxW) {
            const int targetW = maxW;
            const u8* __restrict L2 = l2.data();
            const u8* __restrict L4 = l4.data();
            const u8* __restrict L5 = l5.data();
            for (int ci = startC; ci < NC; ++ci) {
                int idx = OFF_C + ci;
                if (L2[p2 ^ d2[idx]] && L4[p4 ^ d4[idx]] && L5[p5 ^ d5[idx]]) {
                    ++cShort[targetW];
                    if ((valLo ^ lin[ci]) == 0) {
                        sel[w] = idx;
                        if (verifyFull128(sel, targetW)) {
                            ++cPf[targetW];
                            surv.push_back(mask | bitMask[idx]);
                        }
                    }
                }
            }
            return;
        }
        u64* nextLin = linStack[depth + 1];
        int remNeeded = minW - w - 1;
        int maxStart = (remNeeded > 0) ? (NC - remNeeded) : NC;
        for (int ci = startC; ci < maxStart; ++ci) {
            int u = OFF_C + ci;
            u64 nextVal = valLo ^ lin[ci];
            const u64* qRow = &Q_c[u * NC];
            for (int cj = ci + 1; cj < NC; ++cj) nextLin[cj] = lin[cj] ^ qRow[cj];
            for (int i = 0; i < w; ++i) {
                const u64* tRow = &T_c[(sel[i] * N + u) * NC];
                for (int cj = ci + 1; cj < NC; ++cj) nextLin[cj] ^= tRow[cj];
            }
            sel[w] = u;
            searchC(ci + 1, w + 1, mask | bitMask[u],
                    p2 ^ d2[u], p4 ^ d4[u], p5 ^ d5[u],
                    nextVal, depth + 1);
        }
    }

    void searchPAndC(int w, u64 mask, u32 p2, u32 p4, u32 p5, u64 valLo, int depth) {
        if (w + NC >= minW) {
            searchC(0, w, mask, p2, p4, p5, valLo, depth);
        }
        if (w + 2 <= maxW && w + 2 + NC >= minW) {
            u64* tmp  = linStack[depth + 1];
            u64* next = linStack[depth + 2];
            u64 v1 = addVar(sel, w, OFF_P, valLo, linStack[depth], tmp);
            sel[w] = OFF_P;
            u64 v2 = addVar(sel, w + 1, OFF_P + 1, v1, tmp, next);
            sel[w + 1] = OFF_P + 1;
            searchC(0, w + 2,
                    mask | bitMask[OFF_P] | bitMask[OFF_P + 1],
                    p2 ^ d2[OFF_P] ^ d2[OFF_P + 1],
                    p4 ^ d4[OFF_P] ^ d4[OFF_P + 1],
                    p5 ^ d5[OFF_P] ^ d5[OFF_P + 1],
                    v2, depth + 2);
        }
    }

    void searchB(int startB, int w, u64 mask, u32 p2, u32 p3, u32 p4, u32 p5,
                 u64 valLo, int depth) {
        if (l3[p3]) {
            searchPAndC(w, mask, p2, p4, p5, valLo, depth);
        }
        if (w == maxW) return;
        const u64* curLin = linStack[depth];
        u64* nextLin = linStack[depth + 1];
        for (int bi = startB; bi < NB; ++bi) {
            int u = OFF_B + bi;
            u64 nextVal = addVar(sel, w, u, valLo, curLin, nextLin);
            sel[w] = u;
            searchB(bi + 1, w + 1, mask | bitMask[u],
                    p2 ^ d2[u], p3 ^ d3[u], p4 ^ d4[u], p5 ^ d5[u],
                    nextVal, depth + 1);
        }
    }

    void processA(const AState& st) {
        int w = 0;
        u64 valLo = constLo;
        u64* cur = linStack[0];
        for (int ci = 0; ci < NC; ++ci) cur[ci] = L_lo[OFF_C + ci];
        for (int i = 0; i < NA; ++i) {
            if ((st.bitsA >> i) & 1u) {
                u64* nxt = linStack[w + 1];
                valLo = addVar(sel, w, i, valLo, cur, nxt);
                sel[w] = i;
                cur = nxt;
                ++w;
            }
        }
        searchB(0, w, st.mask, st.p2, st.p3, st.p4, st.p5, valLo, w);
    }
};

static u64 comb(int n, int k) {
    if (k < 0 || k > n) return 0;
    if (k > n - k) k = n - k;
    u64 r = 1;
    for (int i = 1; i <= k; ++i) r = r * static_cast<u64>(n - k + i) / static_cast<u64>(i);
    return r;
}

int main(int argc, char** argv) {
    if (argc < 4) {
        std::cerr << "Usage: buscar_fast <instancia.txt> <limit> <survivors.txt> "
                     "[--exact-weight] [--min-weight W] [--shard S] [--n-shards N]\n";
        return 1;
    }
    std::string instPath = argv[1];
    int maxW = std::stoi(argv[2]);
    std::string outPath = argv[3];
    int minW = 0;
    int shardIdx = 0;
    int numShards = 1;
    for (int i = 4; i < argc; ++i) {
        std::string arg = argv[i];
        if (arg == "--exact-weight") {
            minW = maxW;
        } else if (arg == "--min-weight" && i + 1 < argc) {
            minW = std::stoi(argv[++i]);
        } else if (arg == "--shard" && i + 1 < argc) {
            shardIdx = std::stoi(argv[++i]);
        } else if (arg == "--n-shards" && i + 1 < argc) {
            numShards = std::stoi(argv[++i]);
        } else {
            std::cerr << "Unknown or incomplete option: " << arg << '\n';
            return 1;
        }
    }
    if (minW < 0 || maxW > N || minW > maxW || shardIdx < 0 || shardIdx >= numShards || numShards <= 0) {
        std::cerr << "Invalid weight or shard arguments\n";
        return 2;
    }

    std::ifstream file(instPath);
    if (!file) return 2;

    unsigned m = 0;
    file >> m;
    struct Term { u64 mask, lo, hi; };
    std::vector<Term> terms(m);
    for (unsigned i = 0; i < m; ++i) {
        file >> terms[i].mask >> terms[i].lo >> terms[i].hi;
    }
    u32 rawD[K][N]{};
    std::vector<u8> rawL[K];
    for (int i = 0; i < K; ++i) {
        unsigned z = 0, size = 0;
        file >> z >> size;
        for (int j = 0; j < N; ++j) file >> rawD[i][j];
        rawL[i].resize(size);
        for (unsigned j = 0; j < size; ++j) {
            unsigned v = 0;
            file >> v;
            rawL[i][j] = v ? 1 : 0;
        }
    }
    if (!file) return 2;

    std::vector<int> listA, listB, listC;
    for (int j = 0; j < N; ++j) {
        if (j == 22 || j == 29) continue;
        if (rawD[0][j] != 0) listA.push_back(j);
        else if (rawD[3][j] != 0) listB.push_back(j);
        else listC.push_back(j);
    }
    if ((int)listA.size() != NA || (int)listB.size() != NB || (int)listC.size() != NC) {
        std::cerr << "Unexpected partition sizes\n";
        return 2;
    }
    int p = 0;
    for (int j : listA) perm[p++] = j;
    for (int j : listB) perm[p++] = j;
    perm[p++] = 22;
    perm[p++] = 29;
    for (int j : listC) perm[p++] = j;

    for (int i = 0; i < N; ++i) {
        invPerm[perm[i]] = i;
        bitMask[i] = u64(1) << perm[i];
        d0[i] = rawD[0][perm[i]];
        d2[i] = rawD[2][perm[i]];
        d3[i] = rawD[3][perm[i]];
        d4[i] = rawD[4][perm[i]];
        d5[i] = rawD[5][perm[i]];
    }
    l0 = std::move(rawL[0]);
    l2 = std::move(rawL[2]);
    l3 = std::move(rawL[3]);
    l4 = std::move(rawL[4]);
    l5 = std::move(rawL[5]);

    for (const auto& t : terms) {
        u64 mask = t.mask;
        int idx[3]{};
        int deg = 0;
        for (; mask; mask &= mask - 1) {
            if (deg >= 3) return 2;
            int bit = std::countr_zero(mask);
            if (bit >= N) return 2;
            idx[deg++] = invPerm[bit];
        }
        if (deg == 0) { constLo = t.lo; constHi = t.hi; }
        else if (deg == 1) { L_lo[idx[0]] = t.lo; L_hi[idx[0]] = t.hi; }
        else if (deg == 2) {
            int a = idx[0], b = idx[1];
            Q_lo[a * N + b] = Q_lo[b * N + a] = t.lo;
            Q_hi[a * N + b] = Q_hi[b * N + a] = t.hi;
        } else if (deg == 3) {
            int a = idx[0], b = idx[1], c = idx[2];
            const int ps[6][3] = {{a,b,c},{a,c,b},{b,a,c},{b,c,a},{c,a,b},{c,b,a}};
            for (const auto& q : ps) {
                int pos = (q[0] * N + q[1]) * N + q[2];
                T_lo[pos] = t.lo;
                T_hi[pos] = t.hi;
            }
        }
    }
    for (int u = 0; u < N; ++u) {
        for (int ci = 0; ci < NC; ++ci) {
            Q_c[u * NC + ci] = Q_lo[u * N + (OFF_C + ci)];
        }
        for (int v = 0; v < N; ++v) {
            for (int ci = 0; ci < NC; ++ci) {
                T_c[(u * N + v) * NC + ci] = T_lo[(u * N + v) * N + (OFF_C + ci)];
            }
        }
    }

    auto t0 = std::chrono::steady_clock::now();
    collectA(0, 0, maxW, 0, 0, 0, 0, 0, 0, 0);

    u64 totalShort[N + 1]{};
    u64 totalPf[N + 1]{};
    std::vector<u64> allSurv;

    int numA = static_cast<int>(validA.size());

    #pragma omp parallel
    {
        ThreadCtx ctx;
        ctx.minW = minW;
        ctx.maxW = maxW;

        #pragma omp for schedule(dynamic, 64)
        for (int i = shardIdx; i < numA; i += numShards) {
            ctx.processA(validA[i]);
        }

        #pragma omp critical
        {
            for (int w = minW; w <= maxW; ++w) {
                totalShort[w] += ctx.cShort[w];
                totalPf[w] += ctx.cPf[w];
            }
            allSurv.insert(allSurv.end(), ctx.surv.begin(), ctx.surv.end());
        }
    }

    std::sort(allSurv.begin(), allSurv.end());
    double elapsed = std::chrono::duration<double>(std::chrono::steady_clock::now() - t0).count();

    std::ofstream out(outPath);
    for (u64 mask : allSurv) out << std::hex << mask << std::dec << '\n';
    if (!out) return 3;

    for (int w = minW; w <= maxW; ++w) {
        u64 allCount = (numShards == 1) ? comb(N, w) : 0;
        std::cout << w << ' ' << allCount << ' ' << totalShort[w] << ' ' << totalPf[w] << '\n';
    }
    int threads = 1;
    #ifdef _OPENMP
    threads = omp_get_max_threads();
    #endif
    std::cerr << "Elapsed: " << elapsed << " s (validA=" << numA
              << ", shard=" << shardIdx << "/" << numShards
              << ", threads=" << threads << ")\n";
    return 0;
}
