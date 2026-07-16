# Variables and set
set -gx EDITOR vim
set -l name "fish shell"
set --universal fish_greeting ""
echo $name
echo $argv[1] $argv[2]
echo $PATH[1]
set -e name
