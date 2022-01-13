local M = {}

M.colorizer = function()
   local present, colorizer = pcall(require, "colorizer")
   if not present then
      return
   end
   colorizer.setup({ "*" }, {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
   })
   vim.cmd "ColorizerReloadAllBuffers"
end

M.signature = function()
   local present, lspsignature = pcall(require, "lsp_signature")
   if not present then
      return
   end

   lspsignature.setup {
      bind = true,
      doc_lines = 2,
      floating_window = true,
      fix_pos = true,
      hint_enable = true,
      hint_prefix = " ",
      hint_scheme = "String",
      hi_parameter = "Search",
      max_height = 22,
      max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
         border = "single", -- double, single, shadow, none
      },
      zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
      padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
   }
end

M.luasnip = function()
   local present, luasnip = pcall(require, "luasnip")
   if not present then
      return
   end

   luasnip.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
   }

   require("luasnip/loaders/from_vscode").lazy_load()
end

M.autopairs = function()
   local remap = vim.api.nvim_set_keymap
   local npairs = require "nvim-autopairs"

   npairs.setup { map_bs = false, map_cr = false }

   vim.g.coq_settings = { keymap = { recommended = false } }

   -- these mappings are coq recommended mappings unrelated to nvim-autopairs
   remap("i", "<esc>", [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
   remap("i", "<c-c>", [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
   remap("i", "<tab>", [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
   remap("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

   -- skip it, if you use another global object
   _G.MUtils = {}

   MUtils.CR = function()
      if vim.fn.pumvisible() ~= 0 then
         if vim.fn.complete_info({ "selected" }).selected ~= -1 then
            return npairs.esc "<c-y>"
         else
            return npairs.esc "<c-e>" .. npairs.autopairs_cr()
         end
      else
         return npairs.autopairs_cr()
      end
   end
   remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

   MUtils.BS = function()
      if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
         return npairs.esc "<c-e>" .. npairs.autopairs_bs()
      else
         return npairs.autopairs_bs()
      end
   end
   remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })
end

return M
