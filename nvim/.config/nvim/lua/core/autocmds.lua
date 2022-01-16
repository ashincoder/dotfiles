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
         "silent lua vim.lsp.buf.formatting_sync()",
      },
      _filetypechanges = {
         { "BufWinEnter", ".zsh", "setlocal filetype=sh" },
         { "BufRead", "*.zsh", "setlocal filetype=sh" },
         { "BufNewFile", "*.zsh", "setlocal filetype=sh" },
      },
   },
}
