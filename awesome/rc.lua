pcall(require, "luarocks.loader")
require('pkgs')
require('error-handling')

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "zenburn/theme.lua")

-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- baterry widget check if im using the laptop or the pc, 
-- to show or not the widget
local get_batery = function ()
    local path = io.popen("echo $HOME"):read("*all")

    if path == "/home/ph\n" then
        return require("widgets.battery-widget"){
            ac_prefix = "+Bat:",
            battery_prefix = "-Bat:",
            percent_colors = {
                { 25, "red"   },
                { 50, "orange"},
                {999, "green" },
            },
            listen = true,
            timeout = 10,
            widget_text = "${AC_BAT}${color_on}${percent}%${color_off}",
            tooltip_text = "Battery ${state}${time_est}\nCapacity: ${capacity_percent}%",
        }
    end
    return nil
end

local battery_widget = get_batery() 

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        -- gears.wallpaper.maximized(wallpaper, s, true)
        gears.wallpaper.maximized("wallpapers/wallpaper1.jpg", s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "⦿", "○", "○"}, s, awful.layout.layouts[1])

    for t = 1,#s.tags do
        if s.tags[t] then
            s.tags[t]:connect_signal("property::selected", function (tag)
                if not tag.selected then
                    tag.name = "○"
                    return 
                end
                tag.name = "⦿"
                wallpaper_path = "wallpapers/wallpaper" .. t .. ".jpg"
                gears.wallpaper.maximized(wallpaper_path,s,true)
                tag:view_only()
            end)
        end
    end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s ,height = 25})
    
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            
            battery_widget,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            --s.mylayoutbox,
        },
    }
end)


require('keybindings')
require('rules')
require('signals')


--setup round window border
beautiful.useless_gap = 5
beautiful.gap_single_client = true

-- Turn off annoying beep
awful.spawn.with_shell("xset b off", false)

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

--set background
-- awful.screen.connect_for_each_screen(function(s)
--     for t = 1,9 do
--         if s.tags[t] then
--             s.tags[t]:connect_signal("property::selected", function (tag)
--                 if not tag.selected then return end
--                 wallpaper_path = "wallpapers/wallpaper" .. t .. ".jpg"
--                 gears.wallpaper.maximized(wallpaper_path,s)
--                 tag:view_only()
--             end)
--         end
--     end
-- end)
