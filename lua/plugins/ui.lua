return {
	-- for vscode
	{ "winston0410/cmd-parser.nvim",      vscode = true },
	{ "winston0410/range-highlight.nvim", config = true, vscode = true },
	-- for nvim
	{
		"tummetott/reticle.nvim",
		config = true,
		init = function()
			vim.wo.cursorline = true
			vim.wo.cursorcolumn = false
		end,
	},
	{
		"folke/which-key.nvim",
		opts = {
			plugins = {
				registers = false,
			},
		},
	},
}
