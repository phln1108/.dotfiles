require('pkgs')

globalkeys = gears.table.join(

    awful.key(  { modkey ,}, "h", hotkeys_popup.show_help,
                {description="show help", group="awesome"}),

    awful.key(  { modkey ,},"Tab",   function ()
                                        local screen = awful.screen.focused()
                                        local current_tag = screen.selected_tag 
                                        local tags = screen.tags
                                        local pass = false
                                        local go_to = current_tag
                                        for _,tag in ipairs(tags) do
                                            if tag == current_tag then
                                                pass = true
                                            elseif #tag:clients() > 0 then
                                                if pass then
                                                    go_to = tag
                                                    break
                                                elseif current_tag == go_to then
                                                    go_to = tag 
                                                end
                                            end
                                        end
                                        go_to:view_only()
                                    end,
                {description = "view next tag that have something in it", group = "tag"}),

    awful.key(  { modkey , "Shift" },"Tab",   function ()
                                                local screen = awful.screen.focused()
                                                local current_tag = screen.selected_tag 
                                                local tags = screen.tags
                                                local pass = false
                                                local go_to = current_tag
                                                    for i = #tags ,1,-1 do
                                                        tag = tags[i]
                                                        if tag == current_tag then
                                                            pass = true
                                                        elseif #tag:clients() > 0 then
                                                            if pass then
                                                                go_to = tag
                                                                break
                                                            elseif current_tag == go_to then
                                                                go_to = tag 
                                                            end
                                                        end
                                                    end
                                                    go_to:view_only()
                                            end,
                {description = "view previous tag that have something in it", group = "tag"}),

	awful.key({ modkey ,},"z",	function()
                                    local screen = awful.screen.focused()
                                    local tags = screen.tags
                                    for _,tag in ipairs(tags) do
                                        if #tag:clients() == 0 then
                                            tag:view_only()
                                            break
                                        end
                                    end
                                end,
			    {description = "move client to first empty tag", group = "tag"}), 

	awful.key(  { modkey , "Shift" },"z",   function()
												if client.focus then
													local screen = awful.screen.focused()
	                                            	local tags = screen.tags
	                                            	for _,tag in ipairs(tags) do
	                                            		if #tag:clients() == 0 then
	                                    						client.focus:move_to_tag(tag)
																break
	                                                    end
	                                            	end
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
																break
	                                                    end
	                                            	end
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

--    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
--              {description = "increase master width factor", group = "layout"}),
--    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
--              {description = "decrease master width factor", group = "layout"}),
--    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
--              {description = "increase the number of master clients", group = "layout"}),
--    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
--             {description = "decrease the number of master clients", group = "layout"}),
--    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
--              {description = "increase the number of columns", group = "layout"}),
--    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
--              {description = "decrease the number of columns", group = "layout"}),
--    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
--              {description = "select next", group = "layout"}),
--    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
--              {description = "select previous", group = "layout"}),


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