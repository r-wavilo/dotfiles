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

--[[
-- Create a user command that calls your function
vim.api.nvim_create_user_command("MyLuaCommand", function(args)
  myplugin.my_exposed_function(args)
end, { nargs = "*" }) -- nargs='*' allows passing arguments to the command
--]]

vim.api.nvim_create_user_command("WaviloSwitchToSpacesMode", WaviloSwitchToSpacesMode, { nargs = "*" })
vim.api.nvim_create_user_command("WaviloSwitchToTabsMode", WaviloSwitchToTabsMode, { nargs = "*" })