require('catppuccin').setup({
	flavour = "mocha",
  transparent_background = true,
  integrations = {
    nvimtree = true,
  },
})

vim.cmd.colorscheme "catppuccin"
