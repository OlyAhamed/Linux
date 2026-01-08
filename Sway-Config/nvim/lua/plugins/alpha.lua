return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- 1. XAERN Fluid ASCII (Modern Slanted Font)
    dashboard.section.header.val = {
      [[                                                                   ]],
      [[  ██╗  ██╗   █████   ███████  ██████  ███  ██╗           ]],
      [[  ██████  ██╔══███╗  ██╔══════╝  ██╔═══██╗ █████╗ ██║           ]],
      [[   █████   █████████║  ███████   ████████╔╝ ██╔███╗██║           ]],
      [[   █████   ██╔══████║  ██╔════╝   ██╔═══██╗  ██║╚█████║           ]],
      [[  ██████ ██║  ████║  █████████ ██║   ██║  ██║ ╚████║           ]],
      [[  ╚══╝  ╚══╝ ╚═╝  ╚═══╝  ╚════════╝ ╚═╝   ╚═╝  ╚═╝  ╚═══╝           ]],
      [[                                                                   ]],
      [[                --- TO LOVE UNTIL IT HURTS ---                     ]],
    }

    -- 2. Combined Options Section (Exactly like your reference image)
    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰈞  > Find file", ":Telescope find_files <CR>"),
      dashboard.button("r", "  > Recent", ":Telescope oldfiles <CR>"),
      dashboard.button("s", "  > Settings", ":e ~/.config/nvim/init.lua <CR>"),
      dashboard.button("q", "󰅚  > Quit NVIM", ":qa <CR>"),
    }

    -- 3. Shadow & Prism Highlights
    vim.api.nvim_set_hl(0, "AlphaXaern", { fg = "#708090", bold = true }) -- Slate Blue
    vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#708070" })             -- Sage Green
    vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#807080" })            -- Dusty Purple

    dashboard.section.header.opts.hl = "AlphaXaern"
    dashboard.section.buttons.opts.hl = "AlphaButtons"

    -- 4. Layout
    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 4 }, -- Extra gap before buttons
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)
  end,
}
