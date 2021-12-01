local present, gitsigns = pcall(require, "gitsigns")
if not present then
   return
end

gitsigns.setup {
   numhl = false,
   sign_priority = 5,
   signs = {
      add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
   },
   keymaps = {
      -- Default keymap options
      noremap = true,

      ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
      ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

      ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
      ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
      ["n <leader>hS"] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
      ["n <leader>hU"] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

      -- Text objects
      ["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
      ["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
   },
   status_formatter = nil, -- Use default
   watch_gitdir = {
      interval = 100,
   },
}
