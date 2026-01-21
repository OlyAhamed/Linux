return {
  -- ========================================
  -- MINI.ANIMATE (Window & cursor animations)
  -- Inspired by DHH's Omakase - smooth but not laggy
  -- ========================================
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    config = function()
      local animate = require("mini.animate")

      animate.setup({
        -- Cursor animation - smooth path when jumping
        cursor = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
          path = animate.gen_path.line(),
        },

        -- Scroll animation - DISABLED to prevent lag
        scroll = {
          enable = false,
        },

        -- Window resize animation - smooth resizing
        resize = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
        },

        -- Window open animation - fade in
        open = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),
        },

        -- Window close animation - fade out
        close = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          winconfig = animate.gen_winconfig.wipe({ direction = "to_edge" }),
        },
      })
    end,
  },

  -- ========================================
  -- WINDOWS.NVIM (Smooth window management)
  -- Adds animations when switching windows
  -- ========================================
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    event = "WinNew",
    keys = {
      { "<leader>wm", "<cmd>WindowsMaximize<cr>",        desc = "Maximize window" },
      { "<leader>we", "<cmd>WindowsEqualize<cr>",        desc = "Equalize windows" },
      { "<leader>wt", "<cmd>WindowsToggleAutowidth<cr>", desc = "Toggle auto-width" },
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false

      require("windows").setup({
        autowidth = {
          enable = true,
          winwidth = 5,
          filetype = {
            help = 2,
          },
        },
        ignore = {
          buftype = { "quickfix" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo" }
        },
        animation = {
          enable = true,
          duration = 150,
          fps = 60,
          easing = "in_out_sine"
        }
      })
    end,
  },

  -- ========================================
  -- EDGY.NVIM (Animated sidebar management)
  -- Smooth animations for sidebars like neo-tree
  -- ========================================
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>ue", function() require("edgy").toggle() end, desc = "Toggle Edgy" },
      { "<leader>uE", function() require("edgy").select() end, desc = "Select Edgy window" },
    },
    opts = {
      animate = {
        enabled = true,
        fps = 60,
        cps = 120,
        on_begin = function()
          vim.g.minianimate_disable = true
        end,
        on_end = function()
          vim.g.minianimate_disable = false
        end,
        spinner = {
          frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
          interval = 80,
        },
      },
      bottom = {
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        "Trouble",
        { ft = "qf", title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
      },
      left = {
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          size = { height = 0.5 },
        },
        {
          title = "Neo-Tree Git",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          open = "Neotree position=right git_status",
        },
        {
          title = "Neo-Tree Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          open = "Neotree position=top buffers",
        },
        "neo-tree",
      },
      right = {
        {
          title = "Symbols Outline",
          ft = "Outline",
          size = { width = 0.15 },
        },
      },
    },
  },

  -- ========================================
  -- BUFFERLINE with animations
  -- ========================================
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Pin buffer" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
      { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
      { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
    },
    config = function()
      require("bufferline").setup({
        options = {
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          diagnostics = "nvim_lsp",
          always_show_bufferline = false,
          separator_style = "thin",
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
          },
          -- Smooth animations
          themable = true,
          numbers = "none",
          indicator = {
            icon = "▎",
            style = "icon",
          },
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
        },
        highlights = {
          buffer_selected = {
            italic = false,
            bold = true,
          },
        },
      })
    end,
  },

  -- ========================================
  -- NVIM-TREESITTER-CONTEXT (Sticky context)
  -- Shows function/class at top when scrolling
  -- ========================================
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<leader>ut",
        function()
          local tsc = require("treesitter-context")
          tsc.toggle()
        end,
        desc = "Toggle Treesitter Context",
      },
    },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 1,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
      })
    end,
  },

  -- ========================================
  -- STABILIZE.NVIM (Stable window opening)
  -- Prevents text jumping when opening windows
  -- ========================================
  {
    "luukvbaal/stabilize.nvim",
    event = "VeryLazy",
    config = function()
      require("stabilize").setup()
    end,
  },

  -- ========================================
  -- TWILIGHT (Focus mode with fade)
  -- Dims inactive code blocks
  -- ========================================
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
      { "<leader>uT", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.25,
          color = { "Normal", "#ffffff" },
          term_bg = "#000000",
          inactive = false,
        },
        context = 10,
        treesitter = true,
        expand = {
          "function",
          "method",
          "table",
          "if_statement",
        },
      })
    end,
  },

  -- ========================================
  -- ZEN-MODE (Distraction-free with animation)
  -- ========================================
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.95,
          width = 120,
          height = 1,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = "0",
            list = false,
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
            laststatus = 0,
          },
          twilight = { enabled = true },
          gitsigns = { enabled = false },
          tmux = { enabled = false },
        },
        on_open = function()
          vim.cmd([[Barbecue hide]])
        end,
        on_close = function()
          vim.cmd([[Barbecue show]])
        end,
      })
    end,
  },

  -- ========================================
  -- SNACKS.NVIM (Modern animations & UI)
  -- New modern plugin with smooth transitions
  -- ========================================
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>.",  function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>gg", function() Snacks.lazygit() end,        desc = "Lazygit" },
      { "<leader>gB", function() Snacks.gitbrowse() end,      desc = "Git Browse" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    },
    config = function()
      require("snacks").setup({
        animate = { enabled = true, fps = 60 },
        bigfile = { enabled = true },
        dashboard = { enabled = false }, -- Using alpha instead
        indent = { enabled = false },    -- Using indent-blankline instead
        input = { enabled = false },     -- Using dressing instead
        notifier = { enabled = false },  -- Using nvim-notify instead
        quickfile = { enabled = true },
        scroll = { enabled = false },    -- Disabled to prevent lag
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
          notification = {
            wo = { wrap = true },
            border = "rounded",
          },
        },
      })
    end,
  },
}
