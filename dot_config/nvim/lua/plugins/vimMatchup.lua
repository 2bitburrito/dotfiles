return {
  "andymass/vim-matchup",
  init = function()
    -- modify your configuration vars here
    vim.g.matchup_treesitter_stopline = 500
    require("match-up").setup({
      treesitter = {
        stopline = 500,
      },
    })
  end,
}
