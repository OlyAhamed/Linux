return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  priority = 1000,
  config = function()
    -- Check if treesitter is available before configuring
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      vim.notify("nvim-treesitter.configs not available. Run :TSUpdate", vim.log.levels.WARN)
      return
    end

    configs.setup({
      -- List of parsers to install
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "diff",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },

      -- Install parsers synchronously (only applied to ensure_installed)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- List of parsers to ignore installing (for "all")
      ignore_install = {},

      ---- Syntax highlighting ----
      highlight = { enable = true },
      indent = { enable = true },


    })

    -- Enable folding based on treesitter
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false
  end,
}
