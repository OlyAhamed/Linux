return {
  -- Job 1: Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  -- Job 2: Lualine (Symmetrical Polish)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Catppuccin Mocha colors
      local colors = {
        fg       = "#cdd6f4", -- Text
        normal   = "#89b4fa", -- Blue
        insert   = "#a6e3a1", -- Green
        visual   = "#cba6f7", -- Mauve
        inactive = "#181825", -- Mantle
        text_alt = "#bac2de", -- Subtext1
        bg       = "#1e1e2e", -- Base
      }
      local theme = {
        normal = {
          a = { fg = colors.bg, bg = colors.normal, gui = "bold" },
          b = { fg = colors.text_alt, bg = colors.inactive },
          c = { fg = colors.text_alt, bg = colors.bg },
        },
        insert = { a = { fg = colors.bg, bg = colors.insert, gui = "bold" } },
        visual = { a = { fg = colors.bg, bg = colors.visual, gui = "bold" } },
      }
      require('lualine').setup({
        options = {
          theme = theme,
          globalstatus = true,
          section_separators = '',
          component_separators = '',
        },
        sections = {
          -- LEFT SIDE
          lualine_a = {
            { 
              'mode', 
              separator = { left = '', right = '' }, 
              padding = { left = 1, right = 1 } 
            },
          },
          lualine_b = {
            { 'branch', icon = '', padding = { left = 2, right = 1 } },
          },
          lualine_c = {
            { 'filename', file_status = true, path = 1, color = { bg = colors.inactive, fg = colors.text_alt },  separator = { right = '' }, },
            -- DYNAMIC TRIANGLE: Syncs with Mode Color
            { 
              function() return ' ' end, 
              padding = 0, 
              separator = { right = '' }, 
              color = function()
                local mode_color = {
                  n = 'lualine_a_normal',
                  i = 'lualine_a_insert',
                  v = 'lualine_a_visual',
                  V = 'lualine_a_visual',
                  [''] = 'lualine_a_visual',
                }
                return mode_color[vim.fn.mode()] or 'lualine_a_normal'
              end
            },
          },
          
          -- RIGHT SIDE
          lualine_x = {
            -- NORMAL TRIANGLE: Lead-in shape using the normal color
            { 
              function() return ' ' end, 
              padding = 0, 
              separator = { left = '' }, 
              color = { bg = colors.normal } 
            },
            { 'filetype', separator = { left = '' }, color = { bg = colors.inactive, fg = colors.text_alt } },
          },
          lualine_y = {
            { 'progress', separator = { left = '' }, color = { bg = colors.inactive, fg = colors.text_alt } },
          },
          lualine_z = {
            { 
              'location', 
              separator = { left = '', right = '' }, 
              color = { bg = colors.normal, fg = colors.bg, gui = "bold" } 
            },
          },
        },
      })
    end,
  },
}
