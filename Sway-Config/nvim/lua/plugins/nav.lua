return {
  -- ========================================
  -- FLASH.NVIM (Lightning-fast navigation)
  -- Jump to any word on screen with 2 keystrokes
  -- Press 's' then type 2 characters - instant jump!
  -- ========================================
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
    config = function()
      require("flash").setup({
        -- Characters to use for jump labels
        labels = "asdfghjklqwertyuiopzxcvbnm",
        
        search = {
          -- Search in all visible windows
          multi_window = true,
          -- Search forward and backward
          forward = true,
          wrap = true,
          -- Fuzzy search
          mode = "exact",
          incremental = false,
        },
        
        jump = {
          -- Add jumps to the jumplist
          jumplist = true,
          -- Jump to start of match
          pos = "start",
          -- Automatically jump if there's only one match
          autojump = false,
        },
        
        label = {
          -- Show labels in lowercase
          uppercase = false,
          -- Rainbow colors for labels
          rainbow = {
            enabled = true,
            shade = 5,
          },
          -- Style for labels
          style = "overlay",
        },
        
        modes = {
          -- Enable flash in search
          search = {
            enabled = true,
          },
          -- Enable flash for character motions (f, F, t, T)
          char = {
            enabled = true,
            -- Show labels for multi-character searches
            jump_labels = true,
            -- Multi-line support
            multi_line = true,
          },
        },
        
        -- Highlight settings
        prompt = {
          enabled = true,
          prefix = { { "⚡", "FlashPromptIcon" } },
        },
      })
      
      -- Custom highlight colors (Catppuccin style)
      vim.api.nvim_set_hl(0, "FlashLabel", { 
        fg = "#1e1e2e", 
        bg = "#f38ba8", 
        bold = true 
      })
      vim.api.nvim_set_hl(0, "FlashMatch", { 
        fg = "#89b4fa", 
        bg = "#313244" 
      })
      vim.api.nvim_set_hl(0, "FlashCurrent", { 
        fg = "#1e1e2e", 
        bg = "#a6e3a1", 
        bold = true 
      })
    end,
  },

  -- ========================================
  -- HARPOON 2 (Quick file switching)
  -- Mark your 5 most important files and switch instantly
  -- <leader>a to add, <leader>1-5 to jump!
  -- ========================================
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- Add current file to harpoon
      { 
        "<leader>a", 
        function() 
          require("harpoon"):list():add() 
          vim.notify("󰛢 Added to Harpoon", vim.log.levels.INFO)
        end, 
        desc = "Harpoon: Add file" 
      },
      
      -- Toggle harpoon menu
      { 
        "<leader>h", 
        function() 
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, 
        desc = "Harpoon: Menu" 
      },
      
      -- Jump to harpooned files
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon: File 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon: File 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon: File 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon: File 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon: File 5" },
      
      -- Navigate through harpoon list
      { "<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Harpoon: Previous" },
      { "<C-S-N>", function() require("harpoon"):list():next() end, desc = "Harpoon: Next" },
    },
    config = function()
      local harpoon = require("harpoon")
      
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
          key = function()
            -- Use the current working directory as the key
            return vim.loop.cwd()
          end,
        },
      })

      -- Customize the harpoon menu UI
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end

      -- Optional: Use Telescope for harpoon menu (prettier)
      vim.keymap.set("n", "<leader>ht", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open harpoon in Telescope" })
    end,
  },

  -- ========================================
  -- MINI.SURROUND (Surround text operations)
  -- Add/change/delete surrounding brackets, quotes, tags
  -- sa" to add quotes, sd" to delete, sr"' to replace
  -- ========================================
  {
    "echasnovski/mini.surround",
    version = "*",
    event = "VeryLazy",
    keys = {
      { "sa", mode = { "n", "v" }, desc = "Add surrounding" },
      { "sd", mode = "n", desc = "Delete surrounding" },
      { "sr", mode = "n", desc = "Replace surrounding" },
      { "sf", mode = "n", desc = "Find right surrounding" },
      { "sF", mode = "n", desc = "Find left surrounding" },
      { "sh", mode = "n", desc = "Highlight surrounding" },
      { "sn", mode = "n", desc = "Update n_lines" },
    },
    config = function()
      require("mini.surround").setup({
        -- Mappings for surround operations
        mappings = {
          add = "sa",            -- Add surrounding in Normal and Visual modes
          delete = "sd",         -- Delete surrounding
          find = "sf",           -- Find surrounding (to the right)
          find_left = "sF",      -- Find surrounding (to the left)
          highlight = "sh",      -- Highlight surrounding
          replace = "sr",        -- Replace surrounding
          update_n_lines = "sn", -- Update `n_lines`
        },
        
        -- Number of lines within which surrounding is searched
        n_lines = 50,
        
        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,
        
        -- Pattern to match function call
        search_method = "cover_or_next",
        
        -- Whether to respect selection type:
        -- - Place surroundings on separate lines in linewise mode.
        -- - Place surroundings on each line in blockwise mode.
        respect_selection_type = false,
      })
      
      -- Custom highlight for surrounded text
      vim.api.nvim_set_hl(0, "MiniSurround", { 
        fg = "#f38ba8", 
        bg = "#313244",
        bold = true 
      })
    end,
  },
}
