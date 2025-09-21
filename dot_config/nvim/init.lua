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

vim.api.nvim_create_autocmd("FileType", {
  group = js_log_group,
  pattern = { "javascript", "typescript", "tsx", "jsx", "react" }, -- ts, js, react only
  callback = function()
    vim.fn.setreg("l", "yoconsole.log(" .. esc .. 'pF(a"",' .. esc .. "hi" .. esc .. "")
  end,
})
