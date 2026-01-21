return {
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local indentscope = require("mini.indentscope")
      return {
        symbol = "│",
        options = { try_as_border = true },
        draw = {
          -- The delay before the animation starts (keep it low for responsiveness)
          delay = 50,
          -- Slowing down the animation and setting it to quadratic for smoothness
          animation = indentscope.gen_animation.quadratic({
            duration = 150, -- INCREASED: Default is ~20. 150-200 makes it very visible and "lazy"
            unit = "total",
          }),
        },
      }
    end,
    config = function(_, opts)
      require("mini.indentscope").setup(opts)

      -- Catppuccin Mauve "Glow"
      local function apply_glow()
        local has_cp, cp = pcall(require, "catppuccin.palettes")
        if has_cp then
          local palette = cp.get_palette("mocha") -- or your flavor
          vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = palette.mauve, bold = true })
        end
      end

      -- Apply on startup and theme change
      apply_glow()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_glow })

      -- Disable for noise-heavy windows
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "lazy", "mason" },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
  },
}
