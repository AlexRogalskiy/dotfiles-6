# caps lock for tmux modifier
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keycode 66 = F9"

# multimedia keys for magic keyboard
xmodmap -e "keycode 67 = XF86MonBrightnessDown"
xmodmap -e "keycode 68 = XF86MonBrightnessUp"

xmodmap -e "keycode 73 = XF86AudioPrev"
xmodmap -e "keycode 74 = XF86AudioPlay"
xmodmap -e "keycode 75 = XF86AudioNext"
xmodmap -e "keycode 76 = XF86AudioMute"

xmodmap -e "keycode 95 = XF86AudioLowerVolume"
xmodmap -e "keycode 96 = XF86AudioRaiseVolume"

# mess around with left super -> control
xmodmap -e "remove mod4 = Super_L"
xmodmap -e "add control = Super_L"
