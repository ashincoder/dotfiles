local cmp = require "cmp"
local types = require "cmp.types"
local str = require "cmp.utils.str"

local luasnip = require "luasnip"
local lspkind = require "lspkind"
local neogen = require "neogen"

-- :h nvim_replace_termcodes()
local t = function(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local has_words_before = function()
   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

-- Do not jump to snippet if i'm outside of it
-- https://github.com/L3MON4D3/LuaSnip/issues/78
luasnip.config.setup {
   region_check_events = "CursorMoved",
   delete_check_events = "TextChanged",
}

cmp.setup {
   completion = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, scrollbar = "║" },
   window = {
      documentation = {
         border = "rounded",
         scrollbar = "║",
      },
      completion = {
         border = "rounded",
         scrollbar = "║",
      },
   },
   formatting = {
      fields = {
         cmp.ItemField.Abbr,
         cmp.ItemField.Kind,
         cmp.ItemField.Menu,
      },
      format = lspkind.cmp_format {
         before = function(entry, vim_item)
            -- Get the full snippet (and only keep first line)
            local word = entry:get_insert_text()
            if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
               word = vim.lsp.util.parse_snippet(word)
            end
            word = str.oneline(word)

            if
               entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
               and string.sub(vim_item.abbr, -1, -1) == "~"
            then
               word = word .. "~"
            end
            vim_item.abbr = word

            return vim_item
         end,
         menu = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            calc = "[Calc]",
            neorg = "[Neorg]",
            emoji = "[Emoji]",
            orgmode = "[Org]",
         },
      },
   },
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
   },
   mapping = {
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, {
         "i",
         "s",
         "c",
      }),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, {
         "i",
         "s",
         "c",
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif luasnip.expand_or_jumpable() then
            vim.fn.feedkeys(t "<Plug>luasnip-expand-or-jump", "")
         elseif has_words_before() then
            cmp.complete()
         elseif neogen.jumpable() then
            vim.fn.feedkeys(t "<cmd>lua require('neogen').jump_next()<CR>", "")
         else
            fallback()
         end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.jumpable(-1) then
            vim.fn.feedkeys(t "<Plug>luasnip-jump-prev", "")
         elseif neogen.jumpable(-1) then
            vim.fn.feedkeys(t "<cmd>lua require('neogen').jump_prev()<CR>", "")
         else
            fallback()
         end
      end, { "i", "s" }),
      ["<CR>"] = cmp.mapping {
         i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
         c = function(fallback)
            if cmp.visible() then
               cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
            else
               fallback()
            end
         end,
      },
   },
   experimental = {
      ghost_text = true,
      native_menu = false,
   },
   sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "neorg" },
      { name = "orgmode" },
      { name = "calc" },
      { name = "emoji" },
   },
}

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
   completion = { autocomplete = false },
   sources = {
      { name = "buffer" },
   },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
   completion = { autocomplete = true },
   sources = cmp.config.sources({
      { name = "path" },
   }, {
      { name = "cmdline" },
   }),
})
