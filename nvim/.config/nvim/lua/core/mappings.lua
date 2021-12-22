local utils = require "core.utils"
local map = utils.map

local opts = { silent = true, noremap = true }

local M = {}

M.misc = function()
   -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
   map("", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
   map("", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
   map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
   map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

   -- use ESC to turn off search highlighting
   map("n", "<Esc>", ":noh <CR>", opts)

   -- Y, yanks the line after
   map("n", "Y", "y$<CR>", opts)

   -- Source file
   map("n", "<C-s>", ":source %<CR>", opts)

   -- Jump and align in the middle
   map("n", "n", "nzzzv", opts)
   map("n", "N", "Nzzzv", opts)

   -- Do J without moving the cursor
   map("n", "J", "mzJ'z", opts)

   -- Better Window Movement
   map("n", "<C-h>", "<C-w>h", opts)
   map("n", "<C-j>", "<C-w>j", opts)
   map("n", "<C-k>", "<C-w>k", opts)
   map("n", "<C-l>", "<C-w>l", opts)

   -- Buffer Movements
   map("n", "<S-l>", ":BufNext<CR>", opts)
   map("n", "<S-h>", ":BufPrev<CR>", opts)

   -- Window Closing
   map("n", "<leader>cc", ":bdelete!<CR>", opts)
   map("n", "<leader>x", ":close<CR>", opts)

   -- Resizing Splits
   map("n", "<C-Up>", ":resize +2<CR>", opts)
   map("n", "<C-Down>", ":resize _2<CR>", opts)
   map("n", "<C-Left>", ":vertical resize +2<CR>", opts)
   map("n", "<C-Rigt>", ":vertical resize -2<CR>", opts)

   -- Move blocks of code
   map("v", "K", ":move '<-2<CR>gv-gv", opts)
   map("v", "J", ":move '>+1<CR>gv-gv", opts)

   -- Better Indent
   map("v", ">", ">gv", opts)
   map("v", "<", "<gv", opts)

   -- Escape Term mode
   map("t", "<Esc>", "<C-\\><C-n>")

   -- Neogen Annotations
   map("n", "<leader> ", ":lua require('neogen').generate()<CR>", opts)

   map("n", "<Tab>", "za", opts)
end

M.packer = function()
   map("n", "<leader>pi", ":PackerInstall<CR>", opts)
   map("n", "<leader>pr", ":PackerCompile<CR>", opts)
   map("n", "<leader>pc", ":PackerClean<CR>", opts)
   map("n", "<leader>pu", ":PackerUpdate<CR>", opts)
   map("n", "<leader>ps", ":PackerSync<CR>", opts)
end

M.telescope = function()
   map("n", "<leader>f", ":lua require('telescope.builtin').find_files()<CR>", opts)
   map(
      "n",
      "<leader>ff",
      ":lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{previewer = false})<CR>",
      opts
   )
   map(
      "n",
      "<leader>ft",
      ":lua require('telescope.builtin').treesitter(require('telescope.themes').get_dropdown())<CR>",
      opts
   )
   map(
      "n",
      "<leader>fg",
      ":lua require('telescope.builtin').git_files(require('telescope.themes').get_ivy())<CR>",
      opts
   )
   map(
      "n",
      "<leader>fr",
      ":lua require('telescope.builtin').oldfiles(require('telescope.themes').get_ivy{previewer = false})<CR>",
      opts
   )
   map(
      "n",
      "<leader>fw",
      ":lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown())<CR>",
      opts
   )
   -- Git stuff

   map(
      "n",
      "<leader>gs",
      ":lua require('telescope.builtin').git_stash(require('telescope.themes').get_dropdown())<CR>",
      opts
   )
   map("n", "<leader>gt", ":lua require('telescope.builtin').git_status()<CR>", opts)
   map(
      "n",
      "<leader>gb",
      ":lua require('telescope.builtin').git_branches(require('telescope.themes').get_dropdown())<CR>",
      opts
   )
end

M.nvimtree = function()
   map("n", "<leader>e", ":NvimTreeToggle <CR>", opts)
   map("n", "<leader>er", ":NvimTreeRefresh <CR>", opts)
   map("n", "<leader>ef", ":NvimTreeFocus <CR>", opts)
end

M.term = function()
   map("n", "<C-t>", ":lua require('Fterm').toggle()<CR>", opts)
end

M.neogit = function()
   map("n", "<leader>gg", ":Neogit <CR>", opts)
end

return M
