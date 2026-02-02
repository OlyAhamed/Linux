return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-tree/nvim-web-devicons', -- Required for the "modern" look (icons)
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local themes = require("telescope.themes")

      telescope.setup({
        defaults = {
          -- Modern "Ivy" layout style by default for a cleaner look
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
          },
          sorting_strategy = "ascending", -- Puts the search bar at the top
          winblend = 0,                   -- Transparency (adjust if your terminal supports it)
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown", -- Compact, centered look for file finding
            previewer = false,  -- Hide preview for files to keep it simple
            hidden = true,
          },
          live_grep = {
            theme = "ivy",      -- Bottom-panel look for searching through code
            additional_args = function() return { "--hidden" } end,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal", -- Jump straight to selection
          },
        },
        extensions = {
          ["ui-select"] = {
            themes.get_dropdown {
              -- Makes code actions and menus look like clean floating panels
            }
          }
        }
      })

      telescope.load_extension("ui-select")

      -- Keymaps (organized)
      local builtin = require('telescope.builtin')
      local map = vim.keymap.set
      
      map('n', '<leader>ff', builtin.find_files, { desc = '🔭 Find Files' })
      map('n', '<leader>fg', builtin.live_grep, { desc = '󰈭  Live Grep' })
      map('n', '<leader>fb', builtin.buffers,   { desc = '󰓩  Buffers' })
      map('n', '<leader>fh', builtin.help_tags, { desc = '󰋖  Help' })
    end
  }
}
