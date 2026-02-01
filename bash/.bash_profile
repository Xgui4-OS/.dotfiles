# shellcheck disable=SC2148
#
# ~/.bash_profile
#

# shellcheck disable=SC1090
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ "$XDG_SESSION_TYPE" = "x11" ]; then
   export env QT_QPA_PLATFORMTHEME=qt6ct
fi
