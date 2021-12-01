local M = {}
local lsp = vim.lsp

function M.setup()
   lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
         prefix = "▎",
         spacing = 0,
      },
      signs = true,
      underline = true,
      update_in_insert = false, -- update diagnostics insert mode
   })
   lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
      border = "single",
   })
   lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
      border = "single",
   })
end

return M
