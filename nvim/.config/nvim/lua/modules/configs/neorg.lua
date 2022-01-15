local ok, neorg = pcall(require, "neorg")
if not ok then
   return
end

neorg.setup {
   -- Tell Neorg what modules to load
   load = {
      ["core.defaults"] = {},
      ["core.highlights"] = {},
      ["core.norg.esupports"] = {},
      ["core.norg.concealer"] = {},
      ["core.presenter"] = {
         config = {
            zen_mode = "zen-mode",
         },
      },
      ["core.integrations.telescope"] = {}, -- Enable the telescope module
      ["core.norg.dirman"] = {
         config = {
            workspaces = {
               my_workspace = "~/Neorg",
               gtd = "~/Neorg/gtd",
            },
         },
      },
      ["core.gtd.base"] = {
         config = {
            workspace = "gtd",
         },
      },
      ["core.norg.journal"] = {
         config = {
            journal_folder = "diary",
         },
      },
      ["core.integrations.treesitter"] = {
         config = {
            highlights = {
               Heading = {
                  ["1"] = {
                     Title = "+TSTitle",
                     Prefix = "+TSTitle",
                  },
               },
               Quote = {
                  ["1"] = {
                     [""] = "+Grey",
                     Content = "+Grey",
                  },
               },
            },
         },
      },
      ["core.keybinds"] = {
         config = {
            default_keybinds = true,
            neorg_leader = "<Leader>o",
         },
      },
   },
}

local neorg_callbacks = require "neorg.callbacks"

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
   -- Map all the below keybinds only when the "norg" mode is active
   keybinds.map_event_to_mode("norg", {
      n = { -- Bind keys in normal mode
         { "<C-s>", "core.integrations.telescope.find_linkable" },
      },

      i = { -- Bind in insert mode
         { "<C-l>", "core.integrations.telescope.insert_link" },
      },
   }, {
      silent = true,
      noremap = true,
   })
end)
