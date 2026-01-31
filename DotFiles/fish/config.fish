source /usr/share/cachyos-fish-config/cachyos-config.fish
starship init fish | source
# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
# alias
function nvim
    kitty @ set-spacing padding=0
    command nvim $argv
    kitty @ set-spacing padding=default
end

function fish_prompt
    # Use starship but pipe it through 'lolcat' for a rainbow animation 
    # OR 'pv' for a typing effect
    starship prompt | lolcat -a -d 1 -s 100
end

fish_add_path /home/oli/.spicetify
