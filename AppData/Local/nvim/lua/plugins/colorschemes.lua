return {
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
          -- vim.cmd([[colorscheme tokyonight]])
        end,
    },

    { "catppuccin/nvim", lazy=false, priority = 1000 },
    { "craftzdog/solarized-osaka.nvim", lazy=false, priority = 1000 },
    { "EdenEast/nightfox.nvim", lazy=false, priority = 1000 },
    { "marko-cerovac/material.nvim", lazy=false, priority = 1000 },
    { "Mofiqul/dracula.nvim", lazy=false, priority = 1000 },
    { "rebelot/kanagawa.nvim", lazy=false, priority = 1000 },
    { "rose-pine/neovim", lazy=false, priority = 1000, },
    { "sainnhe/everforest", lazy=false, priority = 1000, },
    { "sainnhe/gruvbox-material", lazy=false, priority = 1000, },
    { "sainnhe/sonokai", lazy=false, priority = 1000, },
    { "scottmckendry/cyberdream.nvim", lazy=false, priority = 1000, },
    { "thesimonho/kanagawa-paper.nvim", lazy=false, priority = 1000, },
}
