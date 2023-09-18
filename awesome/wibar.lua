require('pkgs')
require('helpers.functions')

-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

--local battery_widget = get_batery()

local logout_menu_widget = require("widgets.logout-menu-widget.logout-menu")

local brightness_widget = require("widgets.brightness-widget.brightness")

local todo_widget = require("widgets.todo-widget.todo")


local volume_widget = require("widgets.volume-widget.volume")

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
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

function Spacer (tl,tr,br,bl)
    local teste = wibox.widget{
        text   = '  ',
        widget = wibox.widget.textbox
    }
    return wibox.widget{
        teste,
        widget = wibox.container.background,
        bg = beautiful.bg_normal,
        shape  = function (cr,w,h)
            gears.shape.partially_rounded_rect(cr,w,h,tl,tr,br,bl)
        end,
        opacity = 1
    }
end


function Create_wibar(s,recreate)

    s.task_spacer1 = Spacer(false,false,false,true)
    s.task_spacer2 = Spacer(false,false,true,false)
    s.task_spacer1.opacity = 1
    s.task_spacer2.opacity = 1

    client.connect_signal("list",function ()
        local s = awful.screen.focused()
        local tag = s.selected_tag
        if #tag:clients() > 0 then
            s.task_spacer1.opacity = 1
            s.task_spacer2.opacity = 1
        else
            s.task_spacer1.opacity = 0
            s.task_spacer2.opacity = 0
        end
    end)

    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    if #s.tags == 0 then
        local new_tag  = Create_tag(s,false)
        local new_tag1 = Create_tag(s,false)
        local new_tag2 = Create_tag(s,false)
        new_tag:view_only()
    end

    local t = s.selected_tag
    if #t:clients() > 0 then
        s.task_spacer1.opacity = 1
        s.task_spacer2.opacity = 1
    else
        s.task_spacer1.opacity = 0
        s.task_spacer2.opacity = 0
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
        buttons = taglist_buttons,
        shape   = gears.shape.rounded_bar,
        style   = {
            shape  = gears.shape.circle,
        },
        layout   = wibox.layout.fixed.horizontal,
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        shape   = gears.shape.rounded_bar,
        style    = {
            border_width = 1,
            shape  = function (cr,w,h)
                gears.shape.partially_rounded_rect(cr,w,h, false,false,true,true)
            end,
            valign = "top",
            halign = "left",
        },
        layout   = {
            spacing = 0,
            spacing_widget = {
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            layout  = wibox.layout.flex.horizontal
        },
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ 
        position = "top", 
        screen = s ,
        height = 25,
        bg = beautiful.bg_normal .. "00", -- make wibar invisible
    })
    
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",

        {
            Spacer(false,false,false,false),
            layout = wibox.layout.fixed.horizontal,
            {
                widget = wibox.container.background,
                bg     = beautiful.bg_normal,
                s.mytaglist,
            },
            Spacer(false,false,true,false)
        },

        {
            layout = wibox.layout.fixed.horizontal,
            s.task_spacer1,
            {
                widget = wibox.container.background,
                bg     = beautiful.bg_normal,
                s.mytasklist,
            },
            s.task_spacer2,
        },
        
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            Spacer(false,false,false,true),
                  
            -- wibox.container.background(battery_widget,beautiful.bg_normal),
            wibox.container.background(brightness_widget{
                tooltip = true,
                program = "brightnessctl",
                type    = "arc",
                percentage = true,
            },beautiful.bg_normal),
            wibox.container.background(todo_widget(),beautiful.bg_normal),
            wibox.container.background(mykeyboardlayout,beautiful.bg_normal),
            wibox.container.background(volume_widget{
                widget_type = "horizontal_bar",
                with_icon = true
            },beautiful.bg_normal),
            wibox.container.background(wibox.widget.systray(),beautiful.bg_normal),
            wibox.container.background(mytextclock,beautiful.bg_normal),
            wibox.container.background(logout_menu_widget(),beautiful.bg_normal),
        },
    }
end

function Build_panel()
    awful.screen.connect_for_each_screen(function (s)
        local recreate = false
        -- destroy old panel
        if s.mywibox then
            s.mywibox:remove() 
            recreate = true
        end
        Create_wibar(s,recreate)
    end)
end


