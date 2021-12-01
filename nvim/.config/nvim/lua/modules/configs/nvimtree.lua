local present, tree = pcall(require, "nvim-tree")
if not present then
   return
end

tree.setup {
   -- closes neovim automatically when the tree is the last **WINDOW** in the view
   disable_netrw = true,
   hijack_netrw = true,
   auto_close = true,
   ignore_ft_on_setup = { "alpha" },
   update_cwd = true,
}
