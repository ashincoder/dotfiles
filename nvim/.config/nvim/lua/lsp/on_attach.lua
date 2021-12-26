local attach = {}

function attach.document_highlight(client)
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

function attach.lsp_keybindings(bufnr)
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
   set_key("n", "gr", "<cmd>:lua vim.lsp.buf.references()<CR>", opts)
   set_key("n", "gd", "<cmd>:lua vim.lsp.buf.definition()<CR>", opts) -- Definition
   set_key("n", "gl", "<cmd>:lua vim.diagnostic.open_float()<CR>", opts)
end

return attach
