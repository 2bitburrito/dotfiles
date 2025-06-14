vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>ay", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

return {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "MeanderingProgrammer/render-markdown.nvim",
    "ravitemer/codecompanion-history.nvim",
  },
  extensions = {
    history = {
      enabled = true,
      opts = {
        -- Keymap to open history from chat buffer (default: gh)
        keymap = "<leader>ah",
        -- Keymap to save the current chat manually (when auto_save is disabled)
        save_chat_keymap = "sc",
        -- Save all chats by default (disable to save only manually using 'sc')
        auto_save = true,
        -- Number of days after which chats are automatically deleted (0 to disable)
        expiration_days = 0,
        -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
        picker = "snacks",
        ---Automatically generate titles for new chats
        auto_generate_title = true,
        title_generation_opts = {
          ---Adapter for generating titles (defaults to active chat's adapter)
          adapter = nil, -- e.g "copilot"
          ---Model for generating titles (defaults to active chat's model)
          model = nil, -- e.g "gpt-4o"
        },
        ---On exiting and entering neovim, loads the last chat on opening chat
        continue_last_chat = false,
        ---When chat is cleared with `gx` delete the chat from history
        delete_on_clearing_chat = false,
        ---Directory path to save the chats
        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        ---Enable detailed logging for history extension
        enable_logging = false,
      },
    },
  },
}
