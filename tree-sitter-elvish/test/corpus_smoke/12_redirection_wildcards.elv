echo log line > out.txt
cat < in.txt
echo more >> out.txt
put *.go **[type:dir]
run-parallel { sleep 1 } &
