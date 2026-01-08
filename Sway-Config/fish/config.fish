# commands
alias v="nvim"
alias y="yay -S"
alias grubu="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias sourcef="source ~/.config/fish/config.fish"
# files
alias sway="nvim ~/.config/sway/config"
alias waybarj="nvim ~/.config/waybar/config.jsonc"
alias waybars="nvim ~/.config/waybar/style.css"
alias update="sudo pacman -Syuu --noconfirm"
alias fishc="nvim ~/.config/fish/config.fish"
#key bindings
fzf --fish | source

starship init fish | source

