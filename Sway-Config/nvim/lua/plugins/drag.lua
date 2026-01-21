return {
  -- We use 'dir' just to give it a name, but we don't actually download anything
  "custom-mouse-drag",
  dir = vim.fn.stdpath("config"), 
  config = function()
    -- 1. Enable Mouse
    vim.opt.mouse = 'a'

    -- 2. Setup Horizontal Scrolling (VS Code Style)
    vim.opt.wrap = false          -- Don't wrap lines
    vim.opt.sidescroll = 1        -- Scroll 1 character at a time (smooth)
    vim.opt.sidescrolloff = 15    -- Keep cursor 15 chars away from the edge

    -- 3. Mouse Wheel Horizontal Scroll
    -- Hold SHIFT and use the scroll wheel to move left/right
    vim.keymap.set({'n', 'i', 'v'}, '<S-ScrollWheelUp>', '5zh', { desc = 'Scroll left' })
    vim.keymap.set({'n', 'i', 'v'}, '<S-ScrollWheelDown>', '5zl', { desc = 'Scroll right' })

    -- 4. Click and Drag behavior
    -- This makes sure that dragging the mouse to select text 
    -- scrolls the window horizontally automatically.
    vim.opt.mousemodel = "extend"
  end
}
