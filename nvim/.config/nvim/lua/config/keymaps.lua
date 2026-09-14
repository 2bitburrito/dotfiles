-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

-- Move up and down and fix to top
map({ "n", "x" }, "<C-d>", "<C-d>zt", { noremap = true })
map({ "n", "x" }, "<C-u>", "<C-u>zt", { noremap = true })

-- Fix commands to copy into "_" register rather than "+"
-- in a schedule so that it loads after all plugins
map("x", "p", '"_dP', { noremap = true, silent = true })

-- Find n Replace all from current word
map({ "n" }, "<leader>r", ":%s/<C-r><C-w>/", { noremap = true, desc = "Find and replace word" })

-- Find references to the Go function or method containing the cursor.
map("n", "gR", function()
  local node = vim.treesitter.get_node()
  while node and node:type() ~= "function_declaration" and node:type() ~= "method_declaration" do
    node = node:parent()
  end

  local name = node and node:field("name")[1]
  if not name then
    vim.notify("Cursor is not inside a function or method", vim.log.levels.WARN)
    return
  end

  local cursor = vim.api.nvim_win_get_cursor(0)
  local win = vim.api.nvim_get_current_win()
  local row, col = name:start()
  vim.api.nvim_win_set_cursor(win, { row + 1, col })

  local function restore_cursor()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_set_cursor(win, cursor)
    end
  end

  local ok, err = pcall(Snacks.picker.lsp_references, { on_close = restore_cursor })
  if not ok then
    restore_cursor()
    error(err)
  end
end, { desc = "References of enclosing function" })

-- Open Oil:
map({ "n" }, "<leader>e", function()
  require("oil").open_float()
end, { noremap = true, desc = "Open Oil floating with preview" })

-- Toggle AI Autocompletion:
map({ "n" }, "<leader>at", function()
  local sM = require("supermaven-nvim.api")
  sM.toggle()
  -- make a notification
  if sM.is_running() then
    vim.notify("SuperMaven toggled on")
  else
    vim.notify("SuperMaven toggled off")
  end
end, { noremap = true, desc = "Toggle SuperMaven" })

-- Try to fix stupid esc j/k behaviour...?
-- map({ "n", "i", "v" }, "<A-j>", "<Nop>", { silent = true })
-- map({ "n", "i", "v" }, "<A-k>", "<Nop>", { silent = true })
--

-- Remap cmd from ':' to enter
map("n", "<CR>", ":", { noremap = false })

-- When running ctrl-g copy the pwd to the sys-clipboard
vim.keymap.set({ "n", "x" }, "<C-g>", function()
  -- Capture the full status string and copy to clipboard
  vim.cmd('redir @+ | silent execute "normal! \\<C-g>" | redir END')
  -- Get the current full path and extract just the filename
  local full_path = vim.api.nvim_buf_get_name(0)
  local file_name = vim.fn.fnamemodify(full_path, ":t")
  -- Fallback for unnamed/new buffers
  if file_name == "" then
    file_name = "[No Name]"
  end
  print("Copied full path of: " .. file_name)
end, { noremap = true, desc = "Copy current file path to clipboard" })
