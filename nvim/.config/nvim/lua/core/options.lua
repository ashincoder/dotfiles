---@class options
local options = {}

-- disable some builtin vim plugins
function options.disabled_builtins()
   local disabled_built_ins = {
      "2html_plugin",
      "getscript",
      "getscriptPlugin",
      "gzip",
      "logipat",
      "man",
      "matchit",
      "netrwFileHandlers",
      "netrwSettings",
      "rrhelper",
      "spellfile_plugin",
      "tar",
      "tarPlugin",
      "vimball",
      "vimballPlugin",
      "zip",
      "zipPlugin",
      -- "netrw",
      -- "netrwPlugin",
   }
   for _, plugin in pairs(disabled_built_ins) do
      vim.g["loaded_" .. plugin] = 1
   end
end

options.load_options = function()
   options.disabled_builtins()
   local opts = {
      background = "dark",
      clipboard = "unnamedplus",
      cmdheight = 1,
      showmode = false,
      completeopt = "menuone,noselect",
      cul = true, -- cursor line
      expandtab = true, -- Indentline
      hidden = true,
      ignorecase = true,
      mouse = "a",
      number = true, -- Numbers
      numberwidth = 2,
      relativenumber = true,
      ruler = true,
      scrolloff = 5,
      shiftwidth = 2,
      signcolumn = "yes",
      smartindent = true,
      autoindent = true,
      splitbelow = true,
      splitright = true,
      tabstop = 8,
      termguicolors = true,
      timeoutlen = 300,
      undofile = true,
      updatetime = 250,
      foldenable = true,
      laststatus = 2,
      -- showtabline = 2,
   }
   vim.g.did_load_filetypes = 1
   vim.g.mapleader = " "
   -- go to previous/next line with h,l,left arrow and right arrow
   vim.opt.fillchars = {
      eob = " ",
      vert = "▕",
      fold = " ",
      diff = "─",
      msgsep = "‾",
      foldopen = "▾",
      foldclose = "▸",
      foldsep = "│",
   }

   vim.cmd [[set foldtext=luaeval(\"require('core.autocmds').sugar_folds()\")]]
   vim.opt.shortmess:append "c"
   vim.opt.shortmess:append "sI"
   vim.opt.whichwrap:append "<>hl"
   -- Custom list chars
   vim.opt.list = true
   vim.opt.listchars:append "eol:↴"
   vim.opt.listchars:append "space: "

   -- Custom settings
   vim.g.colors_name = "catppuccin" -- Colorscheme
   --
   for k, v in pairs(opts) do
      vim.opt[k] = v
   end
end

return options
