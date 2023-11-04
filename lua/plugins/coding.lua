return {
	-- for vscode
	-- motion plugin, lightspeed
	-- https://github.com/ggandor/lightspeed.nvim
	--'ggandor/lightspeed.nvim', -- s(forward), S(backward)

	-- surround
	-- https://github.com/kylechui/nvim-surround
	{ "kylechui/nvim-surround",         config = true, vscode = true },

	--  exchange/replace
	{ "vim-scripts/ReplaceWithRegister" },
	{
		-- https://github.com/gbprod/substitute.nvim
		"gbprod/substitute.nvim",
		event = "VeryLazy",
		opts = {
			on_substitute = function(event)
				require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
			end,
		},
		keys = {
			{ "gr",  "<cmd>lua require('substitute').operator()<cr>" },
			{ "grr", "<cmd>lua require('substitute').line()<cr>" },
			{ "gR",  "<cmd>lua require('substitute').eol()<cr>" },
			-- visual mode일 때 p를 하면 지워진 텍스트가 다시 register에 들어가는 것 방지하기 위함
			{ "p",   "<cmd>lua require('substitute').visual()<cr>",           mode = "x" },
			{ "cx",  "<cmd>lua require('substitute.exchange').operator()<cr>" },
			{ "cxx", "<cmd>lua require('substitute.exchange').line()<cr>" },
			{ "X",   "<cmd>lua require('substitute.exchange').visual()<cr>",  mode = "x" },
			{ "cxc", "<cmd>lua require('substitute.exchange').cancel()<cr>" },
		},
		dependencies = {
			{
				--
				"gbprod/yanky.nvim",
				opts = {
					highlight = {
						on_put = true,
						on_yank = true,
						timer = 300,
					},
					system_clipboard = {
						sync_with_ring = false,
					},
				},
				-- https://github.com/gbprod/yanky.nvim#%EF%B8%8F-mappings
				keys = {
					--  vscode에서 아래 yankyyank는 동작하지 않는다.
					-- { mode = { "n", "x" }, "y",  "<plug>(yankyyank)" },
					{ mode = { "n" }, "p", "<Plug>(YankyPutAfter)" },
					{ mode = { "n" }, "P", "<Plug>(YankyPutBefore)" },

				},
				vscode = true,
			},

		},
		vscode = true,
	},

	-- better text-objects
	{
		"kana/vim-textobj-user",
		dependencies = {
			-- https://github.com/kana/vim-textobj-entire
			{ "kana/vim-textobj-entire",             vscode = true }, -- e - entire
			-- https://github.com/kana/vim-textobj-line/blob/master/doc/textobj-line.txt
			{ "kana/vim-textobj-line",               vscode = true }, -- l - line
			--https://github.com/inside/vim-textobj-jsxattr
			{ "inside/vim-textobj-jsxattr",          vscode = true }, -- x - attribute
			{ "Julian/vim-textobj-variable-segment", vscode = true }, -- v - segment
			{ "kana/vim-textobj-indent",             vscode = true }, -- i - indent block, I - same indent (wont select sub indent, vscode = true}
			{ "MRAAGH/vim-textobj-chunk",            vscode = true }, -- lines that contain {},(, vscode = true},[] block. Use to select functions.
		},
		vscode = true,
	},
}
