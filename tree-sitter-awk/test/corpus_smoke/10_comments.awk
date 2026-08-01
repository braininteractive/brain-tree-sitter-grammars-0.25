# full program comment
NR == 1 { header = $0; next } # inline
{ data[NR] = $0 }
END { print header; for (k in data) print data[k] }
