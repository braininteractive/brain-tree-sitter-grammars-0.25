machine ops;

# union, intersection, subtraction, strong subtraction
letters = lower | upper;
consonants = letters & !vowels;
not_quote = any - '"';
no_comment = any -- '#';
main := letters | consonants;
