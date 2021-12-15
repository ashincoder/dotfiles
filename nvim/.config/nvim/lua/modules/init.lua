return {
   {
      "wbthomason/packer.nvim",
      setup = function()
         require("core.mappings").packer()
      end,
   },

   -- TODO: Remove this when https://github.com/neovim/neovim/pull/15436 gets into upstream
   { "lewis6991/impatient.nvim" },

   -- NOTE: issue https://github.com/neovim/neovim/issues/12587 is still open
   { "antoinemadec/FixCursorHold.nvim" },

   -- NOTE: faster version of filetype.vim
   { "nathom/filetype.nvim" },

   -- Colorscheme
   { "NTBBloodbath/doom-one.nvim" },

   -- Dashboard
   {
      "goolord/alpha-nvim",
      event = "BufWinEnter",
      config = function()
         require "modules.configs.alpha"
      end,
   },

   -- Statusline
   {
      "nvim-lualine/lualine.nvim",
      event = "BufWinEnter",
      config = function()
         require "modules.configs.statusline"
      end,
   },

   -- Bufferline
   {
      "jose-elias-alvarez/buftabline.nvim",
      event = "BufWinEnter",
      config = function()
         require("buftabline").setup()
      end,
   },

   -- All important lua functions
   {
      "nvim-lua/plenary.nvim",
      module = "plenary",
   },

   -- Snippets
   {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         require("modules.configs.others").luasnip()
      end,
   },

   {
      "rafamadriz/friendly-snippets",
      after = "cmp-buffer",
   },

   -- Completion
   {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      module = "cmp",
      config = function()
         require "modules.configs.cmp"
      end,
   },

   {
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
   },

   {
      "hrsh7th/cmp-nvim-lua",
      ft = "lua",
   },

   {
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp",
   },

   {
      "hrsh7th/cmp-path",
      after = "cmp-buffer",
   },

   -- Neovim Lsp
   {
      "neovim/nvim-lspconfig",
      event = "BufRead",
   },

   {
      "williamboman/nvim-lsp-installer",
      event = "BufRead",
   },

   {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("modules.configs.null_ls").setup()
      end,
   },

   {
      "hrsh7th/cmp-nvim-lsp",
      after = "nvim-lspconfig",
   },

   {
      "ray-x/lsp_signature.nvim",
      module = "lsp_signature",
      config = function()
         require("modules.configs.others").signature()
      end,
   },

   -- Autopairs
   {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
         require("modules.configs.others").autopairs()
      end,
   },

   -- Icons
   {
      "kyazdani42/nvim-web-devicons",
      setup = function()
         require("core.utils").lazy_load "nvim-web-devicons"
      end,
   },

   -- Syntax parser and more
   {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
         require "modules.configs.treesitter"
      end,
   },

   -- Commenter
   {
      "numToStr/Comment.nvim",
      after = "nvim-treesitter",
      config = function()
         require("Comment").setup()
      end,
   },

   -- Annotations generator
   {
      "danymat/neogen",
      module = "neogen",
      config = function()
         require("neogen").setup {
            enabled = true,
         }
      end,
   },

   -- Orgmode
   {
      "kristijanhusak/orgmode.nvim",
      ft = { "org" },
      config = function()
         require("orgmode").setup {
            diagnostics = true,
            org_hide_leading_stars = true,
            org_ellipsis = " ▼",
            -- org_indent_mode = "noindent",
         }
      end,
      requires = {
         {
            "akinsho/org-bullets.nvim",
            ft = { "org" },
            config = function()
               require("org-bullets").setup()
            end,
         },
      },
   },

   -- More than a fuzzy finder
   {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = {
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
         },
      },
      config = function()
         require "modules.configs.telescope"
      end,
      setup = function()
         require("core.mappings").telescope()
      end,
   },

   -- Norg Note taking
   {
      "nvim-neorg/neorg",
      cmd = "Neorg",
      ft = "norg",
      config = function()
         require "modules.configs.neorg"
      end,
      requires = "nvim-neorg/neorg-telescope",
   },

   -- Zen mode
   {
      "folke/zen-mode.nvim",
      module = "zen-mode",
      cmd = "ZenMode",
      config = function()
         require("zen-mode").setup {}
      end,
   },

   -- Magit like neogit
   {
      "TimUntersberger/neogit",
      module = "neogit",
      cmd = "Neogit",
      setup = function()
         require("core.mappings").neogit()
      end,
   },

   -- Notifier for neovim
   {
      "rcarriga/nvim-notify",
      event = "BufWinEnter",
   },

   -- Gitsigns and diffs
   {
      "lewis6991/gitsigns.nvim",
      module = "gitsigns",
      setup = function()
         require("core.utils").lazy_load "gitsigns.nvim"
      end,
      config = function()
         require "modules.configs.gitsigns"
      end,
   },

   -- HEX code colorizer
   {
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
         require("modules.configs.others").colorizer()
      end,
   },

   -- Match Parens
   {
      "andymass/vim-matchup",
      after = "nvim-lspconfig",
   },

   -- Nvim Tree
   {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFocus" },
      config = function()
         require "modules.configs.nvimtree"
      end,
      setup = function()
         require("core.mappings").nvimtree()
      end,
   },
}
