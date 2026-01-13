#
# ~/.profile
#

if [ "$XDG_SESSION_TYPE" = "x11" ]; then
   export QT_QPA_PLATFORMTHEME=qt5ct
   export QT_QPA_PLATFORM=xcb
fi
