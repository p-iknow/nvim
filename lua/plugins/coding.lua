---@diagnostic disable: undefined-doc-name, inject-field
return {
	-- for vscode
	-- motion plugin, lightspeed
	-- https://github.com/ggandor/lightspeed.nvim
	--'ggandor/lightspeed.nvim', -- s(forward), S(backward)

	-- surround
	-- https://github.com/kylechui/nvim-surround
	{ "kylechui/nvim-surround",         config = true, vscode = true },

	--  exchange/replace
	{
		-- https://github.com/gbprod/substitute.nvim
		"gbprod/substitute.nvim",
		opts = {
			on_substitute = function(event)
				require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
			end,
		},
		keys = {
			{ "gr",  "<cmd>lua require('substitute').operator()<cr>" },
			{ "grr", "<cmd>lua require('substitute').line()<cr>" },
			{ "gR",  "<cmd>lua require('substitute').eol()<cr>" },
			{ "gr",  "<cmd>lua require('substitute').visual()<cr>",           mode = "x" },
			{ "cx",  "<cmd>lua require('substitute.exchange').operator()<cr>" },
			{ "cxx", "<cmd>lua require('substitute.exchange').line()<cr>" },
			{ "X",   "<cmd>lua require('substitute.exchange').visual()<cr>",  mode = "x" },
			{ "cxc", "<cmd>lua require('substitute.exchange').cancel()<cr>" },
		},
		dependencies = {
			{
				"gbprod/yanky.nvim",
				opts = {
					system_clipboard = {
						sync_with_ring = false,
					},
					highlight = {
						on_put = true,
						on_yank = true,
						timer = 500,
					},
				},
				-- https://github.com/gbprod/yanky.nvim#%EF%B8%8F-mappings
				keys = {
					{ mode = { "n", "x" }, "p",     "<Plug>(YankyPutAfter)" },
					{ mode = { "n", "x" }, "P",     "<Plug>(YankyPutBefore)" },
					{ mode = { "n", "x" }, "gp",    "<Plug>(YankyGPutAfter)" },
					{ mode = { "n", "x" }, "gP",    "<Plug>(YankyGPutBefore)" },
					{ mode = "n",          "<c-n>", "<Plug>(YankyCycleForward)" },
					{ mode = "n",          "<c-p>", "<Plug>(YankyCycleBackward)" },
				},
				vscode = true,
			},

		},
		vscode = true,
	},

	-- better text-objects
	{ "PeterRincker/vim-argumentative", vscode = true }, -- <, shift argument, [, move argument, , - argument{
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

	-- for nvim
	-- Use <tab> for completion and snippets (supertab)
	-- first: disable default <tab> and <s-tab> behavior in LuaSnip
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
	-- then: setup supertab in cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-emoji",
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")
			local cmp = require("cmp")

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- they way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			})
		end,
	},

}
