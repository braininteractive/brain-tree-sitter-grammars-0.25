# Switch on the first argument
switch $argv[1]
    case start
        echo "starting"
    case stop halt
        echo "stopping"
    case '*'
        echo "unknown command"
end
