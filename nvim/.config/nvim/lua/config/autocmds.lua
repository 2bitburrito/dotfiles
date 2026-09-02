-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)

-- Opaque backgrounds:
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    vim.cmd("hi NormalFloat guibg=NONE ctermbg=NONE") -- optional, floating windows
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "OilEnter",
  callback = vim.schedule_wrap(function(args)
    local oil = require("oil")
    if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
      oil.open_preview()
    end
  end),
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function(event)
    vim.b[event.buf].autoformat = false
    vim.bo[event.buf].expandtab = true
    vim.bo[event.buf].shiftwidth = 4
    vim.bo[event.buf].softtabstop = 4
    vim.bo[event.buf].tabstop = 4
    vim.bo[event.buf].cindent = true
    vim.bo[event.buf].cinoptions = "(0"
  end,
})

-- Autoformat setting
local set_autoformat = function(pattern, bool_val)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = pattern,
    callback = function()
      vim.b.autoformat = bool_val
    end,
  })
end

set_autoformat({
  "yaml",
  -- "robot"
}, false)
