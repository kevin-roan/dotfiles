local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then 
   print("Colorschem not found!")
   return 
end 

