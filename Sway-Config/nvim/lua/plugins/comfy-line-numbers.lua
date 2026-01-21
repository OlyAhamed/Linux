return {
  -- ========================================
  -- BETTER LINE NUMBERS
  -- Shows absolute numbers with highlighted current line
  -- ========================================
  {
    "lukas-reineke/virt-column.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("virt-column").setup()
    end,
  },

  -- ========================================
  -- NUMBER HIGHLIGHTING
  -- Makes current line number stand out
  -- ========================================
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

  -- ========================================
  -- LINE NUMBER CONFIGURATION
  -- This configures Neovim's built-in line numbers
  -- ========================================
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    priority = 900,
    config = function()
      -- Enable line numbers
      vim.opt.number = true
      vim.opt.relativenumber = false -- Set to true if you want relative numbers
      
      -- Highlight current line
      vim.opt.cursorline = true
      vim.opt.cursorlineopt = "both" -- Highlight both line number and text
      
      -- Sign column (for git signs, diagnostics)
      vim.opt.signcolumn = "yes"
      vim.opt.numberwidth = 4
      
      -- Custom highlight for current line number
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        callback = function()
          -- Current line number - bright and bold
          vim.api.nvim_set_hl(0, "CursorLineNr", {
            fg = "#89b4fa", -- Catppuccin blue
            bold = true,
          })
          
          -- Regular line numbers - dimmed
          vim.api.nvim_set_hl(0, "LineNr", {
            fg = "#6c7086", -- Catppuccin gray
          })
          
          -- Current line background - subtle
          vim.api.nvim_set_hl(0, "CursorLine", {
            bg = "#313244", -- Catppuccin surface0
          })
        end,
      })
      
      -- Trigger the autocmd immediately
      vim.cmd("doautocmd ColorScheme")
    end,
  },

  -- ========================================
  -- STATUSCOL (Enhanced status column)
  -- Makes line numbers even prettier with git signs
  -- ========================================
  {
    "luukvbaal/statuscol.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          -- Line number segment
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          -- Git signs segment
          {
            sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
            click = "v:lua.ScSa",
          },
          -- Fold column segment
          {
            text = { builtin.foldfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScFa",
          },
        },
      })
    end,
  },

  -- ========================================
  -- ALTERNATIVE: If you want RELATIVE numbers
  -- Uncomment this section and set relativenumber = true above
  -- ========================================
  -- This shows relative numbers (0 at cursor, then 1,2,3 above/below)
  -- but keeps absolute number on current line
  {
    "sitiom/nvim-numbertoggle",
    event = { "BufReadPost", "BufNewFile" },
    enabled = false, -- Set to true if you want relative numbers
    config = function()
      -- This automatically toggles between relative and absolute
      -- based on insert mode / focus
    end,
  },
}
