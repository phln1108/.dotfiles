require('pkgs')


function Create_tag (s,temporary)
    local new_tag = awful.tag.add("○", {
        -- icon_only = true,
        -- icon = "/home/pedroh/Downloads/em-linha-reta.png",
        screen = s,
        layout = awful.layout.suit.fair })

    new_tag:connect_signal("property::selected", function (tag)
        if not tag.selected then 
            tag.name = "○"
            if temporary and #tag:clients() == 0 then tag:delete() end
            return 
        end
        if #tag:clients() > 0 then
            s.task_spacer1.opacity = 1
            s.task_spacer2.opacity = 1
        else
            s.task_spacer1.opacity = 0
            s.task_spacer2.opacity = 0
        end
        tag.name = "⦿"
    end)
    return new_tag
end

