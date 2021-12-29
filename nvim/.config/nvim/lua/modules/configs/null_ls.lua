local ok, null_ls = pcall(require, "null-ls")
if not ok then
   return
end
local linter = null_ls.builtins.diagnostics
local formatter = null_ls.builtins.formatting

local sources = {
   formatter.prettier,
   linter.yamllint,
   formatter.trim_whitespace.with {
      filetypes = { "teal", "org", "zsh", "norg" },
   },

   -- Lua
   formatter.stylua,
   linter.luacheck.with {
      extra_args = { "--global vim" },
   },

   -- Python
   formatter.yapf,
   formatter.isort,
   linter.flake8,

   -- Shell
   formatter.shfmt.with {
      filetypes = { "sh", "bash", "zsh" },
   },
   linter.shellcheck.with {
      filetypes = { "sh", "bash", "zsh" },
      diagnostics_format = "#{m} [#{c}]",
   },

   null_ls.builtins.hover.dictionary.with { filetypes = { "norg", "org", "txt", "markdown" } },
}

local M = {}
M.setup = function()
   null_ls.setup {
      debug = false,
      sources = sources,
   }
end

return M
