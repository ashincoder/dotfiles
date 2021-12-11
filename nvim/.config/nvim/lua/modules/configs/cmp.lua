local present1, cmp = pcall(require, "cmp")
local present2, luasnip = pcall(require, "luasnip")
if not present1 and present2 then
   return
end

local kind_icons = {
   Class = " ",
   Color = " ",
   Constant = "ﲀ ",
   Constructor = " ",
   Enum = "練",
   EnumMember = " ",
   Event = " ",
   Field = " ",
   File = "",
   Folder = " ",
   Function = " ",
   Interface = "ﰮ ",
   Keyword = " ",
   Method = " ",
   Module = " ",
   Operator = "",
   Property = " ",
   Reference = " ",
   Snippet = " ",
   Struct = " ",
   Text = " ",
   TypeParameter = " ",
   Unit = "塞",
   Value = " ",
   Variable = " ",
}
local function get_kind(kind_type)
   return kind_icons[kind_type]
end

local function t(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local function check_backspace()
   local col = vim.fn.col "." - 1
   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup {
   completion = {
      completeopt = "menu,menuone,preview,noinsert",
   },
   documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
   },
   mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      -- ["<ESC>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif luasnip.expand_or_jumpable() then
            vim.fn.feedkeys(t "<Plug>luasnip-expand-or-jump", "")
         elseif check_backspace() then
            vim.fn.feedkeys(t "<Tab>", "n")
         else
            fallback()
         end
      end, {
         "i",
         "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.jumpable(-1) then
            vim.fn.feedkeys(t "<Plug>luasnip-jump-prev", "")
         else
            fallback()
         end
      end, {
         "i",
         "s",
      }),
   },
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
   },
   experimental = {
      native_menu = true,
      ghost_text = false,
   },
   sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
      { name = "nvim_lua" },
      { name = "orgmode" },
      { name = "neorg" },
   },
   formatting = {
      format = function(entry, item)
         item.kind = string.format("%s", get_kind(item.kind))
         item.menu = ({
            nvim_lsp = "(LSP)",
            path = "(Path)",
            luasnip = "(Snippet)",
            buffer = "(Buffer)",
         })[entry.source.name]
         item.dup = ({
            buffer = 1,
            path = 1,
            nvim_lsp = 0,
         })[entry.source.name] or 0
         return item
      end,
   },
}
