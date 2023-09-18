-- Standard awesome library
gears = require("gears")
awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
naughty = require("naughty")
menubar = require("menubar")
hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


modkey = "Mod4"

terminal = "kitty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.fair,
    awful.layout.suit.spiral,
    awful.layout.suit.floating,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}


-- global widgets 


Themes = {
    actual = 1,
    theme = {
        {
            fg_normal     = "#838EB3",
            fg_focus      = "#FFFEE0",
            fg_urgent     = "#838EB3",

            bg_normal     = "#101216",
            bg_focus      = "#2F3041",
            bg_urgent     = "#838EB3",
            bg_systray    = bg_normal,

            border_normal = "#101216",
            border_focus  = "#838EB3",
            border_marked = "#838EB3",

            titlebar_bg_focus  = "#838EB3",
            titlebar_bg_normal = "#101216",

            wallpaper     = ".config/awesome/themes/mytheme/background.jpg",

            rofi_config   = "~/.config/rofi/rofi.rasi",
        },
        {
            fg_normal     = "#90A8A0",
            fg_focus      = "#F6FBE8",
            fg_urgent     = "#90A8A0",

            bg_normal     = "#000E13",
            bg_focus      = "#19332F",
            bg_urgent     = "#90A8A0",
            bg_systray    = bg_normal,

            border_normal = "#000E13",
            border_focus  = "#90A8A0",
            border_marked = "#90A8A0",

            titlebar_bg_focus  = "#90A8A0",
            titlebar_bg_normal = "#000E13",

            wallpaper     = ".config/awesome/themes/mytheme/background1.jpg",
          
            
            rofi_config   = "~/.config/rofi/rofi1.rasi",
        },
        
    }
}