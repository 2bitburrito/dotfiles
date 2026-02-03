-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-------------------
-- CUSTOM MACROS --
-------------------
local esc = vim.api.nvim_replace_termcodes("<esc>", true, true, true)
local rtn = vim.api.nvim_replace_termcodes("<cr>", true, true, true)

-- === Javascript Debug Print ===
--
-- Create the autocmd group
local js_log_group = vim.api.nvim_create_augroup("JSLogMacro", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = js_log_group,
  pattern = { "javascript", "typescript", "tsx", "jsx", "react" }, -- ts, js, react only
  callback = function()
    vim.fn.setreg("l", "yiWoconsole.log(" .. esc .. 'pF(a"",' .. esc .. "hi" .. esc .. "pa:" .. esc)
  end,
})

-- === Markdown Macros ===
local markdown_group = vim.api.nvim_create_augroup("TodoNewDayMacro", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = markdown_group,
  pattern = { "markdown", "md" },
  callback = function()
    vim.fn.setreg("d", "i---" .. rtn .. "### " .. os.date("%Y-%m-%d") .. rtn .. "- ")
    vim.fn.setreg("c", "4jfTvt-;yggPA #comment ()" .. esc .. "i")
  end,
})
