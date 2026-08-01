BEGIN { FS = ","; count = 0 }
{ count++ }
END { print "rows:", count }
