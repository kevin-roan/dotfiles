local status, _ = pcall(vim.cmd, "colorscheme neosolarized")
if not status then
	print("Colorscheme not found!")
	return
end
