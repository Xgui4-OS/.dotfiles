----------------------------------------------------
-- HyprArch 0.1.1 (Lua/Hyprland 0.55 Update)   ----
--  By Xgui4                                   ----
----------------------------------------------------

------------------
---- MONITORS ----
------------------

require("monitors")

-------------------
---- PROGRAMS ----
-------------------

terminal = "kitty"  -- default terminal 
fileManager = "dolphin" -- default file manager
browser = "firefox" -- default browser
menu = "rofi" -- default launcher/menu 
emoji = "rofimoji --action copy clipboard" -- default emoji picker
clipboardManager = "copyq" -- defaiut clipboard manager 
local screenshotUtiliy = "hyprshot -m region" -- default screenshot utility

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("copyq")
    hl.exec_cmd("hyprpm reload")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("XDG_MENU_PREFIX=kde- kbuildsycoca6")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
    hl.exec_cmd("qs -c overview") 
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "25")
hl.env("HYPRCURSOR_SIZE", "25")

-- Themes
hl.env("QT_QPA_PLATFORMTHEME","qt6ct") -- for Qt6 apps
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- Toolkit backends 
hl.env("GDK_BACKEND", "wayland, x11")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland, x11, windows")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Fix for dolphin 
hl.env("XDG_MENU_PREFIX","arch-")

-- XDG specifications 
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Others 
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

require("nvidia")

-----------------------
---- LOOK AND FEEL ----
-----------------------

require("appearence")

---------------
---- INPUT ----
---------------

require("input")

---------------------
---- PERMISSIONs ----
---------------------

require("permission")

---------------------
---- KEYBINDINGS ----"
---------------------

-- require("keybinding.lua")
require("keybinding")
hl.bind("PRINT" .. "", hl.dsp.exec_cmd(screenshotUtiliy))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- require("windows-rule.lua")
require("windows-rule")

------------------
-- Fix for apps --
-------------------

-- TODO : Find the new synthax
-- xwayland:force_zero_scaling = true

--------------------
-- Plugins config --
---------------------

-- require("plugins")
