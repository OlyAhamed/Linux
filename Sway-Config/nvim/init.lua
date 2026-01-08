-- keymaps
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})

-- imports
require("config.lazy")
require("vim-options") 
-- luckluster
require("lackluster").setup({})
vim.cmd.colorscheme("lackluster")
vim.opt.background = "dark"

