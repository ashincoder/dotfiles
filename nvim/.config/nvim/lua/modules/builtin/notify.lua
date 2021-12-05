vim.notify = require "notify"

-- Notifies when the lsp server has started
vim.schedule(function()
   local msg = "Server has started"
   local clients = vim.lsp.buf_get_clients()
   if next(clients) == nil then
      vim.notify "No active clients"
   else
      vim.notify(msg)
   end
end)
