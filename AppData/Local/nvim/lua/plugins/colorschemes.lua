return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "craftzdog/solarized-osaka.nvim", name = "solarized-osaka", priority = 1000 },
  { "EdenEast/nightfox.nvim", name = "nightfox", priority = 1000 },
  { "marko-cerovac/material.nvim", priority = 1000 },
  { "Mofiqul/dracula.nvim", name = "dracula", priority = 1000 },
  { "rebelot/kanagawa.nvim", name = "kanagawa", priority = 1000 },
  {	"rose-pine/neovim", name = "rose-pine", priority = 1000, },
  {	"sainnhe/everforest", name = "everforest", priority = 1000, },
  {	"sainnhe/gruvbox-material", name = "gruvbox-material", priority = 1000, },
  {	"sainnhe/sonokai", priority = 1000, },
  {	"scottmckendry/cyberdream.nvim", name = "cyberdream", priority = 1000, },
  {	"thesimonho/kanagawa-paper.nvim", priority = 1000, },
  
}
