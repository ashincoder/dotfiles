--- A function to inspect or output of a given command
--- @param v string
--- @return string
P = function(v)
   print(vim.inspect(v))
   return v
end

--- A Reload function to reload given module
--- @return function
RELOAD = function(...)
   return require("plenary.reload").reload_module(...)
end

--- A function which requires the reloaded modules
--- @param name string
--- @return string
R = function(name)
   RELOAD(name)
   return require(name)
end

require "modules.builtin.mkdir"
