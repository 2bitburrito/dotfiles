return {
  "apple/pkl-neovim",
  lazy = true,
  ft = "pkl",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
      build = function(_)
        vim.cmd("TSUpdate")
      end,
    },
    "L3MON4D3/LuaSnip",
  },
  build = function()
    require("pkl-neovim").init()

    -- Set up syntax highlighting.
    vim.cmd("TSInstall pkl")
  end,
  config = function()
    -- Set up snippets.
    require("luasnip.loaders.from_snipmate").lazy_load()

    -- Configure pkl-lsp (fall back to Homebrew paths on macOS)
    local pkl_lsp = vim.fn.exepath("pkl-lsp")
    local pkl_cli = vim.fn.exepath("pkl")
    vim.g.pkl_neovim = {
      start_command = { pkl_lsp ~= "" and pkl_lsp or "/opt/homebrew/bin/pkl-lsp" },
      pkl_cli_path = pkl_cli ~= "" and pkl_cli or "/opt/homebrew/bin/pkl",
    }
  end,
}
