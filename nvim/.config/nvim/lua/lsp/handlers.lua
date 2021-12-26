local handler = {}
local lsp = vim.lsp

function handler.borders()
   lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
      border = "single",
   })
   lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
      border = "single",
   })
end

function handler.icons()
   local signs = { Error = "", Info = "", Hint = "", Warn = "" }

   for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
   end
end

function handler.diagnostic_config()
   local config = {
      virtual_text = true,
      signs = {
         active = true,
      },
      underline = true,
      severity_sort = true,
      float = {
         focusable = false,
         style = "minimal",
         border = "rounded",
         source = "always",
         header = "",
         prefix = "",
      },
   }

   vim.diagnostic.config(config)
end

function handler.setup()
   handler.borders()
   handler.icons()
   handler.diagnostic_config()
end

return handler
