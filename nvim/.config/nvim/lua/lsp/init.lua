local handlers = require "lsp.handlers"
local null_ls = require "lsp.null_ls"
local lsp_installer = require "nvim-lsp-installer"

local signs = { Error = "", Info = "", Hint = "", Warn = "" }

for type, icon in pairs(signs) do
   local hl = "DiagnosticSign" .. type
   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
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
   set_key("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
   set_key("n", "<leader>cr", "<cmd>:lua vim.lsp.buf.rename()<CR>", opts)
   set_key("n", "K", "<cmd>:lua vim.lsp.buf.hover()<CR>", opts) -- Hover Doc
   set_key("n", "[d", "<cmd>:lua vim.lsp.diagnostic.goto_next<CR>zz", opts)
   set_key("n", "]d", "<cmd>:lua vim.lsp.diagnostic.goto_prev<CR>zz", opts)
   set_key("n", "ca", "<cmd>:lua vim.lsp.buf.code_action()<CR>", opts)
   set_key("n", "gI", "<cmd>:lua vim.lsp.buf.implementation()<CR>", opts)
   set_key("n", "gr", "<cmd>:lua vim.lsp.buf.references()<CR>", opts)
   set_key("n", "gd", "<cmd>:lua vim.lsp.buf.definition()<CR>", opts) -- Definition
   set_key("n", "ge", "<cmd>:lua vim.lsp.diagnostic.get_line_diagnostics()<CR>", opts)
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

lsp_installer.on_server_ready(function(server)
   -- Custom on_attach and capabilities
   local default_opts = {
      on_attach = on_attach,
      capabilities = capabilities,
   }
   -- Server Options
   local server_opts = {
      ["sumneko_lua"] = function()
         return require("lua-dev").setup {
            lspconfig = default_opts,
         }
      end,
   }
   server:setup((server_opts[server.name] and server_opts[server.name]() or default_opts))
end)

null_ls.setup(on_attach, capabilities)
