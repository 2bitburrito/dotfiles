return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      version = "1.32.0",
    },
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        tsserver = false,
        markdownlint = false,
        ts_ls = false,
        vtsls = {
          enabled = false,
          settings = {},
        },
        html = {},
        gopls = {},
        postgres_lsp = {},
      },
      setup = {},
      settings = {
        autoformat = true,
        format_on_save = true,
        format_on_insert_leave = false,
        format_on_insert_enter = false,
        format_on_file_open = false,
        experimental_flat_config = true,
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        complete_function_calls = true,
        include_completions_with_insert_text = true,
      },
    },
    config = function(_, opts)
      require("typescript-tools").setup(opts)
    end,
  },
}
