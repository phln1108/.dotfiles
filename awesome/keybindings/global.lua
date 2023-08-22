require('pkgs')

function create_tag ()
    new_tag = awful.tag.add("○", {
        -- icon_only = true,
        -- icon = "/home/pedroh/Downloads/em-linha-reta.png",
        screen = awful.screen.focused(),
        layout = awful.layout.suit.fair })
        new_tag:connect_signal("property::selected", function (tag)
            if not tag.selected then 
                tag.name = "○"
                if #tag:clients() == 0 then tag:delete() end
                return 
            end
            if #tag:clients() > 0 then
                task_spacer1.opacity = 1
                task_spacer2.opacity = 1
            else
                task_spacer1.opacity = 0
                task_spacer2.opacity = 0
            end
            tag.name = "⦿"
            wallpaper_path = "wallpapers/wallpaper" .. tag.index .. ".jpg"
            gears.wallpaper.maximized(wallpaper_path,s)
            tag:view_only()
        end)
    return new_tag
end

globalkeys = gears.table.join(

    awful.key(  { modkey ,}, "h", hotkeys_popup.show_help,
                {description="show help", group="awesome"}),

    awful.key(  { modkey ,},"Tab",   function ()
                                        s = awful.screen.focused()
                                        awful.tag.viewnext(s)
                                    end,
                {description = "view next tag that have something in it", group = "tag"}),

    awful.key(  { modkey , "Shift" },"Tab",   function ()
                                                s = awful.screen.focused()
                                                awful.tag.viewprev(s)
                                            end,
                {description = "view previous tag that have something in it", group = "tag"}),

	awful.key({ modkey ,},"z",	function()
                                    local screen = awful.screen.focused()
                                    local tags = screen.tags
                                    for _,tag in ipairs(tags) do
                                        if #tag:clients() == 0 then
                                            tag:view_only()
                                            return
                                        end
                                    end
                                    new_tag = create_tag()
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
                                                    new_tag = create_tag()
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
                                                    new_tag = create_tag()
                                                    client.focus:move_to_tag(new_tag)
                                                    new_tag:view_only()
	                                            end
                                            end,
			    {description = "move client to first empty tag and go with it ", group = "tag"}),
--!!! may change
    awful.key(  { modkey ,},"Escape",    awful.tag.history.restore,
                {description = "go back", group = "tag"}),

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
    awful.key({ modkey , "Shift" },"q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

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
    awful.key({ modkey ,},            "r",     function () awful.spawn("rofi -show drun") end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey ,}, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
              
    -- Menubar
    awful.key({ modkey ,}, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)