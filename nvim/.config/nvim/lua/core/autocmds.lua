local definition = require "core.utils"

definition.define_augroups {
   _general_settings = {
      {
         "TextYankPost",
         "*",
         "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
      },
      {
         "BufWinEnter",
         "*",
         "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
      },
      {
         "BufRead",
         "*",
         "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
      },
      {
         "BufNewFile",
         "*",
         "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
      },
      {
         "BufWritePre",
         "*",
         "silent lua vim.lsp.buf.formatting()",
      },
      {
         "BufWritePost",
         "plugins.lua",
         "source <afile> | lua require('packer').sync()",
      },
      _filetypechanges = {
         { "BufWinEnter", ".zsh", "setlocal filetype=sh" },
         { "BufRead", "*.zsh", "setlocal filetype=sh" },
         { "BufNewFile", "*.zsh", "setlocal filetype=sh" },
      },
   },
}

-- Better folding
local sugar_folds = function()
   local start_line = vim.fn.getline(vim.v.foldstart):gsub("\t", ("\t"):rep(vim.opt.tabstop:get()))
   return string.format("%s ... (%d lines)", start_line, vim.v.foldend - vim.v.foldstart + 1)
end
