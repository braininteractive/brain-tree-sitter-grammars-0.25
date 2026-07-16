# A small numeric scanner, spec only (no actions).
machine number;

sign = '-' | '+';
integer = sign? . digit+;
fraction = '.' . digit+;
exponent = ('e' | 'E') . sign? . digit+;
float = integer . fraction? . exponent?;

main := float . '\n';
