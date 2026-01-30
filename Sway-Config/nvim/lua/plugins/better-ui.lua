return {

  -- lualine
  {'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- bufferline
  {'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  -- noice
  {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  keys = {
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
  },
  config = function()
    require("noice").setup({
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
        message = { enabled = true },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
      },
      messages = {
        enabled = true,
        view = "notify",
      },
      popupmenu = {
        enabled = false,
      },
    })
  end,
},
  -- notify
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss Notifications",
      },
    },
    config = function()
      local notify = require("notify")
      notify.setup({
        background_colour = "#000000",
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        stages = "fade_in_slide_out",
        render = "default",
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
      })
      vim.notify = notify
    end,
},

  -- dressing
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          enabled = true,
          default_prompt = "Input:",
          border = "rounded",
          elative = "cursor",
          prefer_width = 40,
          win_options = {
            winblend = 10,
            wrap = false,
          },
        },
        select = {
          enabled = true,
          backend = { "telescope", "builtin" },
          builtin = {
            border = "rounded",
            relative = "editor",
          },
        },
      })
    end,
  },

  -- comment-color
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
    config = function()
      require("todo-comments").setup({
        signs = true,
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        highlight = {
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
        },
      })
    end,
  },

  -- indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = {
          enabled = false,
        },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
          },
        },
      })
    end,
  },
  -- colorizer
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>uC", "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" },
    },
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = true,
          RRGGBBAA = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
          mode = "background",
          tailwind = true,
          virtualtext = "■",
        },
      })
    end,
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = { enabled = true, suggestions = 20 },
        },
        win = {
          border = "rounded",
        },
      })
      wk.add({
        { "<leader>s", group = "Search" },
        { "<leader>u", group = "UI" },
        { "<leader>x", group = "Diagnostics" },
      })
    end,
  },

  -- trouble
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
    },
    config = function()
      require("trouble").setup()
    end,
  },

  -- mini.nvim 
  {
    "nvim-mini/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.animate").setup({
        cursor = { enable = false },
        scroll = { enable = false },
        resize = { enable = true },
        open = { enable = true },
        close = { enable = true },
      })

      require("mini.ai").setup()

      require("mini.move").setup()
    end,
  },

  -- illuminate 
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 100,
        under_cursor = true,
      })
    end,
  },

  -- outline
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" },
    },
    config = function()
      require("outline").setup({
        outline_window = {
          position = "right",
          width = 25,
          auto_preview = false,
        },
        symbol_folding = {
          autofold_depth = 1,        },
        preview_window = {
          auto_preview = false,
        },
      })
    end,
  },
  -- scrollbar 
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      require("scrollbar").setup({
        handle = {
          color = "#3b4261",
        },
        handlers = {
          cursor = true,
          diagnostic = false,
          gitsigns = false,
          search = false,
        },
        marks = {
          Cursor = {
            text = " ",
            color = "#3b4261",
          },
        },
      })
    end,
  },

  -- glowing-indent
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      local indentscope = require("mini.indentscope")

      opts.draw = {
        delay = 50,
        animation = indentscope.gen_animation.quadratic({
          duration = 180,
          unit = "total",
        }),
      }

      indentscope.setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "lazy", "mason" },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
  },

}
