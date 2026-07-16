# Redirections
echo "log line" > /tmp/out.log
echo "more" >> /tmp/out.log
grep pattern file.txt 2> /dev/null
make all > build.log 2>&1
cat < /tmp/out.log
