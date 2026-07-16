# A small real-world style script: back up dotfiles
function backup_dotfiles --argument-names target
    if test -z "$target"
        set target ~/backups
    end
    mkdir -p $target
    for file in ~/.config/fish/*.fish
        cp $file $target/ && echo "copied $file"
    end
    begin
        echo "backup finished at (date)"
        echo "target: $target"
    end > $target/backup.log 2>&1
    return 0
end

backup_dotfiles $argv[1]
