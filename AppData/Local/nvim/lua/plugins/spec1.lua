return {
  
  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  
  
  -- LuaLine
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		theme = "gruvbox",
	},
  },
  
  -- Icons
  { "nvim-tree/nvim-web-devicons", opts = {} },
  
  -- Mason
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  
  -- Telescope
   {
      'nvim-telescope/telescope.nvim',
	  tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
  
  -- Themery
  {
    "zaldih/themery.nvim",
    lazy = false,
	priority = 900,
    config = function()
      
	  local available_colorschemes = vim.fn.getcompletion("", "color")
		local colorschemes = {}
		  for _, colorscheme in ipairs(available_colorschemes) do
			table.insert(colorschemes, colorscheme)
		end
	  
	  require("themery").setup({
        
		
		
		themes = colorschemes,
		livePreview = true,
      })
	  
    end
  },
  
  -- Conform
  {
    'stevearc/conform.nvim',
    --[[
	event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
	]]
    opts = {
	  formatters_by_ft = {
        -- lua = { "stylua" },
        -- python = { "isort", "black" },
        javascript = { "deno_fmt" },
		json = { "deno_fmt" },
      },
	},
  }
}