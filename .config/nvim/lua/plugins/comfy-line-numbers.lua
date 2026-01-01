return {
  -- Update this line to the correct repository
  "mluders/comfy-line-numbers.nvim", 

  config = function()
    require('comfy-line-numbers').setup({
      labels = (function()
        local labels = {}
        for i = 0, 25 do
          for j = 1, 5 do
            table.insert(labels, tostring(i == 0 and j or (i * 10 + j)))
          end
        end
        return labels
      end)(),
      up_key = 'k',
      down_key = 'j',
      hidden_file_types = { 'undotree' },
      hidden_buffer_types = { 'terminal', 'nofile' }
    })
  end
}
