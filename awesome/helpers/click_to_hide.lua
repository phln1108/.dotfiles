local capi = { button = button, mouse = mouse }


local function click_to_hide(widget, hide_fct, only_outside)
    only_outside = only_outside or false

    hide_fct = hide_fct or function()
        widget.visible = false
    end

    -- when the widget is visible, we hide it on button press
    widget:connect_signal('property::visible',
                         function(w)
                             if not w.visible then
                                 capi.button.disconnect_signal('press', hide_fct)
                             else
                                 -- the mouse button is pressed here, we have to wait for the release
                                 local function connect_to_press()
                                     capi.button.disconnect_signal('release', connect_to_press)
                                     capi.button.connect_signal('press', hide_fct)
                                 end
                                 capi.button.connect_signal('release', connect_to_press)
                             end
                         end
    )

    if only_outside then
        -- disable hide on click when the mouse is inside the widget
        widget:connect_signal('mouse::enter',
                             function()
                                 capi.button.disconnect_signal('press', hide_fct)
                             end
        )

        widget:connect_signal('mouse::leave',
                             function()
                                 capi.button.connect_signal('press', hide_fct)
                             end
        )
    end
end

local function click_to_hide_menu(menu, hide_fct, outside_only)
    hide_fct = hide_fct or function()
        menu:hide()
    end

    click_to_hide(menu.wibox, hide_fct, outside_only)
end

-- return {
--     menu = click_to_hide_menu,
--     popup = click_to_hide,
-- }

return click_to_hide