var f = {|x @rest| put $x $rest }
var thunk = { echo deferred }
each {|line| echo $line } $lines
peach {|n &opt=1| + $n $opt } $nums
