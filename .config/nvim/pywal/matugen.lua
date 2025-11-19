local M = {}

local lighten = require("base46.colors").change_hex_lightness

M.base_30 = {
  white = "{{colors.primary.default.hex}}",
  black = "{{colors.background.default.hex}}",
  darker_black = lighten("{{colors.background.default.hex}}", -3),
  black2 = lighten("{{colors.background.default.hex}}", 6),
  one_bg = lighten("{{colors.background.default.hex}}", 10),
  one_bg2 = lighten("{{colors.background.default.hex}}", 16),
  one_bg3 = lighten("{{colors.primary.default.hex}}", 22),
  grey = "{{colors.surface_variant.default.hex}}",
  grey_fg = lighten("{{colors.primary.default.hex}}", -10),
  grey_fg2 = lighten("{{colors.primary.default.hex}}", -20),
  light_grey = "{{colors.outline.default.hex}}",
  red = "{{colors.primary.default.hex}}",
  baby_pink = lighten("{{colors.primary.default.hex}}", 10),
  pink = "{{colors.primary.default.hex}}",
  line = "{{colors.outline.default.hex}}",
  green = "{{colors.primary.default.hex}}",
  vibrant_green = lighten("{{colors.primary.default.hex}}", 10),
  blue = "{{colors.primary.default.hex}}",
  nord_blue = lighten("{{colors.primary.default.hex}}", 10),
  yellow = "{{colors.primary.default.hex}}",
  sun = lighten("{{colors.primary.default.hex}}", 10),
  purple = "{{colors.primary.default.hex}}",
  dark_purple = lighten("{{colors.primary.default.hex}}", -10),
  teal = "{{colors.primary.default.hex}}",
  orange = "{{colors.primary.default.hex}}",
  cyan = "{{colors.primary.default.hex}}",
  statusline_bg = lighten("{{colors.background.default.hex}}", 6),
  pmenu_bg = "{{colors.primary.default.hex}}",
  folder_bg = lighten("{{colors.primary.default.hex}}", 0),
  lightbg = lighten("{{colors.background.default.hex}}", 10),
}

M.base_16 = {
  base00 = "{{colors.surface.default.hex}}",
  base01 = lighten("{{colors.surface_variant.default.hex}}", 0),
  base02 = lighten("{{colors.surface_variant.default.hex}}", 3),
  base03 = lighten("{{colors.outline.default.hex}}", 0),
  base04 = lighten("{{colors.on_surface_variant.default.hex}}", 0),
  base05 = "{{colors.on_surface.default.hex}}",
  base06 = lighten("{{colors.on_surface.default.hex}}", 0),
  base07 = "{{colors.surface.default.hex}}",
  base08 = "{{colors.red.default.hex}}",
  base09 = "{{colors.yellow.default.hex}}",
  base0A = "{{colors.blue.default.hex}}",
  base0B = "{{colors.green.default.hex}}",
  base0C = "{{colors.cyan.default.hex}}",
  base0D = lighten("{{colors.blue.default.hex}}", 20),
  base0E = "{{colors.tertiary.default.hex}}",
  base0F = "{{colors.inverse_surface.default.hex}}",
}

M.type = "dark"

M.polish_hl = {
  defaults = {
    Comment = {
      italic = true,
      fg = M.base_16.base03,
    },
  },
  Syntax = {
    String = {
      fg = "{{colors.tertiary.default.hex}}",
    },
  },
  treesitter = {
    ["@comment"] = {
      fg = M.base_16.base03,
    },
    ["@string"] = {
      fg = "{{colors.tertiary.default.hex}}",
    },
  },
}

return M
