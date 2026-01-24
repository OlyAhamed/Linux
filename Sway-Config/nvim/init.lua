-- keymaps
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})

-- imports
require("config.lazy")
require("vim-options")

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

-- ... your lazy setup ...
require("lazy").setup("plugins")

-- Safe loading: only try to load if the cache exists
local cache = vim.g.base46_cache
local present, _ = pcall(require, "nvchad")

if present then
  dofile(cache .. "defaults")
  dofile(cache .. "statusline")
end

