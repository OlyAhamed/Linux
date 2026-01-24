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

  -- ============================================================================
  -- LEGENDARY.NVIM - Command palette + keybinding finder
  -- ============================================================================
  {
    "mrjones2014/legendary.nvim",
    priority = 10000,
    lazy = false,
    keys = {
      { "<C-p>", "<cmd>Legendary<cr>", desc = "Open Legendary (Command Palette)" },
      { "<leader>k", "<cmd>Legendary<cr>", desc = "Open Legendary (Command Palette)" },
    },
    dependencies = {
      "stevearc/dressing.nvim",
    },
    config = function()
      require("legendary").setup({
        extensions = {
          lazy_nvim = { auto_register = true },
          which_key = {
            auto_register = true,
            do_binding = false,
          },
        },
        -- Don't define keymaps here to avoid deprecation warnings
        -- Let which-key and other plugins register them
        sort = {
          most_recent_first = true,
          user_items = true,
        },
      })
    end,
  },

  -- ============================================================================
  -- KEYMAP-AMEND - View and modify keymaps easily
  -- ============================================================================
  {
    "anuvyklack/keymap-amend.nvim",
    lazy = true,
  },

  -- ============================================================================
  -- COMMAND CENTER - Another command palette option
  -- ============================================================================
  {
    "gfeiyou/command-center.nvim",
    cmd = "CommandCenter",
    keys = {
      { "<leader>cc", "<cmd>CommandCenter<cr>", desc = "Command Center" },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local command_center = require("command_center")
      
      command_center.add({
        {
          description = "Open Cheatsheet",
          cmd = "<CMD>Cheatsheet<CR>",
        },
        {
          description = "Find files",
          cmd = "<CMD>Telescope find_files<CR>",
        },
        {
          description = "Live grep",
          cmd = "<CMD>Telescope live_grep<CR>",
        },
        {
          description = "Find buffers",
          cmd = "<CMD>Telescope buffers<CR>",
        },
        {
          description = "Recent files",
          cmd = "<CMD>Telescope oldfiles<CR>",
        },
        {
          description = "Git status",
          cmd = "<CMD>Telescope git_status<CR>",
        },
        {
          description = "LSP symbols",
          cmd = "<CMD>Telescope lsp_document_symbols<CR>",
        },
        {
          description = "Toggle file explorer",
          cmd = "<CMD>NvimTreeToggle<CR>",
        },
        {
          description = "Open Mason",
          cmd = "<CMD>Mason<CR>",
        },
        {
          description = "Open Lazy",
          cmd = "<CMD>Lazy<CR>",
        },
        {
          description = "Format code",
          cmd = "<CMD>lua vim.lsp.buf.format()<CR>",
        },
      })
    end,
  },

  -- ============================================================================
  -- KEYBINDING NOTES
  -- ============================================================================
  -- Add this to see your keybindings:
  -- 
  -- 1. Press <leader>? - Shows all keybindings (which-key)
  -- 2. Press <leader>cs - Opens full cheatsheet
  -- 3. Press <C-p> or <leader>k - Command palette (Legendary)
  -- 4. Press <leader>cc - Command center
  --
  -- In which-key popup, you can also just press <leader> and wait - it will
  -- show you all leader keybindings!
  --
  -- Most useful keybindings:
  -- - Type any prefix (like <leader>f) and wait to see all file commands
  -- - Type 'g' in normal mode to see all go-to commands
  -- - Type 'z' to see fold/spelling commands
  -- - Type <C-w> to see window commands
  -- ============================================================================
}
