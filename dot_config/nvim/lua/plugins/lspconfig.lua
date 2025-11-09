return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
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
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          usePlaceholders = true,
          completeUnimported = true,
          gofumpt = false,
        },
        postgres_lsp = {},
      },
      setup = {
        gopls = function(_, opts)
          -- Format on save for Go files
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
      },
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
