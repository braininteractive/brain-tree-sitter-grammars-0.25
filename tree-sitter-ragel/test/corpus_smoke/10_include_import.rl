machine composed;

include base;
include tokens "tokens.rl";
include "common.rl";
import "definitions.rl";

main := base_rule . token_rule;
