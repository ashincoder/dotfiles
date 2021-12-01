-- Setup bashls server
require("lvim.lsp.manager").setup("bashls")

-- Linters for sh filetypes
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "shellcheck",
		filetypes = { "sh", "zsh", "bash" },
	},
})

-- Formatters for sh filetypes
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "shfmt",
		filetypes = { "sh", "zsh", "bash" },
	},
})
