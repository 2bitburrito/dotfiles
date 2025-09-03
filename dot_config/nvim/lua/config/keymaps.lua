-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Move up and down while centering
map({ "n", "x" }, "<C-d>", "<C-d>zz", { noremap = true })
map({ "n", "x" }, "<C-u>", "<C-u>zz", { noremap = true })
