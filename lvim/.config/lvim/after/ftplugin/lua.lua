-- Linters for lua
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "luacheck",
		args = { "--global vim" },
		filetypes = { "lua" },
	},
})

-- Formatters for lua
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "stylua",
		filetypes = { "lua" },
	},
})
