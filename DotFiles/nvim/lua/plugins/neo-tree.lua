return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- This makes hidden files "dimmed" but still visible
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            -- ".git",
            -- "node_modules",
          },
          always_show = { -- remains visible even if other rules would hide it
            -- ".env",
          },
        },
      },
    },
  },
}



