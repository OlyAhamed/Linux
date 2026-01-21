return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      -- This table lists what should be see-through
      extra_groups = {
        "NormalFloat", -- For floating windows (like LSP)
        "NvimTreeNormal", -- For your file explorer
      },
    })
    
    -- Command to toggle it on/off just in case
    vim.keymap.set('n', '<leader>tt', ':TransparentToggle<CR>', { desc = "Toggle Transparency" })
  end
}
