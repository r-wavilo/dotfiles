
-- Note: this keybind doesn't work, possibly because Windows Console terminal doesn't send ctrl+shift+key
vim.keymap.set("n", "<C-S-s>", ":wa<cr>", { noremap=true })   

vim.keymap.set("n", "<leader>f.", ":Telescope fd<cr>", {desc="Find Files In Directory"})
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>", {desc="Find Buffers"})
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<cr>", {desc="Find Recent Files"})

local function WaviloSwitchToSpacesMode()
    vim.opt.tabstop = 4
    vim.o.softtabstop = 4
    vim.o.shiftwidth = 4
    vim.o.expandtab = true
end

local function WaviloSwitchToTabsMode()
    vim.opt.tabstop = 4
    vim.o.softtabstop = 4
    vim.o.shiftwidth = 4
    vim.o.expandtab = false
end

vim.api.nvim_create_user_command("WaviloSwitchToSpacesMode", WaviloSwitchToSpacesMode, { nargs = "*" })
vim.api.nvim_create_user_command("WaviloSwitchToTabsMode", WaviloSwitchToTabsMode, { nargs = "*" })

vim.keymap.set("n", "<leader>qL", function() require("named-sessions").select() end, {desc="Select session"})
vim.keymap.set("n", "<leader>ql", function() require("named-sessions").load({ last = true }) end, {desc="Load previous session"})
vim.keymap.set("n", "<leader>qd", function() require("named-sessions").stop() end, {desc="Stop saving current session"})
