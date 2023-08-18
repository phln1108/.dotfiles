pcall(require, "luarocks.loader")
require('pkgs')
require('error-handling')


-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir()..'themes/mytheme/theme.lua')
-- }}}
require('menu')
require('wibar')
require('keybindings')
require('rules')
require('signals')


--setup round window border
-- beautiful.useless_gap = 5
-- beautiful.gap_single_client = true

-- Turn off annoying beep
awful.spawn.with_shell("xset b off", false)

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

awesome.set_preferred_icon_size(32)

beautiful.tasklist_disable_task_name = true

