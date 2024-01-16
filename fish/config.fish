# Fish colors
set -g fish_color_command --bold green
set -g fish_color_error red
set -g fish_color_quote yellow
set -g fish_color_param gray
set -g fish_pager_color_selected_completion blue

# Some config
set -g fish_greeting

# Get terminal emulator
set TERM_EMULATOR (ps -aux | grep (ps -p $fish_pid -o ppid=) | awk 'NR==1{print $11}')

# Neofetch

# Directory abbreviations
abbr -a -g l 'ls'
abbr -a -g la 'ls -a'
abbr -a -g ll 'ls -l'
abbr -a -g lal 'ls -al'
abbr -a -g d 'dirs'
abbr -a -g home 'cd $HOME'

# Locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Exports
export VISUAL="vim"
export EDITOR="$VISUAL"

# Term
switch "$TERM_EMULATOR"
case '*kitty*'
	export TERM='xterm-kitty'
case '*'
	export TERM='xterm-256color'
end

# User abbreviations
abbr -a -g ytmp3 'youtube-dl --extract-audio --audio-format mp3'	# Convert/Download YT videos as mp3
abbr -a -g cls 'clear'												# Clear
abbr -a -g upd 'yay -Syu --noconfirm'								# Update everything
abbr -a -g please 'sudo'											# Polite way to sudo
abbr -a -g fucking 'sudo'											# Rude way to sudo
abbr -a -g sayonara 'shutdown now'									# Epic way to shutdown
abbr -a -g bye 'shutdown now'										# Panik - stonk man
abbr -a -g ar 'echo "awesome.restart()" | awesome-client'			# Reload AwesomeWM																# Unblock wlan, start wifi connection
abbr -a -g ff 'firefox'												# Launch firefox

# Source plugins
# Useful plugins: archlinux bang-bang cd colorman sudope vcs
if test -d "$HOME/.local/share/omf/pkg/colorman/"
	source ~/.local/share/omf/pkg/colorman/init.fish
end

# Make su launch fish
function su
   command su --shell=/usr/bin/fish $argv
end
pls
