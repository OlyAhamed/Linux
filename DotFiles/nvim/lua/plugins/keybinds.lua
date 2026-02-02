return {
  -- ============================================================================
  -- WHICH-KEY - Enhanced configuration for better cheatsheet
  -- ============================================================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        win = {
          border = "rounded",
          padding = { 1, 2 },
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
        show_help = true,
        show_keys = true,
        triggers = {
          { "<auto>", mode = "nixsotc" },
        },
      })

      -- Register your custom keybinding groups
      wk.add({
        { "<leader>f", group = "Find/File" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>d", group = "Diagnostics" },
        { "<leader>w", group = "Workspace" },
        { "<leader>c", group = "Code" },
        { "<leader>t", group = "Toggle" },
        { "<leader>x", group = "Trouble/Diagnostics" },
        { "<leader>h", group = "Harpoon/Git Hunk" },
        { "<leader>u", group = "UI/Toggle" },
        { "<leader>s", group = "Search" },
        { "<leader>b", group = "Buffer" },
        { "<leader>q", group = "Quit/Session" },
      })

      -- Add keybinding to show all keybindings
      vim.keymap.set("n", "<leader>?", function()
        wk.show({ global = true })
      end, { desc = "Show all keybindings" })
    end,
  },

  -- ============================================================================
  -- CHEATSHEET.NVIM - Interactive cheatsheet popup
  -- ============================================================================
  {
    "sudormrfbin/cheatsheet.nvim",
    cmd = { "Cheatsheet", "CheatsheetEdit" },
    keys = {
      { "<leader>ch", "<cmd>Cheatsheet<cr>", desc = "Open Cheatsheet" },
      { "<leader>?c", "<cmd>Cheatsheet<cr>", desc = "Open Cheatsheet" },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("cheatsheet").setup({
        bundled_cheatsheets = true,
        bundled_plugin_cheatsheets = true,
        include_only_installed_plugins = true,
        telescopeMode = true, -- Use telescope for better UI
      })
    end,
  },

}
