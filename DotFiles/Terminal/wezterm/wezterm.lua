local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ==========================================================
-- 0. Default Shell (Fish)
-- ==========================================================
config.default_prog = { '/usr/bin/fish', '-l' }

-- ==========================================================
-- 1. Look and Feel
-- ==========================================================
config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'JetBrains Mono NL'
config.font_size = 12.0

-- Transparency (Blur is handled by KDE settings on stable)
config.window_background_opacity = 1

-- Clean Window: This puts buttons in the tab bar
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_padding = {
  left = 8, right = 8, top = 8, bottom = 8,
}

-- ==========================================================
-- 2. Tab Bar
-- ==========================================================
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false

config.colors = {
  tab_bar = {
    background = '#1a1b26',
    active_tab = {
      bg_color = '#7aa2f7',
      fg_color = '#1a1b26',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#16161e',
      fg_color = '#a9b1d6',
    },
  },
}

-- ==========================================================
-- 3. The Status Bar (Right Side Clock)
-- ==========================================================
wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.time.now():format('%Y-%m-%d %H:%M')
  window:set_right_status(wezterm.format({
    { Foreground = { Color = '#7aa2f7' } },
    { Text = '  ' .. date .. '  ' },
  }))
end)

return config
