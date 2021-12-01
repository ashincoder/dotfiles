-- Main options
local options = require "core.options"
options.disabled_builtins()
options.load_options()

vim.defer_fn(function()
   require "core.autocmds"
   require("core.mappings").misc()

   vim.defer_fn(function()
      require "core.globals"
   end, 20)
end, 0)
