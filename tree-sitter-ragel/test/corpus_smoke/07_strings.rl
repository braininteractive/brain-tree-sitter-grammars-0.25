machine strings;

single = 'hello';
double = "world";
caseless = 'Hello'i;
escaped = 'line\n\ttab';
quoted = "she said \"hi\"";
main := single . double . caseless . escaped . quoted;
