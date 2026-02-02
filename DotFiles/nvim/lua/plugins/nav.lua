return {
    -- ========================================
  -- FLASH.NVIM (Lightning-fast navigation)
  -- Jump to any word on screen with 2 keystrokes
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
        labels = "asdfghjklqwertyuiopzxcvbnm",
        search = {
          multi_window = true,
          forward = true,
          wrap = true,
          mode = "exact",
          incremental = false,
        },
        jump = {
          jumplist = true,
          pos = "start",
          autojump = false,
        },
        label = {
          uppercase = false,
          rainbow = { enabled = true, shade = 5 },
          style = "overlay",
        },
        modes = {
          search = { enabled = true },
          char = {
            enabled = true,
            jump_labels = true,
            multi_line = true,
          },
        },
        prompt = {
          enabled = true,
          prefix = { { "⚡", "FlashPromptIcon" } },
        },
      })
      
      -- Kanagawa Highlights for Flash
      vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#16161D", bg = "#FF5D62", bold = true })
      vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#DCD7BA", bg = "#2D4F67" })
      vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#16161D", bg = "#98BB6C", bold = true })
    end,
  },

  -- ========================================
  -- HARPOON 2 (Quick file switching)
  -- Mark your 5 most important files and switch instantly
  -- ========================================
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() vim.notify("󰛢 Added to Harpoon") end, desc = "Harpoon: Add file" },
      { "<leader>h", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: Menu" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon: File 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon: File 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon: File 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon: File 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon: File 5" },
      { "<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Harpoon: Previous" },
      { "<C-S-N>", function() require("harpoon"):list():next() end, desc = "Harpoon: Next" },
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
          key = function() return vim.loop.cwd() end,
        },
      })

      -- HARPOON TELESCOPE INTEGRATION (REINSTATED)
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end
        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({ results = file_paths }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end

      vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon in Telescope" })
    end,
  },

  -- ========================================
  -- MINI.SURROUND (Surround text operations)
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
        mappings = {
          add = "sa", delete = "sd", find = "sf", find_left = "sF",
          highlight = "sh", replace = "sr", update_n_lines = "sn",
        },
        n_lines = 50,
        highlight_duration = 500,
        search_method = "cover_or_next",
        respect_selection_type = false,
      })
      -- Kanagawa Highlights for Surround
      vim.api.nvim_set_hl(0, "MiniSurround", { fg = "#DCD7BA", bg = "#957FB8", bold = true })
    end,
  },
}
