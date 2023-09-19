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
        {--blue wallpaper
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

            wallpaper     = ".config/awesome/themes/mytheme/wallpapers/background.jpg",

            rofi_config   = "~/.config/rofi/rofi.rasi",
        },
        {--greenish wallpaper
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

            wallpaper     = ".config/awesome/themes/mytheme/wallpapers/background1.jpg",
          
            
            rofi_config   = "~/.config/rofi/rofi1.rasi",
        },
        {--white wallpaper
            fg_normal     = "#ECB8C5",
            fg_focus      = "#EDEBEE",
            fg_urgent     = "#ECB8C5",

            bg_normal     = "#3F475B",
            bg_focus      = "#5E6181",
            bg_urgent     = "#ECB8C5",
            bg_systray    = bg_normal,

            border_normal = "#3F475B",
            border_focus  = "#ECB8C5",
            border_marked = "#ECB8C5",

            titlebar_bg_focus  = "#ECB8C5",
            titlebar_bg_normal = "#3F475B",

            wallpaper     = ".config/awesome/themes/mytheme/wallpapers/background2.png",

            rofi_config   = "~/.config/rofi/rofi2.rasi",
        },
        {--sky wallpaper
        fg_normal     = "#CFE0E1",
        fg_focus      = "#44ABD4",
        fg_urgent     = "#CFE0E1",

        bg_normal     = "#8DA8B1",
        bg_focus      = "#ADD4D0",
        bg_urgent     = "#CFE0E1",
        bg_systray    = bg_normal,

        border_normal = "#8DA8B1",
        border_focus  = "#CFE0E1",
        border_marked = "#CFE0E1",

        titlebar_bg_focus  = "#CFE0E1",
        titlebar_bg_normal = "#8DA8B1",

        wallpaper     = ".config/awesome/themes/mytheme/wallpapers/background3.jpg",

        rofi_config   = "~/.config/rofi/rofi3.rasi",
        },
    }
}