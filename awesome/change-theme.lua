require('pkgs')

function Change_theme()
    -- change theme settings
    Themes.actual  = Themes.actual+1
    if Themes.actual > #Themes.theme then
        Themes.actual = 1
    end
    local t = Themes.theme[Themes.actual]
    
    beautiful.fg_normal     = t.fg_normal
    beautiful.fg_focus      = t.fg_focus
    beautiful.fg_urgent     = t.bg_urgent

    beautiful.bg_normal     = t.bg_normal
    beautiful.bg_focus      = t.bg_focus
    beautiful.bg_urgent     = t.bg_urgent

    beautiful.border_normal = t.border_normal
    beautiful.border_focus  = t.border_focus
    beautiful.border_marked = t.border_marked

    beautiful.titlebar_bg_focus  = t.titlebar_bg_focus
    beautiful.titlebar_bg_normal = t.titlebar_bg_normal

    beautiful.wallpaper     = t.wallpaper

    -- rebuild panel widgets
    gears.wallpaper.maximized(t.wallpaper,s)
    Build_panel()
end