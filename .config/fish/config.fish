if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

abbr --add v nvim
abbr --add vi nvim
abbr --add vim nvim
abbr --add zshalias v ~/.config/zsh/custom/aliases.zsh
abbr --add pmain poetry run python main.py
abbr --add ytdl yt-dlp -P home:/home/lush/動画/ytdl

abbr --add wine LANG=EN wine

abbr --add h hyprland
abbr --add drag dragon-drop

#eza
abbr --add e eza -l --time-style '+%Y年%m月%d日 %H:%M'
abbr --add eg eza -l --git --git-repos --time-style '+%Y年%m月%d日 %H:%M'
abbr --add ez eza

abbr --add n n -deA

abbr --add mpv mpv --target-colorspace-hint-mode=source

function ytdrag
    set dlfile $(ytdl --quiet --print after_move:filepath $1)
    dragon-drop $dlfile
    echo $dlfile
end
