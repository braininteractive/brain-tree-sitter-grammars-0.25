# Conditional execution with && and ||, plus and/or keywords
mkdir -p /tmp/demo && cd /tmp/demo || echo "failed to enter"
test -f config.fish && echo "config found"
false; or echo "fell through"
true; and echo "chained"
not test -d missing && echo "no such dir"
