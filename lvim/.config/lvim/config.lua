-- [[ GENERAL SETTINGS ]] --

vim.g.did_load_filetypes = 1 -- Disabling native filetype checker
lvim.colorscheme = "doom-one"
lvim.log.level = "warn"
lvim.format_on_save = true

-- [[ KEYMAPPINGS ]] --

lvim.leader = "space"
---@usage Unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""

---@usage Edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

---@usage Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["n"] = {
	name = "Neogen",
	c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
	f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
	t = { "<cmd>lua require('neogen').generate({ type = 'type'})<CR>", "Type Documentation" },
}

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
parser_configs.norg_meta = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
		files = { "src/parser.c" },
		branch = "main",
	},
}

parser_configs.norg_table = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
		files = { "src/parser.c" },
		branch = "main",
	},
}

parser_configs.org = {
	install_info = {
		url = "https://github.com/milisims/tree-sitter-org",
		revision = "main",
		files = { "src/parser.c", "src/scanner.cc" },
	},
	filetype = "org",
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
	"norg_meta",
	"norg_table",
	"org",
	"comment",
}
lvim.builtin.treesitter.highlight.enabled = true

-- [[ LSP ]] --

-- Lazy load "LSP" setup
lvim.lsp.templates_dir = join_paths(get_runtime_dir(), "after", "ftplugin")

-- [[ PLUGINS ]] --

lvim.plugins = {

	-- Colorscheme
	{ "NTBBloodbath/doom-one.nvim" },
	{ "luisiacc/gruvbox-baby" },

	-- Dashboard
	{
		"goolord/alpha-nvim",
		event = "BufWinEnter",
		config = function()
			require("ashin.dashboard")
		end,
	},

	-- Faster version of filetype.vim
	{ "nathom/filetype.nvim" },

	-- Lsp-signature
	{
		"ray-x/lsp_signature.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lsp_signature").setup({})
		end,
	},

	-- Norg Note taking
	{
		"nvim-neorg/neorg",
		ft = "norg",
		config = function()
			require("ashin.neorg")
		end,
		requires = "nvim-neorg/neorg-telescope",
	},
	-- Annotation generator
	{
		"danymat/neogen",
		event = "InsertEnter",
		config = function()
			require("neogen").setup({
				enabled = true,
			})
		end,
	},
	-- Colorize HEX codes
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("ashin.colorizer")
		end,
		event = "BufRead",
	},

	-- Orgmode
	{
		"kristijanhusak/orgmode.nvim",
		ft = { "org" },
		config = function()
			require("orgmode").setup({
				diagnostics = true,
				org_hide_leading_stars = true,
				org_ellipsis = " ▼",
				-- org_indent_mode = "noindent",
			})
		end,
		requires = {
			{
				"akinsho/org-bullets.nvim",
				ft = { "org" },
				config = function()
					require("org-bullets").setup({})
				end,
			},
		},
	},

	-- Match Parens
	{
		"andymass/vim-matchup",
		event = "BufRead",
	},

	-- Lightspeed motion
	{
		"ggandor/lightspeed.nvim",
		after = "gitsigns.nvim",
		config = function()
			require("lightspeed").setup({})
		end,
	},
}

-- [[ PLUGIN OVERRIDES ]] --

lvim.builtin.terminal.active = true
lvim.builtin.notify.active = true
require("ashin.mkdir")

-- [[ AUTOCOMMANDS ]] --
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
