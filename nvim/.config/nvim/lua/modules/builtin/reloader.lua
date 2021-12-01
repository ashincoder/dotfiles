-- The source of this file is doom-nvim.
-- src: https://github.com/NTBBloodbath/doom-nvim
--- @class Reloader
local reloader = {}

local utils = require "core.utils"
local config_root = vim.fn.stdpath "config"
local sep = package.config:sub(1, 1)

--- Paths to reload plugins
local plugins_files_path = string.format(
   "%s%ssite%spack%spacker%sstart%s*",
   vim.fn.stdpath "data",
   sep,
   sep,
   sep,
   sep,
   sep
)
local vim_subdirs = { "doc", "after", "syntax", "plugin" }

local installed_plenary, _ = pcall(require, "plenary")
if not installed_plenary then
   error "Please install plenary"
   return
end

local scan_dir = require("plenary.scandir").scan_dir

--- Converts a Lua module path into an acceptable Lua module format
--- @param module_path string The path to the module
--- @return string
local function path_to_lua_module(module_path)
   local lua_path = string.format("%s%slua", config_root, sep)

   -- Remove the Neovim config dir and the file extension from the path
   module_path = string.match(module_path, string.format("%s%s(.*)%%.lua", utils.escape_str(lua_path), sep))

   -- Replace '/' with '.' to follow the common Lua modules format
   module_path = module_path:gsub(sep, ".")

   -- Remove '.init' if the module ends with it
   module_path = module_path:gsub("%.init$", "")

   return module_path
end

--- Gets the runtime files found in the given path
--- @param parent_path string The parent path to look for files
--- @return table
local function get_runtime_files(parent_path)
   local runtime_files = {}

   -- Look in each Neovim subdir for runtime files (documentation, syntax files, etc)
   for _, subdir in ipairs(vim_subdirs) do
      local path = string.format("%s%s%s", parent_path, sep, subdir)

      if utils.file_exists(path) then
         local dir_files = {}
         -- We scan VimL and Lua files because some plugins has a 'plugin/foo.lua' file
         local dir_vim_files = scan_dir(path, { search_pattern = "%.vim$", hidden = true })
         local dir_lua_files = scan_dir(path, { search_pattern = "%.lua$", hidden = true })
         vim.list_extend(dir_files, dir_vim_files)
         vim.list_extend(dir_files, dir_lua_files)

         for _, file in ipairs(dir_files) do
            runtime_files[#runtime_files + 1] = file
         end
      end
   end

   return runtime_files
end

--- Gets all the Lua files found in '~/.config/nvim/lua' directory
--- @return table
local function get_lua_modules(path)
   -- Look for Lua modules in Nvim Config root
   local modules = scan_dir(path, { search_pattern = "%.lua$", hidden = true })
   for idx, module in ipairs(modules) do
      module = path_to_lua_module(module)

      -- Override previous value with new value
      modules[idx] = module
   end

   return modules
end

--- Reloads all Neovim runtime files found in plugins
local function reload_runtime_files()
   local paths = vim.fn.glob(plugins_files_path, 0, 1)

   for _, path in ipairs(paths) do
      local runtime_files = get_runtime_files(path)

      for _, file in ipairs(runtime_files) do
         vim.cmd("silent! source " .. file)
      end
   end
end

--- Reload a Lua module
--- @param mod_path string The configuration module path
--- @param quiet boolean If the reloader should send an info log or not
reloader.reload_lua_module = function(mod_path, quiet)
   if mod_path:find "/" then
      mod_path = path_to_lua_module(mod_path)
   end

   -- Get the module from package table
   local mod = package.loaded[mod_path]

   -- Unload the module and load it again
   package.loaded[mod_path] = nil
   require(mod_path)

   if type(mod) == "function" then
      -- Call the loaded module function so the reloading will take effect as expected
      local ok, _ = pcall(package.loaded[mod_path])
      if not ok then
         error(string.format("Failed to reload '%s' module", mod_path))
      end
   end

   if not quiet then
      print(string.format("Successfully reloaded '%s' module", mod_path))
   end
end

--- Reload all Lua modules
--- @param quiet boolean If the reloader should send an info log or not
reloader.reload_lua_modules = function(quiet)
   local paths = vim.fn.glob(config_root .. sep .. "lua", 0, 1)

   for _, path in ipairs(paths) do
      local modules = get_lua_modules(path)

      for _, module in ipairs(modules) do
         reloader.reload_lua_module(module, quiet)
      end
   end
end

--- Reload the plugins definitions modules like doom_modules.lua to automatically
--- install or uninstall plugins on changes
reloader.reload_plugins_definitions = function()
   -- Silently reload plugins modules
   reloader.reload_lua_module("core", true)
   reloader.reload_lua_module("modules", true)
   reloader.reload_lua_module("lsp", true)

   -- Cleanup disabled plugins
   vim.cmd "PackerClean"
   -- Defer the installation of new plugins to avoid a weird bug where packer
   -- tries to clean the plugins that are being installed right now
   vim.defer_fn(function()
      vim.cmd "PackerInstall"
   end, 200)
   vim.defer_fn(function()
      -- Compile plugins changes and simulate a new Neovim launch
      -- to load recently installed plugins
      -- NOTE: this won't work to live disable uninstalled plugins,
      -- They will keep working until you relaunch Neovim
      vim.cmd [[
      PackerCompile
      doautocmd VimEnter
    ]]
   end, 800)
end

--- Reload all Neovim configurations
reloader.reload_configs = function()
   --- Restart running language servers
   if vim.fn.exists ":LspRestart" ~= 0 then
      vim.cmd "silent! LspRestart"
   end

   --- Source Doom init
   vim.cmd "source $MYVIMRC"

   --- Reload all loaded Lua modules
   reloader.reload_lua_modules(true)

   --- Reload start plugins
   reload_runtime_files()
end

--- Reload Neovim and simulate a new run
reloader.full_reload = function()
   --- Reload Neovim configurations
   reloader.reload_configs()

   --- Run VimEnter autocommand to simulate a new Neovim launch
   --- and reload all buffers
   vim.cmd [[
    doautocmd VimEnter
  ]]
end

return reloader