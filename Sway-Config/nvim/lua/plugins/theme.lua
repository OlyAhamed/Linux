return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      -- Define a transparent custom theme based on 'auto'
      local custom_auto = require("lualine.themes.auto")

      -- Loop through all modes (normal, insert, etc.) and parts (a, b, c)
      -- to set background to nil (transparent)
      for _, mode in pairs(custom_auto) do
        for _, section in pairs(mode) do
          if type(section) == "table" then
            section.bg = nil
          end
        end
      end

      require("lualine").setup({
        options = {
          theme = custom_auto, -- Use our modified transparent theme
          globalstatus = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "│", right = "│" },
          disabled_filetypes = { statusline = { "alpha", "dashboard" } },
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "", right = "" }, padding = 0 },
          },
          lualine_b = {
            { "branch", icon = "" },
            { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          },
          lualine_c = {
            { "filename", file_status = true, path = 1, font_weight = "bold" },
            { "diagnostics" },
          },
          lualine_x = {
            { "filetype", icon_only = true },
          },
          lualine_y = {
            { "progress", separator = { left = "", right = "" }, padding = 0 },
          },
          lualine_z = {
            { "location", separator = { left = "", right = "" }, padding = 0 },
          },
        },
      })
    end,
  },
}
