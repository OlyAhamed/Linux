return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" }, -- Changed: Load with files, not immediately
  -- Removed: lazy = false, priority = 1000
  config = function()
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    configs.setup({
      ensure_installed = {
        "bash", "c", "cpp", "css", "diff", "go", "html",
        "javascript", "json", "lua", "markdown", "markdown_inline",
        "python", "query", "regex", "rust", "tsx", "typescript",
        "vim", "vimdoc", "yaml",
      },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- IMPORTANT: Added this line
      },
      
      indent = { enable = true },
    })

    -- Folding config
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false
  end,
}
