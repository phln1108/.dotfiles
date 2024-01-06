# Mine configuration files :D

## To dowload

* rofi (app laucher)
* fish (shell)
* kitty (terminal)

## instalation

For installing any configuration you have to make a link from the config file you wnat to the .config file

Example:

```bash
cd ~/.config

rm -r awesome

ln -s ~/.dotfile/awesome awesome
```

You enter the .config directory and remove the old config file (you can rename it too if you want to keep it) and then you link your new config.