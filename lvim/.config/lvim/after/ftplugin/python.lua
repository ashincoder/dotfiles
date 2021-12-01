-- Setup pyright server
require("lvim.lsp.manager").setup("pyright")

-- Linters for python
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "flake8",
		filetypes = { "python" },
	},
})

-- Formatters for python
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "yapf",
		filetypes = { "python" },
	},
})
