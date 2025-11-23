# A simple hyprland setup with modern waybar and themes according to the wallpaper



<img width="1920" height="1080" alt="2025-11-21-192352_hyprshot" src="https://github.com/user-attachments/assets/dc208b54-044e-4080-85a7-ba70c0cd084f" />

---

## Install the needed dependecies first to set up this 

### Used programs

- Hyprlock,hypridle,hyprshot
- rofi
- swaync
- neofetch
- matugen, swwww
- waybar
- cava
- kitty
- nvim
- blueberry, nm-connection-editor, brightnessctl


## Terminal command to install them all at once 

### Using paru
``` 
paru -S hyprlock hypridle hyprshot rofi swaync neofetch matugen swww waybar cava kitty nvim blueberry nm-connection-editor brightnessctl

```

### Using yay

``` 
yay -S hyprlock hypridle hyprshot rofi swaync neofetch matugen swww waybar cava kitty nvim blueberry nm-connection-editor brightnessctl

```

### If you dont have either paru or yay first install yay

```
sudo pacman -S --needed base-devel

git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si

```


## Make sure you have `git` installed as it is needed to download the whole reposetory. 

### If you don't git too first install it

#### For Arch
```
sudo pacman -S git
```
#### For Debian 

```
sudo apt install git
```

##  Installation
---
#### First back up your old config as this process will erase your current config and switc it with new one. It won't be a problem with a freshly installed hyprland.

### First git clone the whole reposetory

```
git clone https://github.com/OlyAhamed/Linux.git
```

### Now enter the folder 

```
cd Linux/.config
```

### Now make the setup.sh file executable

```
chmod +X setup.sh
```

### Now run the setup file

```
./setup.sh
```

 
