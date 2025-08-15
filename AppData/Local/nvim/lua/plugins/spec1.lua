local function GetYesOrNo(booleanValue)
    if (booleanValue) then
        return "yes"
    end
    return "no"
end

local function GetOnOrOff(booleanValue)
    if (booleanValue) then
        return "on"
    end
    return "off"
end

local function GetAsNonNilString(stringValue)
    if stringValue ~= nil then
        return stringValue
    end
    return ""
end

local function WrapErrorAsString(function_to_call, arg1, arg2, ...)
    local status, result_or_error = pcall(function_to_call, arg1, arg2, ...)
    if not status then
        return "Error: " .. result_or_error
    else
        return result_or_error
    end
end

local function LuaLineComponent_SpcInfo()
    --local lbr = "";
    --local rbr = "";
    local lbr = "";
    local rbr = "";
    local msg = string.format(lbr .. " ts: %d sts: %d sw: %d et: %s " .. rbr, vim.o.tabstop, vim.o.softtabstop, vim.o.shiftwidth, GetOnOrOff(vim.o.expandtab))
    return msg
end

local function WrappedLuaLineComponent_SpcInfo()
    return WrapErrorAsString(LuaLineComponent_SpcInfo)
end

local function WaviloTelescopeColorSchemeCR(prompt_bufnr)
    local selected_colorscheme
    local selection = require('telescope.actions.state').get_selected_entry()
    --print(vim.inspect(selection))
    if (selection ~= nil) then
        selected_colorscheme = selection[1] -- name of selected item
        --print("Selected: " .. selected_colorscheme)
    end
    local ret = require('telescope.actions').select_default(prompt_bufnr)
    vim.g.colors_name = selected_colorscheme
    return ret
end

local function WaviloLoadConfig()
    local file_path = vim.fn.stdpath('data') .. "/colormanager.json"
    if (vim.uv.fs_stat(file_path)) then
        local file = io.open(file_path, "r")
        local file_contents = file:read("*a")
        file:close()
        local config = vim.json.decode(file_contents)
        if (config.colorscheme ~= nil) and (config.colorscheme ~= "") then
            vim.cmd("colorscheme " .. config.colorscheme)
            vim.g.colors_name = config.colorscheme
        end
    end
end

local function WaviloSaveConfig()
    local config = {
        colorscheme = GetAsNonNilString(vim.g.colors_name),
    }
    local file_contents = vim.json.encode(config)
    --print(file_contents)
    local file_path = vim.fn.stdpath('data') .. "/colormanager.json"
    local file = io.open(file_path, "w")
    file:write(file_contents)
    file:close()
end

return {
    -- Wavilo
    {
        "wavilo.nvim",
        dir = vim.fn.stdpath('config') .. "/lua/wavilo.nvim",
        config = function()
            vim.api.nvim_create_user_command("WaviloLoadConfig", WaviloLoadConfig, { nargs = "*" })
            vim.api.nvim_create_user_command("WaviloSaveConfig", WaviloSaveConfig, { nargs = "*" })
            WaviloLoadConfig()
        end
    },

    -- TreeSitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {},
    },
  
    -- LuaLine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            icons_enabled = false,
            --theme = "gruvbox",
            theme = "auto",
            --component_separators = { left = '', right = ''},
            --component_separators = { left = '', right = ''},
            tabline = {
                 lualine_a = {
                     {'buffers', icons_enabled = false}
                 },
                 --lualine_b = {'branch'},
                 --lualine_c = {'filename'},
                 lualine_x = {},
                 lualine_y = {},
                 lualine_z = {'g:colors_name'},
                 --lualine_z = {'tabs'}
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {
                    {
                        'encoding',
                        separator = {left = '', right = ''},
                    },
                    {
                        WrappedLuaLineComponent_SpcInfo,
                        separator = {left = '', right = ''},
                    },
                },
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
        },
    },
  
    -- Icons
    { "nvim-tree/nvim-web-devicons", opts = {} },


    -- lsp_config
    {
        'neovim/nvim-lspconfig',
        config = function() 
            local nvim_lsp = require('lspconfig')

            nvim_lsp.denols.setup {
                on_attach = on_attach,
                root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
                settings = {
                    deno = {
                        enable = true,
                        suggest = {
                            imports = {
                                hosts = {
                                    ['https://deno.land'] = false,
                                },
                            },
                        },
                    },
                },
            }

            nvim_lsp.ts_ls.setup {
                on_attach = on_attach,
                root_dir = nvim_lsp.util.root_pattern("package.json"),
                single_file_support = false
            }
        end
    },
  
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            defaults = {
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                    },
                    vertical = {
                        prompt_position = "top",
                    },
                },
            },
            pickers = {
                colorscheme = {
                    enable_preview = true,
                    mappings = {
                        i = {
                            ["<cr>"] = WaviloTelescopeColorSchemeCR,
                        },
                        n = {
                            ["<cr>"] = WaviloTelescopeColorSchemeCR,
                        }
                    }
                }
            },
        }
    },
    
    -- Which-Key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
              "<leader>?",
              function()
                require("which-key").show({ global = false })
              end,
              desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
  
    -- Delimiter highlighting
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function ()
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = 'rainbow-delimiters.strategy.global',
                    vim = 'rainbow-delimiters.strategy.local',
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                priority = {
                    [''] = 110,
                    lua = 210,
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end,
    },
  
    -- Color picker
    {
        "uga-rosa/ccc.nvim",
        opts = {
            highlighter = {
                auto_enable = true,
                lsp = true,
            },
        }
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
    },
  
    -- Guess-Indent
    {
        "nmac427/guess-indent.nvim",
        opts = {
            auto_cmd = true,  -- Set to false to disable automatic execution
            override_editorconfig = false, -- Set to true to override settings set by .editorconfig
            filetype_exclude = {  -- A list of filetypes for which the auto command gets disabled
                "netrw",
                "tutor",
          },
          buftype_exclude = {  -- A list of buffer types for which the auto command gets disabled
            "help",
            "nofile",
            "terminal",
            "prompt",
          },
          on_tab_options = { -- A table of vim options when tabs are detected 
            ["expandtab"] = false,
            ["tabstop"] = 4, -- If the option value is 'detected', The value is set to the automatically detected indent size.
            ["softtabstop"] = 4,
            ["shiftwidth"] = 4,
          },
          on_space_options = { -- A table of vim options when spaces are detected 
            ["expandtab"] = true,
            ["tabstop"] = "detected", -- If the option value is 'detected', The value is set to the automatically detected indent size.
            ["softtabstop"] = "detected",
            ["shiftwidth"] = "detected",
          },
        }
    },

    -- Neo-Tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false, -- neo-tree will lazily load itself
    },

    -- Matching word highlight
    {
        "RRethy/vim-illuminate"
    },
  
  -- Show whitespace
  {
    'mcauley-penney/visual-whitespace.nvim',
    config = true,
    event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
    opts = {
          enabled = true,
          highlight = { link = "Visual", default = true },
          match_types = {
            space = true,
            tab = true,
            nbsp = true,
            lead = false,
            trail = false,
          },
          list_chars = {
            space = "·",
            tab = "↦",
            nbsp = "␣",
            lead = "‹",
            trail = "›",
          },
          fileformat_chars = {
            unix = "↲",
            mac = "←",
            dos = "↙",
          },
          ignore = { filetypes = {}, buftypes = {} },
    },
  },
  
}
