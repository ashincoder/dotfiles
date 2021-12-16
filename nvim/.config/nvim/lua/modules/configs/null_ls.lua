local ok, null_ls = pcall(require, "null-ls")
if not ok then
   return
end
local linter = null_ls.builtins.diagnostics
local formatter = null_ls.builtins.formatting

local sources = {
   formatter.prettier,
   linter.yamllint,
   formatter.trim_whitespace.with { filetypes = { "teal", "zsh", "norg" } },

   -- Lua
   formatter.stylua,
   linter.luacheck.with { extra_args = { "--global vim" } },

   -- Python
   formatter.yapf,
   formatter.isort,
   linter.flake8,

   -- Shell
   formatter.shfmt,
   linter.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

   null_ls.builtins.hover.dictionary.with { filetypes = { "norg", "txt", "markdown" } },
}

local M = {}
M.setup = function()
   null_ls.setup {
      -- debug = true,
      sources = sources,
   }
end

return M
