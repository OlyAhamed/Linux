return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim' 
    },
    config = function()
      require("telescope").setup({
        defaults = {
          preview = {
            treesitter = false,
          },
        },
        -- ADDED PICKERS SECTION BELOW
        pickers = {
          find_files = {
            hidden = true,      -- Search hidden files
            no_ignore = false,  -- Set to true if you want to see .gitignore-d files too
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })

      -- Load the extension
      require("telescope").load_extension("ui-select")

      -- Keymaps
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
    end
  }
}
