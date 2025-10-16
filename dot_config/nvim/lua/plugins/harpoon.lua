return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2", -- Use the harpoon2 branch
  lazy = false, -- Load the plugin when Neovim starts
  requires = {
    "nvim-lua/plenary.nvim", -- Harpoon requires plenary.nvim
  },
  config = function()
    require("harpoon"):setup({
      settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    }) -- Setup Harpoon
  end,
  keys = {
    {
      "L",
      function()
        local harpoon = require("harpoon")
        harpoon:list():next()
      end,
      desc = "Harpoon Next",
    },
    {
      "H",
      function()
        local harpoon = require("harpoon")
        harpoon:list():prev()
      end,
      desc = "Harpoon Prev",
    },
  },
}
