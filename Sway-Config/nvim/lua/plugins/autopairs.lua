return {
  -- ============================================================================
  -- AUTO-PAIRS - Automatically close brackets, quotes, etc.
  -- ============================================================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")

      autopairs.setup({
        -- Check for treesitter (syntax awareness)
        check_ts = true,

        -- Enable basic pairs
        enable_check_bracket_line = true,

        -- Disable in certain filetypes
        disable_filetype = { "TelescopePrompt", "vim" },

        -- Fast wrap - Press Alt+e to wrap word with brackets
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'Search',
          highlight_grey = 'Comment'
        },
      })

      -- Integration with nvim-cmp (completion)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")

      -- Make autopairs work with completion
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end,
  },

  -- ============================================================================
  -- AUTO-TAG - Automatically close and rename HTML/XML tags
  -- ============================================================================
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup({
        -- Filetypes where auto-tag works
        filetypes = {
          "html",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
          "tsx",
          "jsx",
          "rescript",
          "xml",
          "php",
          "markdown",
          "astro",
          "glimmer",
          "handlebars",
          "hbs",
        },
      })
    end,
  },

  -- ============================================================================
  -- TREESITTER - Required for nvim-ts-autotag
  -- ============================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Install parsers for these languages
        ensure_installed = {
          "html",
          "css",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "lua",
          "python",
          "rust",
          "go",
          "c",
          "cpp",
          "yaml",
          "markdown",
        },

        -- Install parsers synchronously (only for ensure_installed)
        sync_install = false,

        -- Auto-install missing parsers when entering buffer
        auto_install = true,

        -- Highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Indentation based on treesitter
        indent = {
          enable = true,
        },

        -- Auto-tagging (for HTML tags)
        autotag = {
          enable = true,
        },
      })
    end,
  },
}
