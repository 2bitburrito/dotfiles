-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("scrollEOF").setup()

-- start copilot disabled:
require("copilot.command").disable()

-------------------
-- CUSTOM MACROS --
-------------------
local esc = vim.api.nvim_replace_termcodes("<esc>", true, true, true)

-- Create the autocmd group
local js_log_group = vim.api.nvim_create_augroup("JSLogMacro", { clear = true })

-- Javascript Debug Print
vim.api.nvim_create_autocmd("FileType", {
  group = js_log_group,
  pattern = { "javascript", "typescript", "tsx", "jsx", "react" }, -- ts, js, react only
  callback = function()
    vim.fn.setreg("l", "yoconsole.log(" .. esc .. 'pF(a"",' .. esc .. "hi" .. esc .. "")
  end,
})

-------------------
-- CUSTOM MACROS --
-------------------

vim.api.nvim_create_autocmd("User", {
  pattern = "OilEnter",
  callback = vim.schedule_wrap(function(args)
    local oil = require("oil")
    if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
      oil.open_preview()
    end
  end),
})
