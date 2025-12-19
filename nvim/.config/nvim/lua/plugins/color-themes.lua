return {
  { "rebelot/kanagawa.nvim" },
  { "catppuccin/nvim", name = "catppuccin", lazy = false },
  { "rose-pine/neovim", name = "rose-pine" },
  { "sainnhe/everforest" },
  { "bluz71/vim-nightfly-colors" },
  { "romainl/Apprentice" },

  -- Configure LazyVim to load colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine-moon",
    },
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        require("lazyvim").setup({ colorscheme = "rose-pine-moon" })
      end,
      set_light_mode = function()
        require("lazyvim").setup({ colorscheme = "rose-pine-dawn" })
      end,
    },
  },
}
