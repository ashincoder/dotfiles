return {
   {
      "wbthomason/packer.nvim",
      setup = function()
         require("core.mappings").packer()
      end,
   },

   -- TODO: Remove this when https://github.com/neovim/neovim/pull/15436 gets into upstream
   {
      "lewis6991/impatient.nvim",
      config = function()
         require("impatient").enable_profile()
      end,
   },

   -- NOTE: issue https://github.com/neovim/neovim/issues/12587 is still open
   { "antoinemadec/FixCursorHold.nvim" },

   -- NOTE: faster version of filetype.vim
   { "nathom/filetype.nvim" },

   -- Colorscheme
   --[[ {
      "NTBBloodbath/doom-one.nvim",
      config = function()
         require("doom-one").setup {
            italic_comments = true,
         }
      end,
   }, ]]

   {
      "tiagovla/tokyodark.nvim",
   },

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
         require("lualine").setup {
            options = { theme = "tokyodark" },
         }
      end,
   },

   -- Bufferline
   {
      "jose-elias-alvarez/buftabline.nvim",
      event = "BufWinEnter",
      config = function()
         require("buftabline").setup {}
      end,
   },

   -- All important lua functions
   {
      "nvim-lua/plenary.nvim",
      module = "plenary",
   },

   -- Completion engine
   {
      "hrsh7th/nvim-cmp",
      modules = "cmp",
      config = function()
         require "modules.configs.cmp"
      end,
      requires = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-emoji",
         "hrsh7th/cmp-path",
         "saadparwaiz1/cmp_luasnip",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-calc",
         "hrsh7th/cmp-cmdline",
         "onsails/lspkind-nvim",
      },
   },

   -- Snippets
   {
      "L3MON4D3/LuaSnip",
      after = "nvim-cmp",
      wants = "friendly-snippets",
      requires = {
         {
            "rafamadriz/friendly-snippets",
         },
      },
      config = function()
         require("modules.configs.others").luasnip()
      end,
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
         require("Comment").setup {}
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
               require("org-bullets").setup {}
            end,
         },
      },
   },

   -- More than a fuzzy finder
   {
      "nvim-telescope/telescope.nvim",
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
      after = "nvim-treesitter",
      config = function()
         require "modules.configs.neorg"
      end,
      requires = "nvim-neorg/neorg-telescope",
   },

   {
      "davidgranstrom/nvim-markdown-preview",
      ft = "markdown",
   },

   -- Zen mode

   -- Magit like neogit
   --[[ {
      "TimUntersberger/neogit",
      module = "neogit",
      cmd = "Neogit",
      setup = function()
         require("core.mappings").neogit()
      end,
   }, ]]

   -- Notifier for neovim
   {
      "rcarriga/nvim-notify",
      event = "BufWinEnter",
      config = function()
         require("notify").setup {
            timeout = 1000,
         }
      end,
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

   -- Pretty fold
   {
      "anuvyklack/pretty-fold.nvim",
      config = function()
         require("pretty-fold").setup {}
         require("pretty-fold.preview").setup()
      end,
   },

   -- Code runner
   {
      "michaelb/sniprun",
      run = "bash ./install.sh",
      cmd = "SnipRun",
      module = "sniprun",
   },

   -- Math calc
   {
      "max397574/vmath.nvim",
      cmd = "Vmath",
      config = function()
         require("vmath_nvim").init()
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
      setup = function()
         require("core.utils").lazy_load "gitsigns.nvim"
      end,
   },

   -- Lightspeed motion
   {
      "ggandor/lightspeed.nvim",
      after = "gitsigns.nvim",
      config = function()
         require("lightspeed").setup {}
      end,
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
