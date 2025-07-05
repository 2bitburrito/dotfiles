return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      version = "1.32.0",
      -- "jose-elias-alvarez/typescript.nvim",
      -- init = function()
      --   require("lazyvim.util").lsp.on_attach(function(_, buffer)
      --   -- stylua: ignore
      --   vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
      --     vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
      --   end)
      -- end,
    },
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        tsserver = false,
        html = {},
        gopls = {},
      },
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
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
        tsserver_plugins = {},
        complete_function_calls = true,
        include_completions_with_insert_text = true,
      },
    },
    config = function(_, opts)
      require("typescript-tools").setup(opts)
    end,
  },
}
