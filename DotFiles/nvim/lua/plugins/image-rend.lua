return {
  {
  'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
        render_modes = { 'n', 'c', 'i' }, -- Render in Normal, Command, and Insert mode
        anti_conceal = { enabled = true }, -- Shows the markdown source on the current line
    },
  },

  {
    "3rd/image.nvim",
    opts = {
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true, -- Necessary for the neovim.io link in your test
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" },
      },
    },
    max_width = 100,
    max_height = 12,
    window_overlap_clear_enabled = true, -- prevents images from bleeding into other windows
    },
  },
 
  {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    size = 20,
    open_mapping = [[<c-\>]], -- Press Ctrl + \ to open/hide
    direction = 'horizontal',      -- 'vertical', 'horizontal', or 'float'
    float_opts = {
      border = 'curved',      -- Matches your rounded table/markdown look
      },
    }
  },
}
