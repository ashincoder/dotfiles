-- Implemented from Lunarvim.
-- src: https://github.com/LunarVim/LunarVim

local plugin_loader = {}

function plugin_loader:init()
   local package_root = vim.fn.stdpath "data" .. "/site/pack"
   local install_path = package_root .. "/packer/opt/packer.nvim"

   if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
      print "Installing Packer"
      vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
      vim.cmd "packadd packer.nvim"
   end

   local packer_ok, packer = pcall(require, "packer")
   if not packer_ok then
      return
   end

   packer.init {
      git = {
         clone_timeout = 300, -- 5 mins
         subcommands = {
            -- Prevent packer from downloading all branches metadata to reduce cloning cost
            -- for heavy size plugins like plenary (removed the '--no-single-branch' git flag)
            install = "clone --depth %i --progress",
         },
      },
      display = {
         open_fn = function()
            return require("packer.util").float { border = "single" }
         end,
      },
      subcommands = {
         -- Prevent packer from downloading all branches metadata to reduce cloning cost
         -- for heavy size plugins like plenary (removed the '--no-single-branch' git flag)
         install = "clone --depth %i --progress",
      },
      profile = {
         enable = true,
      },
   }
end

--- Loops on the given configuration table
--- @param configurations table
function plugin_loader:load(configurations)
   plugin_loader:init()
   return require("packer").startup(function(use)
      for _, plugins in ipairs(configurations) do
         for _, plugin in ipairs(plugins) do
            use(plugin)
         end
      end
   end)
end

return plugin_loader
