-- [[ GENERAL SETTINGS ]] --

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

-- [[ KEYMAPPINGS ]] --

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

---@usage Unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""

---@usage Edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

--@usage Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- [[ TREESITTER ]] --

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg",
		files = { "src/parser.c", "src/scanner.cc" },
		branch = "main",
	},
	filetype = "norg",
}

lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"css",
	"java",
	"yaml",
	"norg",
	"comment",
}
lvim.builtin.treesitter.highlight.enabled = true

-- [[ LSP ]] --

lvim.lsp.automatic_servers_installation = true

-- Lazy load "LSP" setup
lvim.lsp.templates_dir = join_paths(get_runtime_dir(), "after", "ftplugin")

-- [[ PLUGINS ]] --

lvim.plugins = {
	-- Norg Note taking
	{
		"nvim-neorg/neorg",
		ft = "norg",
		branch = "unstable",
		config = function()
			require("ashin.neorg")
		end,
		requires = "nvim-neorg/neorg-telescope",
	},
}

-- [[ PLUGIN OVERRIDES ]] --

lvim.builtin.terminal.active = true

-- [[ AUTOCOMMANDS ]] --
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
