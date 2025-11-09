-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

-- Move up and down while centering
map({ "n", "x" }, "<C-d>", "<C-d>zz", { noremap = true })
map({ "n", "x" }, "<C-u>", "<C-u>zz", { noremap = true })

-- Fix commands to copy into "_" register rather than "+"
-- in a schedule so that it loads after all plugins
map("x", "p", '"_dP', { noremap = true, silent = true })

-- Find n Replace all from current word
map({ "n" }, "<leader>r", ":%s/<C-r><C-w>/", { noremap = true, desc = "Find and replace word" })

-- Open Oil:
map({ "n" }, "<leader>e", function()
  require("oil").open()
end, { noremap = true, desc = "Open Oil with preview" })

-- Try to fix stupid esc j/k behaviour...?
-- map({ "n", "i", "v" }, "<A-j>", "<Nop>", { silent = true })
-- map({ "n", "i", "v" }, "<A-k>", "<Nop>", { silent = true })
