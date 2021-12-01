local present, terminal = pcall(require, "toggleterm")
if not present then
   return
end

terminal.setup {
   size = 20,
   open_mapping = [[<c-t>]],
   hide_numbers = true, -- hide the number column in toggleterm buffers
   shade_filetypes = {},
   shade_terminals = true,
   shading_factor = "<number>", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
   start_in_insert = true,
   insert_mappings = true, -- whether or not the open mapping applies in insert mode
   persist_size = true,
   direction = "float",
   close_on_exit = true, -- close the terminal window when the process exits
   shell = vim.o.shell, -- change the default shell
   -- This field is only relevant if direction is set to 'float'
   float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = "curved",
      winblend = 3,
      highlights = {
         border = "Normal",
         background = "Normal",
      },
   },
}
