BEGIN { OFS = "\t"; print "a", "b" > "/dev/stderr" }
{ $1 = $1; print }
