return {
  {
    "kitty-sync",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    config = function()
      local group = vim.api.nvim_create_augroup("KittySync", { clear = true })

      -- Function for switching/opening (Async)
      local function sync_to_kitty()
        local bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg#")
        if bg and bg ~= "" and bg ~= "NONE" then
          vim.fn.jobstart({ "kitty", "@", "set-colors", "background=" .. bg })
        end
      end

      -- 1. Sync on Start and Theme Change
      vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
        group = group,
        callback = function()
          vim.defer_fn(sync_to_kitty, 20)
        end,
      })

      -- 2. RESET on Exit (Synchronous)
      -- Using os.execute ensures the command is sent before Neovim closes
      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = group,
        callback = function()
          os.execute("kitty @ set-colors background=reset")
        end,
      })
    end,
  },
}
