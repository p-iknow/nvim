return {
	-- for vscode
	{ "winston0410/cmd-parser.nvim",      vscode = true },
	{ "winston0410/range-highlight.nvim", config = true, vscode = true },
	-- for nvim
	{
		"folke/noice.nvim",
		enabled = false,
	},
	{
		"tummetott/reticle.nvim",
		config = true,
		init = function()
			vim.wo.cursorline = true
			vim.wo.cursorcolumn = false
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		opts = {
			set_highlights = false,
			excluded_filetypes = {
				"prompt",
				"TelescopePrompt",
				"noice",
				"neo-tree",
				"dashboard",
				"alpha",
				"lazy",
				"mason",
				"DressingInput",
				"",
			},
			handlers = {
				gitsigns = true,
			},
		},
	},

	{
		"folke/which-key.nvim",
		opts = {
			plugins = {
				registers = false,
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		keys = function(_, keys)
			return {
				{ "<leader>un", desc = " Notifications" },
				{
					"<leader>und",
					function()
						require("notify").dismiss({})
					end,
					desc = "Dismiss Notifications",
				},
				{
					"<leader>unl",
					function()
						require("telescope").extensions.notify.notify()
					end,
					desc = "List Notifications",
				},
			}
		end,
	},
	-- fix surround-nvim
	{
		"folke/noice.nvim",
		opts = {
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "echomsg",
						find = "No textobject",
					},
					opts = { skip = true },
				},
			},
		},
	},

}
