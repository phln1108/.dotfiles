require('pkgs')
require('helpers.functions')

Pause_stgs = {
    paused = false,
    last_tags = {},
    tags_created = {}
}

function Pause()
    if Pause_stgs.paused then
        local index = 1
        awful.screen.connect_for_each_screen(function(s)
            local t = Pause_stgs.tags_created[index]
            for _, c in ipairs(t:clients()) do c:kill() end
            Pause_stgs.last_tags[index]:view_only()
            index = index + 1
        end)
        Pause_stgs.paused = false
    else
        local index = 1
        awful.screen.connect_for_each_screen(function(s)
            local t = Create_tag(s,true)
            t.volatile = true
            Pause_stgs.last_tags[index]    = s.selected_tag
            Pause_stgs.tags_created[index] = t
            awful.spawn("kitty -e cbonsai -i -l -m 'relaxing :D' -M "..index,{
                fullscreen = true,
                tag = t,
                buttons = gears.table.join(awful.button({ },1,function () Pause() end)),
                keys = gears.table.join(awful.key({ }, "space", function () Pause() end))
            })
            awful.spawn("kitty -e cbonsai -i -l -m 'relaxing :D' -M".. index,{
                fullscreen = true,
                tag = t,
                buttons = gears.table.join(awful.button({ },1,function () Pause() end)),
                keys = gears.table.join(awful.key({ }, "space", function () Pause() end))
            })
            t:view_only()
            index=index + 1
        end)
        Pause_stgs.paused = true
    end
end

globalkeys = gears.table.join(

    awful.key(  { modkey ,}, "h", hotkeys_popup.show_help,
                {description="show help", group="awesome"}),

    awful.key(  { modkey ,}, "l", function () Pause() end,
                {description="show pause animation", group="pause"}),

    awful.key(  { modkey ,},"Tab",   function ()
                                        s = awful.screen.focused()
                                        awful.tag.viewnext(s)
                                    end,
                {description = "view next tag ", group = "tag"}),

    awful.key(  { modkey , "Shift" },"Tab",   function ()
                                                s = awful.screen.focused()
                                                awful.tag.viewprev(s)
                                            end,
                {description = "view previous tag ", group = "tag"}),

	awful.key({ modkey ,},"z",	function()
                                    local screen = awful.screen.focused()
                                    local tags = screen.tags
                                    for _,tag in ipairs(tags) do
                                        if #tag:clients() == 0 then
                                            tag:view_only()
                                            return
                                        end
                                    end
                                    new_tag = Create_tag(screen,true)
                                    new_tag:view_only()
                                end,
			    {description = "move client to first empty tag", group = "tag"}),

	awful.key(  { modkey , "Shift" },"z",   function()
												if client.focus then
													local screen = awful.screen.focused()
	                                            	local tags = screen.tags
	                                            	for _,tag in ipairs(tags) do
	                                            		if #tag:clients() == 0 then
	                                    						client.focus:move_to_tag(tag)
																return
	                                                    end
	                                            	end
                                                    new_tag = Create_tag(screen,true)
                                                    client.focus:move_to_tag(new_tag)
	                                            end
                                            end,
			    {description = "move client to first empty tag", group = "tag"}),

	awful.key(  { modkey , "Control" },"z",	function()
												if client.focus then
													local screen = awful.screen.focused()
	                                            	local tags = screen.tags
	                                            	for _,tag in ipairs(tags) do
	                                            		if #tag:clients() == 0 then
	                                    						client.focus:move_to_tag(tag)
																tag:view_only()
																return
	                                                    end
	                                            	end
                                                    new_tag = Create_tag(screen,true)
                                                    client.focus:move_to_tag(new_tag)
                                                    new_tag:view_only()
	                                            end
                                            end,
			    {description = "move client to first empty tag and go with it ", group = "tag"}),
--!!! may change
    -- awful.key(  { modkey ,},"Escape",    awful.tag.history.restore,
    --             {description = "go back", group = "tag"}),

    awful.key(  { modkey ,},"Right", function () awful.client.focus.byidx( 1)    end,
                {description = "focus next client by index", group = "client"}),

    awful.key(  { modkey ,},"Left",  function () awful.client.focus.byidx(-1)    end,
                {description = "focus previous client by index", group = "client"}),

    -- Layout manipulation
    awful.key(  { modkey , "Shift" },"Right",   function () awful.client.swap.byidx(  1)    end,
                {description = "swap with next client by index", group = "client"}),

    awful.key(  { modkey , "Shift" },"Left",    function () awful.client.swap.byidx( -1)    end,
                {description = "swap with previous client by index", group = "client"}),

    awful.key(  { modkey , "Control" },"Right", function () awful.screen.focus_relative( 1) end,
                {description = "focus the next screen", group = "screen"}),

    awful.key(  { modkey , "Control" },"Left",  function () awful.screen.focus_relative(-1) end,
                {description = "focus the previous screen", group = "screen"}),

    awful.key(  { modkey , "Shift", "Control" },"Right",function () 
                                                            if client.focus then
                                                                local screen = awful.screen.focused()
                                                                local tags = screen.tags
                                                                local next_tag = screen.selected_tag.index + 1
                                                                if next_tag > #tags then
                                                                    next_tag = 1
                                                                end                                                              
                                                                client.focus:move_to_tag(tags[next_tag])
                                                                tags[next_tag]:view_only()
                                                            end 
                                                        end,
                {description = "move client to next tag and focus it", group = "client"}),

    awful.key(  { modkey , "Shift", "Control" },"Left",function () 
                                                            if client.focus then
                                                                local screen = awful.screen.focused()
                                                                local tags = screen.tags
                                                                local next_tag = screen.selected_tag.index - 1
                                                                if next_tag < 1 then
                                                                    next_tag = #tags
                                                                end                                                              
                                                                client.focus:move_to_tag(tags[next_tag])
                                                                tags[next_tag]:view_only()
                                                            end 
                                                        end,
                {description = "move client to previous tag and focus it", group = "client"}),

--!!! know the purpose
    awful.key(  { modkey ,},"u", awful.client.urgent.jumpto,
                {description = "jump to urgent client", group = "client"}),

     -- Standard program
    awful.key({ modkey ,},"Return",  function () awful.spawn(terminal)   end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey , "Control" },"r",   awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    -- awful.key({ modkey , "Shift" },"q", awesome.quit,
    --           {description = "quit awesome", group = "awesome"}),

--!!!
    awful.key({ modkey, "Control" }, "n",
            function ()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:emit_signal(
                    "request::activate", "key.unminimize", {raise = true}
                )
                end
            end,
            {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey ,},  "r",    function () 
                awful.spawn("rofi -config ~/.config/rofi/rofi.rasi -show drun") 
            end,
            {description = "run prompt", group = "launcher"}),

    awful.key({ modkey ,},  "x",    function ()
                awful.spawn("flameshot gui")
              end,
              {description = "print screen", group = "awesome"}),
              
   -- Menubar
    awful.key({ modkey ,}, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)