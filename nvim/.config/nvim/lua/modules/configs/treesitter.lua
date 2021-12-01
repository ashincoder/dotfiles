local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
   return
end

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.org = {
   install_info = {
      url = "https://github.com/milisims/tree-sitter-org",
      revision = "main",
      files = { "src/parser.c", "src/scanner.cc" },
   },
   filetype = "org",
}
parser_configs.norg = {
   install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg",
      files = { "src/parser.c", "src/scanner.cc" },
      branch = "main",
   },
   filetype = "norg",
}

ts_config.setup {
   ensure_installed = {
      "lua",
      "bash",
      "css",
      "html",
      "javascript",
      "python",
      "c",
      "nix",
      "comment",
      "yaml",
      "org",
      "norg",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false and { "org", "norg" },
   },
   autopairs = { enable = true },
   indent = { enable = true },
   context_commentstring = { enable = true },
}
