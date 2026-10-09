# Counting consequence

The canonical family has one EA class per isomorphism class of loopless directed graphs. There are 2^(r*(r-1)) labeled graphs, and each isomorphism class has at most r! labeled representatives. Hence the number of EA classes represented by the family is at least ceil(2^(r*(r-1))/r!). All members have exact relaxed index r. The counting argument is not yet Lean formalized.
