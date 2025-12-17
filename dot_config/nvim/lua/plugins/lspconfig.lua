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
          gofumpt = false,
          codelenses = {
            gc_details = false,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          analyses = {
            unusedparams = true,
            nilness = true,
          },
          staticcheck = true,
          usePlaceholders = true,
          completeUnimported = true,
        },
        postgres_lsp = {},
      },
      settings = {
        autoformat = false,
        format_on_save = false,
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
