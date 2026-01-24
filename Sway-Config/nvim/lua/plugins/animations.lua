return {
  -- ============================================================================
  -- NEOSCROLL - Smooth scrolling animations
  -- ============================================================================
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      local neoscroll = require('neoscroll')
      neoscroll.setup({
        mappings = {}, 
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = "sine",
      })

      local keymap = {
        ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 100 }) end,
        ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 100 }) end,
        ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 150 }) end,
        ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 150 }) end,
        ["zt"]    = function() neoscroll.zt({ duration = 100 }) end,
        ["zz"]    = function() neoscroll.zz({ duration = 100 }) end,
        ["zb"]    = function() neoscroll.zb({ duration = 100 }) end,
      }

      for key, func in pairs(keymap) do
        vim.keymap.set({ 'n', 'v', 'x' }, key, func)
      end
    end,
  },

-- ============================================================================
  -- MINI.ANIMATE - Forced Kanagawa Colors
  -- ============================================================================
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    config = function()
      local animate = require("mini.animate")
      
      animate.setup({
        -- ... cursor and scroll settings ...
        open = {
          enable = true,
          winconfig = animate.gen_winconfig.wipe({ direction = 'from_edge' }),
        },
        close = {
          enable = true,
          winconfig = animate.gen_winconfig.wipe({ direction = 'to_edge' }),
        },
      })

      -- CHANGE THE FLASH COLOR HERE
      -- SumiInk1 (#1F1F28) is the standard Kanagawa background.
      -- SumiInk3 (#363646) is a slightly lighter grey if you want to see the "slide" clearly.
      vim.api.nvim_set_hl(0, "MiniAnimateNormalFloat", { bg = "#1F1F28" })
    end,
  },

  -- ============================================================================
  -- SYSTEM SETTINGS - Universal Color Match
  -- ============================================================================
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- This ensures that even before the plugin fully loads, 
      -- any new floating window uses Kanagawa colors instead of black.
      local kanagawa_ink = "#1F1F28"
      
      local groups = {
        "NormalFloat", 
        "FloatBorder", 
        "NeoTreeNormal", 
        "NeoTreeNormalNC",
        "MiniAnimateNormalFloat"
      }
      
      for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = kanagawa_ink })
      end
    end,
  },  -- ============================================================================
  -- NOICE.NVIM - Smooth command line and notifications
  -- ============================================================================
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          lsp_doc_border = true,
        },
        views = {
          cmdline_popup = {
            position = { row = "50%", col = "50%" },
            win_options = { winhighlight = "NormalFloat:None,FloatBorder:None" },
          },
        },
      })
    end,
  },

  -- ============================================================================
  -- NOTIFY - Transparent animations
  -- ============================================================================
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#00000000", -- Fully transparent
        fps = 60,
        render = "wrapped-compact",
        stages = "fade_in_slide_out",
      })
      vim.notify = require("notify")
    end,
  },

  -- ============================================================================
  -- EXTRA SYSTEM SETTINGS (Transparency & Speed)
  -- ============================================================================
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.opt.smoothscroll = true
      vim.opt.updatetime = 200
      vim.opt.scrolloff = 8
      vim.opt.termguicolors = true
      
      -- Force transparency on all floating windows/explorers
      local highlights = {
        "NormalFloat", "FloatBorder", "NeoTreeNormal", "NeoTreeNormalNC",
        "NvimTreeNormal", "NvimTreeNormalNC"
      }
      for _, hl in ipairs(highlights) do
        vim.api.nvim_set_hl(0, hl, { bg = "none" })
      end
    end,
  },
}
