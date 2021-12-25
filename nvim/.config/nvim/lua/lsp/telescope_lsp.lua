local M = {}
local themes = require "telescope.themes"
local builtin = require "telescope.builtin"

-- show code actions in a fancy floating window
function M.code_actions()
   local opts = {
      winblend = 15,
      layout_config = {
         prompt_position = "top",
         width = 80,
         height = 12,
      },
      borderchars = {
         prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
         results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
         preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
      border = {},
      previewer = false,
      shorten_path = false,
   }
   builtin.lsp_code_actions(themes.get_cursor(opts))
end

function M.lsp_implementations()
   local opts = {
      layout_strategy = "vertical",
      layout_config = {
         prompt_position = "top",
      },
      sorting_strategy = "ascending",
      ignore_filename = false,
   }
   builtin.lsp_implementations(opts)
end

function M.lsp_references()
   local opts = {
      layout_strategy = "vertical",
      layout_config = {
         prompt_position = "top",
      },
      sorting_strategy = "ascending",
      ignore_filename = false,
   }
   builtin.lsp_references(opts)
end

return M
