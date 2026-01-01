return {
  -- Job 1: Colorscheme
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("lackluster")
    end,
  },

  -- Job 2: Lualine (Symmetrical Polish)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local colors = {
        fg       = "#f2f2f2", 
        normal   = "#708090",
        insert   = "#708070",
        visual   = "#807080",
        inactive = "#262626",
        text_alt = "#949494",
      }

      local theme = {
        normal = {
          a = { fg = colors.fg, bg = colors.normal, gui = "bold" },
          b = { fg = colors.text_alt, bg = colors.inactive },
          c = { fg = colors.text_alt, bg = colors.bg },
        },
        insert = { a = { fg = colors.fg, bg = colors.insert, gui = "bold" } },
        visual = { a = { fg = colors.fg, bg = colors.visual, gui = "bold" } },
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
              separator = { left = '', right = '' }, 
              padding = { left = 1, right = 1 } 
            },
          },
          lualine_b = {
            { 'branch', icon = '', padding = { left = 2, right = 1 } },
          },
          lualine_c = {
            { 'filename', file_status = true, path = 1, color = { bg = colors.inactive, fg = colors.text_alt },  separator = { right = '' }, },
            -- DYNAMIC TRIANGLE: Syncs with Mode Color
            { 
              function() return ' ' end, 
              padding = 0, 
              separator = { right = '' }, 
              color = function()
                local mode_color = {
                  n = 'lualine_a_normal',
                  i = 'lualine_a_insert',
                  v = 'lualine_a_visual',
                  V = 'lualine_a_visual',
                  [''] = 'lualine_a_visual',
                }
                return mode_color[vim.fn.mode()] or 'lualine_a_normal'
              end
            },
          },
          
          -- RIGHT SIDE
          lualine_x = {
            -- NORMAL TRIANGLE: Lead-in shape using the "normal" slate color
            { 
              function() return ' ' end, 
              padding = 0, 
              separator = { left = '' }, 
              color = { bg = colors.normal } 
            },
            { 'filetype', separator = { left = '' }, color = { bg = colors.inactive, fg = colors.text_alt } },
          },
          lualine_y = {
            { 'progress', separator = { left = '' }, color = { bg = colors.inactive, fg = colors.text_alt } },
          },
          lualine_z = {
            { 
              'location', 
              separator = { left = '', right = '' }, 
              color = { bg = colors.normal, fg = colors.fg, gui = "bold" } 
            },
          },
        },
      })
    end,
  },
}
