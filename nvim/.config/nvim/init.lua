-- Important modules
local modules = {
   "impatient", -- I am not patient -..-
   "core", -- Heat and Core
}

-- NOTE: This is to solve any edge case. Normally when cache is cleared some error pops up.
-- So to not type "LuaCacheLog" everytime I am trying to automate it.
for _, module in ipairs(modules) do
   local ok, err = pcall(require, module)
   if not ok then
      error("Error loading core" .. "\n\n" .. err)
      vim.cmd ":silent LuaCacheLog"
   end
end

vim.defer_fn(function()
   -- Plugin Loader
   local plugins = require "modules"
   require("modules.loader"):load { plugins }
end, 0)

-- Language Server Protocol
require "lsp"
