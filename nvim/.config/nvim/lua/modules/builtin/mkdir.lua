-- A small function to create a directory when it doesn't exist inside neovim

---@class mkdir
local mkdir = {}

function mkdir.run()
   local dir = vim.fn.expand "%:p:h"

   if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
   end
end

vim.cmd [[autocmd BufWritePre * lua require('modules.builtin.mkdir').run()]]

return mkdir
