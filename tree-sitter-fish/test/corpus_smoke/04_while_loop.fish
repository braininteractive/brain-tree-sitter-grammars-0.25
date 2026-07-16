# Count down with a while loop
set count 5
while test $count -gt 0
    echo "count is $count"
    set count (math $count - 1)
end
