local lualine = require "lualine"

-- [[ GRUVBOX ]
-- stylua: ignore
local colors = {
  black        = '#282828',
  white        = '#ebdbb2',
  red          = '#fb4934',
  green        = '#b8bb26',
  blue         = '#83a598',
  yellow       = '#fe8019',
  gray         = '#a89984',
  darkgray     = '#3c3836',
  lightgray    = '#504945',
  inactivegray = '#7c6f64',
}

local conditions = {
   buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand "%:t") ~= 1
   end,
   hide_in_width = function()
      return vim.fn.winwidth(0) > 80
   end,
   check_git_workspace = function()
      local filepath = vim.fn.expand "%:p:h"
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
   end,
}

local gruvbox_express = {

   options = {
      -- disable sections and component separators
      icons_enabled = true,
      component_separators = "",
      section_separators = "",
      disabled_filetypes = { "alpha", "dashboard" },
      theme = {
         -- we are going to use lualine_c an lualine_x as left and
         -- right section. both are highlighted by c theme .  so we
         -- are just setting default looks o statusline
         normal = { c = { fg = colors.white, bg = colors.darkgray } },
         inactive = { c = { fg = colors.gray, bg = colors.darkgray } },
      },
   },
   sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      -- these will be filled later
      lualine_c = {},
      lualine_x = {},
   },
   inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_v = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
   },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
   table.insert(gruvbox_express.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
   table.insert(gruvbox_express.sections.lualine_x, component)
end

ins_left {
   function()
      return ""
   end,
   padding = { left = 0.5, right = 1 }, -- We don't need space before this
}

ins_left {
   "mode",
   color = { gui = "bold" },
   padding = { left = 0.5, right = 1 },
}

ins_left {
   "branch",
   icon = "",
   color = { fg = colors.blue, gui = "bold" },
}

ins_left {
   "filetype",
   colored = true,
}

ins_left {
   "diagnostics",
   sources = { "nvim_diagnostic" },
   symbols = { error = " ", warn = " ", info = " " },
   diagnostics_color = {
      color_error = { fg = colors.red },
      color_warn = { fg = colors.yellow },
      color_info = { fg = colors.gray },
   },
}

ins_left {
   function()
      return "%="
   end,
}

ins_left {
   "filename",
   file_status = true,
   path = 0,
   cond = conditions.buffer_not_empty,
   color = { fg = colors.magenta, gui = "bold" },
}

ins_right {
   -- Lsp server name .
   function()
      local msg = "nil"
      local clients = vim.lsp.buf_get_clients()
      if next(clients) == nil then
         return msg
      end

      local client_names = ""
      for _, client in pairs(clients) do
         if string.len(client_names) < 1 then
            client_names = client_names .. client.name
         else
            client_names = client_names .. ", " .. client.name
         end
      end
      return string.len(client_names) > 0 and client_names or msg
   end,
   color = { fg = "#ffffff", gui = "bold" },
}

ins_right { "location" }

ins_right {
   "progress",
   icon = " ",
   color = { fg = colors.fg, gui = "bold" },
}

ins_right {
   function()
      return "▊"
   end,
   color = { fg = colors.blue },
   padding = { left = 1 },
}

lualine.setup(gruvbox_express)
