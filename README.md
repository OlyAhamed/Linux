# 🔥 Hyprland Setup — Modern Waybar + Auto-Theming

[![Arch Linux](https://img.shields.io/badge/Arch-Linux-blue?style=flat-square)](https://archlinux.org/) [![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-green?style=flat-square)](https://hyprland.org/) [![Shell Script](https://img.shields.io/badge/Shell-Script-yellow?style=flat-square)](https://www.gnu.org/software/bash/)

#### A clean Hyprland configuration featuring a modern Waybar layout, wallpaper-based theming (matugen + swww), and a full desktop setup script.

<p align="center">
  <img alt="Hyprland Preview" src="https://github.com/user-attachments/assets/dc208b54-044e-4080-85a7-ba70c0cd084f" width="90%">
</p>

---

## ⚠ Project Status
🚧 **Under active maintenance — NOT ready for production use yet.**  
Feel free to explore or modify, but expect bugs or missing features.

---

# 📚 Features
- Modern Waybar theme synced with wallpaper colors  
- Hyprlock + Hypridle + Hyprshot integration  
- Clean Rofi theme  
- Auto wallpaper theming using **matugen + swww**  
- Preconfigured apps (Kitty, NeoVim, swaync, Cava, Blueberry, etc.)  
- Full setup script to install and apply configs automatically  

---

# 📦 Required Packages

### Hyprland Ecosystem
- hyprlock  
- hypridle  
- hyprshot  
- matugen  
- swww  

### General Tools
- rofi  
- swaync  
- neofetch  
- waybar  
- cava  
- kitty  
- neovim  
- blueberry  
- nm-connection-editor  
- brightnessctl  

---

# 📥 Install Dependencies

## Arch Linux

### Using `paru`
```bash
paru -S hyprlock hypridle hyprshot rofi swaync neofetch matugen swww waybar cava kitty nvim blueberry nm-connection-editor brightnessctl
```

### Using `yay`

```
yay -S hyprlock hypridle hyprshot rofi swaync neofetch matugen swww waybar cava kitty nvim blueberry nm-connection-editor brightnessctl
```

### For `Debian`

```
sudo apt install rofi neofetch swww waybar cava kitty neovim blueberry brightnessctl nm-connection-editor
```
#### Not available in Debian repos

##### These require flatpak, source builds, or a Hyprland-native distro:

- hyprlock

- hypridle

- hyprshot

- matugen

### 🛠 Installing yay (if needed)

```
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

```

## Installation 

#### ⚠ BACK UP your existing Hyprland config first!
##### This setup will overwrite your ~/.config files.

### 1. First git clone the whole reposetory

```
git clone https://github.com/OlyAhamed/Linux.git
```

### 2. Now enter the folder
```
cd Linux/.config
```

### 3. Now make the setup.sh file executable

```
chmod +X setup.sh
```

### 4. Now run the setup file

```
./setup.sh
```

##### If it worked you may now uninstall the cloned folder
```
sudo rm -rf ~/Linux
```

###### Or just delete it from yourr file manager



