# shellcheck disable=SC2148
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

current_tty=$(tty)

if [[ $current_tty == /dev/pts* ]]; then
  eval "$(starship init bash)"
fi

alias fastfetch-image='fastfetch -c ~/.config/fastfetch/config-image.jsonc'
alias i-use-arch-btw='fastfetch -c ~/.config/fastfetch/config-image.jsonc --logo arch'
alias wkill='hyprctl kill'
alias neofetch='fastfetch -c neofetch'
alias iscc="wine ~/.wine/drive_c/users/xgui4/AppData/Local/Programs/iss/ISCC.exe"


eval "$(bat --completion bash)"
