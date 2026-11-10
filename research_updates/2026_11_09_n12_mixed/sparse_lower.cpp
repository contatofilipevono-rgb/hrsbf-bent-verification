// Reuse the independently verified packed Walsh engine without its CLI.
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wreturn-type"
#define main n12_quartic_catalog_entry
#include "completions.cpp"
#undef main
#pragma GCC diagnostic pop

int main(int argc, char** argv) {
    try {
        require(argc == 2, "Usage: sparse_lower output-directory");
        const std::filesystem::path output(argv[1]);
        std::filesystem::create_directories(output);
        std::ofstream hits(output / "bent.tsv");
        require(bool(hits), "Could not open witness list");
        const Basis b;
        b.validate_control();
        auto high_orbits = orbits(5);
        const auto sextic = orbits(6);
        high_orbits.insert(high_orbits.end(), sextic.begin(), sextic.end());
        unsigned index = 0, dimension = 0;
        require(bool(std::cin >> index >> dimension), "Missing kernel header");
        require(index < high_orbits.size() && dimension <= lower_count, "Invalid header");
        const Packed high = b.polynomial(high_orbits[index]);
        std::vector<unsigned> kernel_codes(dimension);
        std::vector<Packed> kernel(dimension);
        for (unsigned i = 0; i < dimension; ++i) {
            require(bool(std::cin >> kernel_codes[i]), "Missing kernel vector");
            require(kernel_codes[i] < (1u << lower_count), "Invalid kernel vector");
            kernel[i] = Basis::combine(b.lower_tables, kernel_codes[i]);
        }
        const unsigned limit = 1u << dimension;
        std::uint64_t top = 0, trials = 0, bent = 0, tasks = 0;
        unsigned lower = 0;
        while (std::cin >> top >> lower) {
            require(top < (std::uint64_t{1} << top_count) && lower < (1u << lower_count),
                    "Invalid task coordinates");
            Packed fixed = high;
            xor_into(fixed, Basis::combine(b.top_tables, top));
            Packed current = fixed;
            xor_into(current, Basis::combine(b.lower_tables, lower));
            require(b.admissible[b.projection(current)], "Invalid period-four root");
            for (unsigned step = 0; step < limit; ++step) {
                if (step) {
                    const unsigned j = std::countr_zero(step);
                    xor_into(current, kernel[j]);
                    lower ^= kernel_codes[j];
                }
                const int weight = b.tests.front().sum(current);
                if (weight != 2016 && weight != 2080) continue;
                bool good = true;
                for (auto it = b.tests.begin() + 1; it != b.tests.end(); ++it) {
                    const int sum = it->sum(current);
                    if (sum != 32 && sum != -32) {
                        good = false;
                        break;
                    }
                }
                if (!good) continue;
                Packed check = fixed;
                xor_into(check, Basis::combine(b.lower_tables, lower));
                require(check == current && b.full_walsh(check), "Independent replay failed");
                hits << index << '\t' << top << '\t' << lower << '\n';
                ++bent;
            }
            trials += limit;
            ++tasks;
        }
        require(std::cin.eof() && bool(hits), "Task input or witness output failed");
        std::ofstream totals(output / "totals.tsv");
        totals << tasks << '\t' << trials << '\t' << bent << '\n';
        require(bool(totals), "Could not write totals");
    } catch (const std::exception& e) {
        std::cerr << e.what() << '\n';
        return 1;
    }
    return 0;
}
