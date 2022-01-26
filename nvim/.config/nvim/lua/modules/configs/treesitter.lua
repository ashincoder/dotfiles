local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
   return
end

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg_meta = {
   install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
      files = { "src/parser.c" },
      branch = "main",
   },
}
parser_configs.norg_table = {
   install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
      files = { "src/parser.c" },
      branch = "main",
   },
}

ts_config.setup {
   ensure_installed = {
      "c",
      "lua",
      "bash",
      "css",
      "html",
      "javascript",
      "python",
      "comment",
      "yaml",
      "markdown",
      "norg",
      "norg_meta",
      "norg_table",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = { "org", "norg" },
   },
   autopairs = { enable = true },
   indent = { enable = true },
   context_commentstring = { enable = true },
}
