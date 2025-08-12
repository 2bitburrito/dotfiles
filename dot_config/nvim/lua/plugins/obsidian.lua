return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "coding",
        path = "/Users/hugh/Library/Mobile Documents/iCloud~md~obsidian/Documents/Coding Vault",
      },
    },
  },
}
