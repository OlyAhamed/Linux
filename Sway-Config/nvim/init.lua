-- 1. Setup cache path (Must be at the very top)
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

-- 2. Your existing options and keymaps
vim.g.mapleader = " "
require("vim-options")
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})

-- 3. Bootstrap Lazy & Setup Plugins
require("config.lazy")
require("lazy").setup("plugins")

-- 4. THE FIX: Load all cache files
local cache = vim.g.base46_cache
local present, _ = pcall(require, "nvchad")

if present then
  dofile(cache .. "defaults")
  dofile(cache .. "statusline")
  dofile(cache .. "syntax")
end
