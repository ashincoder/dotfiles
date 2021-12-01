local utils = {}

---A mapping helper for the ease of creating key bindings
---@param mode string
---@param lhs string
---@param rhs string
---@param opts string
function utils.map(mode, lhs, rhs, opts)
   local options = { noremap = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---A function for lazy loading plugins after a loop
---@param plugin string
---@param timer number
function utils.lazy_load(plugin, timer)
   if plugin then
      timer = timer or 0
      vim.defer_fn(function()
         require("packer").loader(plugin)
      end, timer)
   end
end

---@param definitions table
function utils.define_augroups(definitions)
   for group_name, definition in pairs(definitions) do
      vim.cmd("augroup " .. group_name)
      vim.cmd "autocmd!"

      for _, def in pairs(definition) do
         local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
         vim.cmd(command)
      end

      vim.cmd "augroup END"
   end
end

---A function to check if the give lsp_client is active
---@param name string
---@return boolean
function utils.check_lsp_client_active(name)
   local clients = vim.lsp.get_active_clients()
   for _, client in pairs(clients) do
      if client.name == name then
         return true
      end
   end
   return false
end

--- Check if string is empty or if it's nil
--- @param str string The string to be checked
--- @return boolean
utils.is_empty = function(str)
  return str == "" or str == nil
end

utils.escape_str = function(str)
  local escape_patterns = {
    "%^",
    "%$",
    "%(",
    "%)",
    "%[",
    "%]",
    "%%",
    "%.",
    "%-",
    "%*",
    "%+",
    "%?",
  }

  return str:gsub(("([%s])"):format(table.concat(escape_patterns)), "%%%1")
end

--- Check if the given file exists
--- @param path string The path of the file
--- @return boolean
utils.file_exists = function(path)
  local fd = vim.loop.fs_open(path, "r", 438)
  if fd then
    vim.loop.fs_close(fd)
    return true
  end

  return false
end

return utils
