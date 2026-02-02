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
    -- UI Options
    vim.opt.number = true
    vim.opt.relativenumber = false
    vim.opt.cursorline = true
    vim.opt.cursorlineopt = "both"
    vim.opt.signcolumn = "yes"
    vim.opt.numberwidth = 4

    -- Dynamic Highlighting
    vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
      callback = function()
        vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true })
      end,
    })
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
 }


