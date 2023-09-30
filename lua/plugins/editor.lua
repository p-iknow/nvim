return {
	{
		-- mini.nvim: Library of 30+ independent Lua modules improving overall Neovim (version 0.7 and higher) experience with minimal effort. They all share same configuration approaches and general design principles.
		-- https://github.com/echasnovski/mini.nvim
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require('mini.ai').setup()
			require('mini.comment').setup()
			require('mini.pairs').setup()
			require('mini.surround').setup()
		end,
		vscode = true,
	},
	-- https://github.com/tpope/vim-unimpaired
	{ "tpope/vim-unimpaired",         vscode = true },
	{ "max397574/better-escape.nvim", opts = { mapping = { "jk", "kj" } }, vscode = true },
}
