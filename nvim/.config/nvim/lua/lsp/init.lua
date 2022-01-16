local handlers = require "lsp.handlers"
local attach = require "lsp.on_attach"
local lsp_installer = require "nvim-lsp-installer"

-- stylua: ignore start
local on_attach = function(client, bufnr)
   handlers.setup()                             -- Setting Handlers
   require("core.mappings").telescope_lsp()     -- Telescope lsp keybinds
   attach.lsp_keybindings(bufnr)                -- Lsp buffer lsp_keybindings
   attach.document_highlight(client)            -- document highlighting
   require("lsp_signature").on_attach(client)   -- Lsp Signature
end
-- stylua: ignore end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Setting up servers installed
lsp_installer.on_server_ready(function(server)
   -- Custom on_attach and capabilities
   local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
   }

   -- Custom server options for sumneko_lua
   if server.name == "sumneko_lua" then
      local sumneko_opts = require "lsp.servers.sumneko"
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
   end

   if server.name == "texlab" then
      local texlab_opts = require "lsp.servers.texlab"
      opts = vim.tbl_deep_extend("force", texlab_opts, opts)
   end

   server:setup(opts)
end)
