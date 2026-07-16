machine char_classes;

lower_case = [a-z];
mixed = [a-zA-Z0-9_];
negated = [^"\n];
punct = [.,;:!?];
escapes = [\t\n\r ];
main := lower_case . mixed . negated . punct . escapes;
