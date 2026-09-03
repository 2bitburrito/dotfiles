return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  opts = {
    ensure_installed = { "go", "gomod", "gowork", "gosum", "robot" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
}
