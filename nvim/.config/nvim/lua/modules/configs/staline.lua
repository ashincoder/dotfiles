-- Get file icon
local function get_file_icon(f_name, ext)
   local status, icons = pcall(require, "nvim-web-devicons")
   if not status then
      return require("tables").file_icons[ext]
   end
   return icons.get_icon(f_name, ext, { default = true })
end

-- Lsp status indicator
local function lsp_status()
   if next(vim.lsp.buf_get_clients()) ~= nil then
      return " "
   else
      return ""
   end
end

local function file_name()
   local dir = vim.fn.expand "%f"
   local f_icon = get_file_icon(vim.fn.expand "%:t", vim.fn.expand "%:e")
   return f_icon .. " " .. dir
end

local present1, staline = pcall(require, "staline")
local present2, stabline = pcall(require, "stabline")
if not present1 and present2 then
   return
end

-- Tabline
stabline.setup()

-- Statusline
staline.setup {
   defaults = {
      left_separator = "",
      right_separator = "",
      line_column = "[%l/%L] 並%p%% ", -- `:h stl` to see all flags.
      fg = "#000000", -- Foreground text color.
      font_active = "bold",
      full_path = false,
      true_colors = true, -- true lsp colors.
   },
   mode_colors = {
      n = "#2bbb4f",
      i = "#6A819D",
      c = "#FD5E3D",
      v = "#4799eb",
   },
   mode_icons = {
      n = " ",
      i = " ",
      c = " ",
      v = " ",
   },
   sections = {
      left = { "- ", "-mode", "left_sep_double", " ", "branch" },
      mid = { file_name },
      right = { lsp_status, " ", "right_sep_double", "-line_column" },
   },
}
