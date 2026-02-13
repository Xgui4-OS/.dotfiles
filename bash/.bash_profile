# shellcheck disable=SC2148
#
# ~/.bash_profile
#

# shellcheck disable=SC1090
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ "$XDG_SESSION_TYPE" = "x11" ]; then
   export MOZ_USE_XINPUT2=1
   export QT_QPA_PLATFORMTHEME=qt6ct
   export XDG_MENU_PREFIX=arch
fi

export PATH=$HOME/.config/emacs/bin:$PATH

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
export PATH="$PATH:/usr/local/bin/"
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR="/tmp/$(id -u)-runtime"
    mkdir -pm 700 "$XDG_RUNTIME_DIR"
fi
