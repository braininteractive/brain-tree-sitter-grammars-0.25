{ print substr($0, index($0, ":") + 1) }
$0 ~ /\/escaped\/path/ { print "matched" }
