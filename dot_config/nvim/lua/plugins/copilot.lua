return {
  "zbirenbaum/copilot.lua",
  enabled = false,
  suggestion = {
    enabled = false,
  },
  keys = {
    {
      "<leader>ad",
      function()
        local is_disabled = require("copilot.client").is_disabled()
        if is_disabled then
          require("copilot.command").enable()
          vim.notify("Copilot " .. "Enabled")
        else
          require("copilot.command").disable()
          vim.notify("Copilot " .. "Disabled")
        end
      end,
      desc = "Toggle (Copilot)",
    },
  },
}
