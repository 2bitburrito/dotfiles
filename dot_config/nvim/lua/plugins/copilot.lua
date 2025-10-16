-- ensure copilot completion starts disabled:
require("copilot.command").disable()
return {
  "zbirenbaum/copilot.lua",
  enabled = true,
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
