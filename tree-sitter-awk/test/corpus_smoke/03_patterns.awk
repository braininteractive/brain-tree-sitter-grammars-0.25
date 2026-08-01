/^#/ { next }
NF > 3 && $2 ~ /warn/i { print NR": "$0 }
