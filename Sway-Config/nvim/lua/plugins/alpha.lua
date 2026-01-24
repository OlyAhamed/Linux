return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                                                    ]],
      [[  ██╗  ██╗   █████   ███████ ██████ ███  ██╗            ]],
      [[  ██████  ██╔══███╗  ██╔══════╝  ██╔═══██╗ █████╗ ██║            ]],
      [[   █████   █████████║  ███████   ████████╔╝ ██╔███╗██║            ]],
      [[   █████   ██╔══████║  ██╔════╝   ██╔═══██╗  ██║╚█████║            ]],
      [[  ██████ ██║  ████║  █████████ ██║   ██║  ██║ ╚████║            ]],
      [[  ╚══╝  ╚══╝ ╚═╝  ╚═══╝  ╚════════╝ ╚═╝   ╚═╝  ╚═╝  ╚═══╝            ]],
      [[                                                                    ]],
      [[                --- TO LOVE UNTIL IT HURTS ---                     ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰈞  > Find file", ":Telescope find_files <CR>"),
      dashboard.button("r", "  > Recent", ":Telescope oldfiles <CR>"),
      dashboard.button("s", "  > Settings", ":e ~/.config/nvim/init.lua <CR>"),
      dashboard.button("q", "󰅚  > Quit NVIM", ":qa <CR>"),
    }

    -- THE FIX: Instead of hex codes, link to theme-aware highlight groups
    -- "Type" is usually a bright primary color (blue/purple)
    -- "Comment" is usually a subtle gray
    -- "Keyword" is usually a distinct secondary color
    dashboard.section.header.opts.hl = "Type" 
    dashboard.section.buttons.opts.hl = "Comment"

    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 4 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)

    -- Disable folding and line numbers on the dashboard
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.laststatus = 3 -- Keep global statusline if you want
      end,
    })
  end,
}
