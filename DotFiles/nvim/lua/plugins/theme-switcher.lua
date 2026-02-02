return {
  { "nvchad/volt", lazy = true },

  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
      
      -- Keybinding defined here to keep init.lua clean
      vim.keymap.set("n", "<leader>th", function()
        require("nvchad.themes").open()
      end, { desc = "Theme Picker" })
    end,
  },
}
