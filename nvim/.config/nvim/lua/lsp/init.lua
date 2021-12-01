local handlers = require "lsp.handlers"
local null_ls = require "lsp.null_ls"
local sumneko = require "lsp.sumneko"
-- Pcalling lspconfig
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
   return
end

local signs = { Error = "", Information = "", Hint = "", Warning = "" }

for severity, icon in pairs(signs) do
   local highlight = "LspDiagnosticsSign" .. severity
   vim.fn.sign_define(highlight, {
      text = icon,
      texthl = highlight,
      numhl = highlight,
   })
end

local function document_highlight(client)
   -- Set autocommands conditional on server_capabilities
   if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec(
         [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#353d46
      hi LspReferenceText cterm=bold ctermbg=red guibg=#353d46
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#353d46
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
         false
      )
   end
end

local function lsp_keybindings(bufnr)
   local function set_key(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
   end
   -- Mappings.
   local opts = { noremap = true, silent = true }

   -- See `:help vim.lsp.*` for documentation on any of the below functions
   -- Custom
   set_key("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
   set_key("n", "<leader>cr", "<cmd>:Lspsaga rename<CR>", opts)
   set_key("n", "K", "<cmd>:Lspsaga hover_doc<CR>", opts) -- Hover Doc
   set_key("n", "[d", "<cmd>:Lspsaga diagnostic_jump_next<CR>zz", opts)
   set_key("n", "]d", "<cmd>:Lspsaga diagnostic_jump_prev<CR>zz", opts)
   set_key("n", "ca", "<cmd>:Lspsaga code_action<CR>", opts)
   set_key("n", "gI", "<cmd>:Lspsaga implement<CR>", opts)
   set_key("n", "gr", "<cmd>:Lspsaga lsp_finder<CR>", opts)
   set_key("n", "gd", "<cmd>:Lspsaga preview_definition<CR>", opts) -- Definition
   set_key("n", "gD", "<cmd>:lua vim.lsp.buf.definition()<CR>", opts) -- Definition
   set_key("n", "ge", "<cmd>:Lspsaga show_line_diagnostics<CR>", opts)
   set_key("n", "gp", "<cmd>lua require('lsp.peek').Peek('definition')<CR>", opts)
end

local on_attach = function(client, bufnr)
   handlers.setup() -- Setting Handlers
   lsp_keybindings(bufnr) -- Lsp buffer lsp_keybindings
   document_highlight(client) -- document highlighting
   require("lsp_signature").on_attach(client) -- Lsp Signature
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Settings up servers which doesn't require much configuration
local servers = {
   "bashls",
   "clangd",
   "pyright",
   "rnix",
   "vimls",
   "yamlls",
}
-- Starting up servers using a for loop
for _, server in ipairs(servers) do
   lspconfig[server].setup {
      on_attach = on_attach,
      capabilities = capabilities,
   }
end

-- Setting up Servers
sumneko.setup(on_attach, capabilities)
null_ls.setup(on_attach, capabilities)
