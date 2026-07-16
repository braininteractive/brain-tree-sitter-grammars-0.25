# Conditionals
if test -f /etc/hosts
    echo "hosts file exists"
else if test -d /etc
    echo "etc is a directory"
else
    echo "nothing found"
end
