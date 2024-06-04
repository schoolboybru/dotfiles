return {
	"catppuccin/nvim",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			integrations = {
				nvimtree = true,
			},
		})
		vim.cmd([[colorscheme catppuccin]])
	end,
}
