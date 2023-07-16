--- Options
vim.opt.number               = true
vim.opt.relativenumber       = true
vim.opt.tabstop              = 3
vim.opt.shiftwidth           = 3
vim.opt.expandtab            = false
vim.opt.smartindent          = true
vim.opt.mouse                = "a"
vim.opt.ignorecase           = true
vim.opt.smartcase            = true
vim.opt.hlsearch             = true
vim.opt.colorcolumn          = ""
vim.g.mapleader              = ","
vim.g.rust_recommended_style = false
vim.opt.syntax               = "enable"
vim.opt.termguicolors        = true
vim.opt.background           = "dark"
vim.g.targets_nl             = "nh"
vim.cmd("set clipboard=unnamedplus")


--- Plugins: VimPlug
local Plug = vim.fn['plug#']
vim.call("plug#begin")
-- https://github.com/tpope/vim-repeat
Plug("tpope/vim-repeat")
-- https://github.com/sheerun/vim-polyglot language pack
Plug("sheerun/vim-polyglot")
-- https://github.com/kana/vim-textobj-user
Plug("kana/vim-textobj-user")
-- https://github.com/kana/vim-textobj-entire
-- vae vie
Plug("kana/vim-textobj-entire")
-- https://github.com/kana/vim-textobj-line/blob/master/doc/textobj-line.txt
-- val vil
Plug("kana/vim-textobj-line")
--https://github.com/inside/vim-textobj-jsxattr
-- vix vax tag attriubez
Plug 'inside/vim-textobj-jsxattr'
--https://github.com/beloglazov/vim-textobj-punctuation
-- viu vau select to punctuation
Plug 'beloglazov/vim-textobj-punctuation'
--https://github.com/vimtaku/vim-textobj-keyvalue/blob/master/doc/textobj-key-value.txt
-- vik vaK viv viV select to key value
Plug 'vimtaku/vim-textobj-keyvalue'
-- https://github.com/michaeljsmith/vim-indent-object
Plug("michaeljsmith/vim-indent-object")
Plug("vim-scripts/ReplaceWithRegister")
--https://github.com/wellle/targets.vim
-- 학습 필요
Plug("wellle/targets.vim")
vim.call("plug#end")

--- Plugins: Packer
require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
	use "savq/melange"
	use "sainnhe/everforest"
	use "sainnhe/edge"
	use "sainnhe/gruvbox-material"
	use "jacoborus/tender.vim"
	use "ap/vim-css-color"
	use "farmergreg/vim-lastplace"
	use 'ggandor/lightspeed.nvim'
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	})
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true }
	}
end)

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',

		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}
--https://github.com/ggandor/lightspeed.nvim/issues/76#issuecomment-1137568236
vim.cmd("hi LightspeedCursor gui=reverse")




-- Yank Hightlight
vim.cmd [[
	augroup highlight_yank
	autocmd!
	autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=100 }
	augroup END
]]

-- mark fix
--for c = string.byte("a"), string.byte("z") do
--	local char = string.char(c)
--	local upper_char = string.upper(char)
--	vim.keymap.set("n", "m" .. char, "m" .. upper_char)
--	vim.keymap.set("n", "`" .. char, "`" .. upper_char)
--	vim.keymap.set("n", "<leader>m" .. char, "m" .. char)
--end


-- Own functions

function FeedKeys(keys)
	vim.api.nvim_feedkeys(keys, "n", false)
end

function FeedKeysInt(keys)
	local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(feedable_keys, "n", true)
end

function EscapeForLiteralSearch(input)
	input = string.gsub(input, '\\', '\\\\')
	input = string.gsub(input, '/', '\\/')
	return input
end

function EscapeFromLiteralSearch(input)
	if string.sub(input, 1, 2) ~= "\\V" then return input end
	input = string.sub(input, 3)
	input = string.gsub(input, '\\/', '/')
	input = string.gsub(input, '\\\\', '\\')
	return input
end

function EscapeFromRegexSearch(input)
	if string.sub(input, 1, 2) ~= '\\v' then return input end
	return string.sub(input, 3)
end

function GetChar(prompt)
	vim.api.nvim_echo({ { prompt, "Input" } }, true, {})
	local char = vim.fn.getcharstr()
	-- That's the escape character (<Esc>). Not sure how to specify it smarter
	-- In other words, if you pressed escape, we return nil
	if char == '' then
		char = nil
	end
	return char
end

function Validate_register(register)
	if register == 'q' then
		return '+'
	elseif register == 'w' then
		return '0'
	elseif register == "'" then
		return '"'
	else
		return register
	end
end

function GetBool(message)
	local char = GetChar(message .. " (f/d):")
	local bool
	if char == 'f' then
		bool = true
	elseif char == 'd' then
		bool = false
	else
		print("Press f for true, d for false")
		return nil
	end
	return bool
end

-- vscode 에서 visual mode 에서도 alt + up, down 키로 라인무브를 할 수 있는 설정
-- https://github.com/vscode-neovim/vscode-neovim/issues/200#issuecomment-1245431983
function MoveVisualSelection(direction)
	-- vim.pretty_print(vim.fn.line('.'))
	-- vim.pretty_print(vim.fn.line('v'))

	local cursorLine = vim.fn.line('v')
	local cursorStartLine = vim.fn.line('.')

	local startLine = cursorLine
	local endLine = cursorStartLine

	if direction == "Up" then
		if startLine < endLine then
			local tmp = startLine
			startLine = endLine
			endLine = tmp
		end
	else -- == "Down"
		if startLine > endLine then
			local tmp = startLine
			startLine = endLine
			endLine = tmp
		end
	end

	-- move lines
	vim.cmd("call VSCodeCallRange('editor.action.moveLines" ..
		direction .. "Action'," .. startLine .. "," .. endLine .. ",1)")

	-- move visual selection
	if direction == "Up" then
		if endLine > 1 then
			startLine = startLine - 1
			endLine = endLine - 1

			-- exit visual mode
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), 'x', true)

			-- select range
			vim.cmd("normal!" .. startLine .. "GV" .. endLine .. "G")
			-- vim.api.nvim_command(tostring(endLine)) -- move cursor
			-- vim.api.nvim_feedkeys("V", 'n', false) -- enter visual line mode
			-- vim.api.nvim_command(tostring(startLine)) -- move cursor
		end
	else -- == "Down"
		if endLine < vim.api.nvim_buf_line_count(0) then
			startLine = startLine + 1
			endLine = endLine + 1

			-- exit visual mode
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), 'x', true)

			-- select range
			vim.cmd("normal!" .. startLine .. "GV" .. endLine .. "G")
		end
	end
end

-- Own Vscode vim setting
if vim.g.vscode then
	-- copliot chat
	local function start_code_chat()
		vim.fn.VSCodeNotifyVisual("inlineChat.start", true)
	end
	-- move line
	vim.keymap.set('v', '<a-up>', function() MoveVisualSelection('Up') end, { noremap = true })
	vim.keymap.set('v', '<a-down>', function() MoveVisualSelection('Down') end, { noremap = true })

	vim.keymap.set('v', 'J', function() MoveVisualSelection('Up') end, { noremap = true })
	vim.keymap.set('v', 'K', function() MoveVisualSelection('Down') end, { noremap = true })

	vim.keymap.set("v", "<D-i>", start_code_chat)
	-- visual mode mapping to register paste

	vim.keymap.set('v', 'p', '"_dp', { noremap = true, silent = true })
	vim.keymap.set('v', 'P', '"_dP', { noremap = true, silent = true })
	-- refactor
	local function refactor()
		vim.fn.VSCodeNotifyVisual("editor.action.refactor", true)
	end
	vim.keymap.set("v", "<D-S-r>", refactor)

	-- visual mode mapping to replace selected text
	vim.keymap.set('', 'gs', 'y:%s/\\<<c-r>"\\>//g', { noremap = true, })

	-- non-interactively delete all occurrences of selected text
	vim.keymap.set('v', 'gd', 'y:%s/\\<<c-r>"\\>//g<cr>', { noremap = true, silent = true })

	-- make navigation more intuitive
	vim.keymap.set('n', 'k', '(v:count == 0 ? "gk" : "k")', { expr = true })
	vim.keymap.set('n', 'j', '(v:count == 0 ? "gj" : "j")', { expr = true })
	vim.keymap.set('n', '^', '(v:count == 0 ? "g^" : "^")', { expr = true })

	-- keep selection
	vim.keymap.set('', '<', '<gv', {})
	vim.keymap.set('', '>', '>gv', {})

	-- don't copy single letter deletes
	vim.keymap.set('n', 'x', '"_x', { noremap = true })

	local function center_screen()
		vim.cmd("call <SNR>4_reveal('center', 0)")
	end
	local function move_to_top_screen()
		vim.cmd("call <SNR>4_moveCursor('top')")
	end
	local function move_to_bottom_screen()
		vim.cmd("call <SNR>4_moveCursor('bottom')")
	end

	local function move_to_bottom_screen__center_screen()
		move_to_bottom_screen()
		center_screen()
	end
	vim.keymap.set("", "L", move_to_bottom_screen__center_screen)

	local function move_to_top_screen__center_screen()
		move_to_top_screen()
		center_screen()
	end
	vim.keymap.set("", "H", move_to_top_screen__center_screen)

	local function rename_symbol()
		vim.fn.VSCodeNotify("editor.action.rename")
	end
	vim.keymap.set("n", "<leader>r", rename_symbol)

	local function outdent()
		---@diagnostic disable-next-line: unused-local
		for i = 1, vim.v.count1 do
			vim.fn.VSCodeNotify("editor.action.outdentLines")
		end
	end
	vim.keymap.set("n", "<<", outdent)

	local function indent()
		---@diagnostic disable-next-line: unused-local
		for i = 1, vim.v.count1 do
			vim.fn.VSCodeNotify("editor.action.indentLines")
		end
	end
	vim.keymap.set("n", ">>", indent)
	local function reindent()
		vim.fn.VSCodeNotify("editor.action.reindentlines")
	end
	vim.keymap.set("n", "==", reindent)
	local function outdent_vis()
		vim.fn.VSCodeNotifyVisual("editor.action.outdentLines", false)
	end
	vim.keymap.set("v", "<", outdent_vis)

	local function indent_vis()
		vim.fn.VSCodeNotifyVisual("editor.action.indentLines", false)
	end
	vim.keymap.set("v", ">", indent_vis)

	local function comment()
		vim.fn.VSCodeNotify("editor.action.commentLine")
	end

	vim.keymap.set("n", "gc", comment)
	local function comment_vis()
		vim.fn.VSCodeNotifyVisual("editor.action.commentLine", false)
	end
	vim.keymap.set("v", "gc", comment_vis)
else
	local function closeEditor()
		vim.cmd("x")
	end
	vim.keymap.set("n", "K", closeEditor)

	local function close_without_saving()
		vim.cmd("q!")
	end
	vim.keymap.set("n", "<leader>K", close_without_saving)

	local function save_vim() vim.cmd("w") end
	vim.keymap.set("", "U", save_vim)

	local move_to_bottom_screen__center_screen = 'Lzz'
	vim.keymap.set("", "L", move_to_bottom_screen__center_screen)

	local move_to_top_screen__center_screen = 'Hzz'
	vim.keymap.set("", "H", move_to_top_screen__center_screen)

	local function save_vim() vim.cmd("w") end
	vim.keymap.set("", "U", save_vim)
end

local block_text_object_self_sameline = "aBV"
vim.keymap.set("v", "im", block_text_object_self_sameline)

local block_text_object_extra_sameline = "aBVj"
vim.keymap.set("v", "am", block_text_object_extra_sameline)

local block_text_object_self_diffline = "aBVok"
vim.keymap.set("v", "iM", block_text_object_self_diffline)

local block_text_object_extra_diffline = "aBVjok"
vim.keymap.set("v", "aM", block_text_object_extra_diffline)

local function block_text_object_self_sameline_operator()
	vim.cmd("normal vaBV")
end
vim.keymap.set("o", "im", block_text_object_self_sameline_operator)

local function block_text_object_extra_sameline_operator()
	vim.cmd("normal vaBVj")
end
vim.keymap.set("o", "am", block_text_object_extra_sameline_operator)

local function block_text_object_self_diffline_operator()
	vim.cmd("normal vaBVok")
end
vim.keymap.set("o", "iM", block_text_object_self_diffline_operator)

local function block_text_object_extra_diffline_operator()
	vim.cmd("normal vaBVjok")
end
vim.keymap.set("o", "aM", block_text_object_extra_diffline_operator)


local function comment_text_object_extra_operator()
	vim.cmd("normal v[/o]/V")
end
vim.keymap.set("o", "agc", comment_text_object_extra_operator)

local function comment_text_object_self_operator()
	vim.cmd("normal v[/3lo]/2h")
end
vim.keymap.set("o", "igc", comment_text_object_self_operator)

local function goto_end_of_prev_line()
	FeedKeysInt(vim.v.count1 .. "k$")
end
vim.keymap.set("", "_", goto_end_of_prev_line)

local goto_middle_of_line = "gM"
vim.keymap.set("", "gm", goto_middle_of_line)


-- 새로운 라인을 만들기
local make_new_line_under = "o<Esc>"
vim.keymap.set("n", "oo", make_new_line_under)

local make_new_line_upper = "O<Esc>"
vim.keymap.set("n", "OO", make_new_line_upper)

-- 복사, 붙여넣기 이후에 커서가 붙여넣은 텍스트의 끝으로 이동하기 위함
-- https://stackoverflow.com/questions/3806629/yank-a-region-in-vim-without-the-cursor-moving-to-the-top-of-the-block
local capital_yank_doesnt_consume_newline = "yg_"
vim.keymap.set("n", "Y", capital_yank_doesnt_consume_newline)

local move_cursor_to_end_of_yanked_text = "y`]"
vim.keymap.set("v", "y", move_cursor_to_end_of_yanked_text)

local move_cursor_to_end_of_pasted_text = "p`]"
vim.keymap.set("n", "p", move_cursor_to_end_of_pasted_text)

local switch_case_stays_in_place = "~h"
vim.keymap.set("n", "~", switch_case_stays_in_place)

local switch_lines_forward = "ddp"
vim.keymap.set("n", "dp", switch_lines_forward)

local switch_lines_backward = "ddkP"
vim.keymap.set("n", "dP", switch_lines_backward)

local copy_line_forward = "yyp"
vim.keymap.set("n", "yp", copy_line_forward)

local copy_line_backward = "yyP"
vim.keymap.set("n", "yP", copy_line_backward)

local join_lines_no_space = "j0d^kgJ"
vim.keymap.set("n", "gJ", join_lines_no_space)

local backspace_action = ""
vim.keymap.set("n", "<BS>", backspace_action)

local space_action = ""
vim.keymap.set("n", "<Space>", space_action)


local function multiply_visual()
	FeedKeysInt("ygv<Esc>" .. vim.v.count1 .. "p")
end
vim.keymap.set("v", "<leader>q", multiply_visual)

local complete_line = "<C-x><C-l>"
vim.keymap.set("i", "<C-l>", complete_line)

local delete_up_to_last_line_end = '<C-o>"_S<Esc><C-o>gI<BS>'
vim.keymap.set("i", "<C-h>", delete_up_to_last_line_end)

local insert_blank_line_up_insert = "<C-o>O"
vim.keymap.set("i", "<C-k>", insert_blank_line_up_insert)

local insert_blank_line_down_insert = "<C-o>o"
vim.keymap.set("i", "<C-j>", insert_blank_line_down_insert)

local previous_blank_line_operator = "V{"
vim.keymap.set("o", "{", previous_blank_line_operator)

local next_blank_line_operator = "V}"
vim.keymap.set("o", "}", next_blank_line_operator)

local twelve_lines_down = "12jzz"
vim.keymap.set("", "<C-d>", twelve_lines_down)

local twelve_lines_up = "12kzz"
vim.keymap.set("", "<C-u>", twelve_lines_up)

local insert_blank_line_up = "O<Esc>"
vim.keymap.set("n", "<C-K>", insert_blank_line_up)

local insert_blank_line_down = "o<Esc>"
vim.keymap.set("n", "<C-J>", insert_blank_line_down)

local function remove_highlighting()
	vim.cmd("noh")
end
local function remove_highlighting__escape()
	remove_highlighting()
	FeedKeysInt("<Esc>")
end
vim.keymap.set("n", "<Esc>", remove_highlighting__escape)


local function multiply()
	FeedKeysInt("yl" .. vim.v.count1 .. "p")
end
vim.keymap.set("n", "<leader>q", multiply)


local system_clipboard_register = '"+'
vim.keymap.set("", "'q", system_clipboard_register)

local yanked_register = '"0'
vim.keymap.set("", "'w", yanked_register)

local black_hole_register = '"_'
vim.keymap.set("", "'i", black_hole_register)

local command_register = '":'
vim.keymap.set("", "';", command_register)

local paste_system_register = "<C-r><C-p>+"
vim.keymap.set("!", "<C-v>", paste_system_register)

local paste_yank_register = "<C-r><C-p>0"
vim.keymap.set("!", "<C-r>w", paste_yank_register)

local paste_command_register = "<C-r><C-p>:"
vim.keymap.set("!", "<C-r>;", paste_command_register)

local paste_default_register = '<C-r><C-p>"'
vim.keymap.set("!", "<C-b>", paste_default_register)


function Search_for_selection(search_operator)
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(search_operator .. '\\V' .. escaped_selection)
		FeedKeysInt('<cr>')
		FeedKeys('N')
	end)
end

-- CMD + D
vim.keymap.set("v", "*", "<cmd>lua Search_for_selection('/')<cr>")
vim.keymap.set("v", "#", "<cmd>lua Search_for_selection('?')<cr>")

function Regex_search(searchOperator)
	FeedKeys(searchOperator .. '\\v')
end

vim.keymap.set("", "<leader>/", "<cmd>lua Regex_search('/')<cr>")
vim.keymap.set("", "<leader>?", "<cmd>lua Regex_search('?')<cr>")

function Literal_search(searchOperator)
	local escaped_text = EscapeForLiteralSearch(vim.fn.input("Type in your literal search: "))
	if escaped_text == '' then
		return
	end
	FeedKeys(searchOperator .. '\\V' .. escaped_text)
	FeedKeysInt("<cr>")
end

vim.keymap.set("", "/", "<cmd>lua Literal_search('/')<cr>")
vim.keymap.set("", "?", "<cmd>lua Literal_search('?')<cr>")

function Search_for_register(search_operator)
	local char = GetChar("Input register key to search for:")
	if not char then return end
	local register = Validate_register(char)
	local escaped_register = EscapeForLiteralSearch(vim.fn.getreg(register))
	FeedKeys(search_operator .. '\\V' .. escaped_register)
	FeedKeysInt('<cr>')
end

vim.keymap.set("", "<leader>f", "<cmd>lua Search_for_register('/')<cr>")
vim.keymap.set("", "<leader>F", "<cmd>lua Search_for_register('?')<cr>")

function Search_for_current_word(direction)
	FeedKeys('yiw')
	vim.schedule(function()
		local escaped_word = vim.fn.getreg('"')
		FeedKeys(direction .. '\\v<' .. escaped_word .. ">")
		FeedKeysInt('<cr>')
	end)
end

vim.keymap.set("n", "*", "<cmd>lua Search_for_current_word('/')<cr>")
vim.keymap.set("n", "#", "<cmd>lua Search_for_current_word('/')<cr>")

function Better_replace(range)
	local what
	what = vim.fn.input("Enter what:")
	if what == '' then
		print("You didn't specify 'what'")
		return
	end

	local magic = ''
	if string.sub(what, 1, 2) ~= '\\v' then
		what = EscapeForLiteralSearch(what)
		magic = "\\V"
	end

	local with
	with = vim.fn.input("Enter with:")

	vim.cmd(range .. "s/" .. magic .. what .. "/" .. with .. "/g")
end

local substitute_letter = "s"
vim.keymap.set("n", "r", substitute_letter)

local repeat_replace_goes_next = "n&"
vim.keymap.set("n", "&", repeat_replace_goes_next)

local captal_R_records_macro = 'q'
vim.keymap.set("", "R", captal_R_records_macro)


local inclusive_next_blankie = "}k"
vim.keymap.set("n", "<leader>}", inclusive_next_blankie)
vim.keymap.set("v", "<leader>}", inclusive_next_blankie)

local inclusive_prev_blankie = "{j"
vim.keymap.set("n", "<leader>{", inclusive_prev_blankie)
vim.keymap.set("v", "<leader>{", inclusive_prev_blankie)

local function inclusive_next_blankie_visual() vim.cmd("normal V}k") end
vim.keymap.set("o", "<leader>}", inclusive_next_blankie_visual)

local function inclusive_prev_blankie_visual() vim.cmd("normal V{j") end
vim.keymap.set("o", "<leader>{", inclusive_prev_blankie_visual)

local dig_into_docs = "K"
vim.keymap.set("n", "gK", dig_into_docs)

local copy_current_character = 'yl'
vim.keymap.set("n", "X", copy_current_character)

-- 잘 사용하지 않고 용처를 모르는 내용들
-- 잘 사용하지 않는 sign(%) obperator
local percent_sign_text_object_self_visual = "T%ot%"
vim.keymap.set("v", "i%", percent_sign_text_object_self_visual)

local percent_sign_text_object_extra_visual = "F%of%"
vim.keymap.set("v", "a%", percent_sign_text_object_extra_visual)

local function percent_sign_text_object_self_operator()
	vim.cmd("normal vT%ot%")
end
vim.keymap.set("o", "i%", percent_sign_text_object_self_operator)

local function percent_sign_text_object_extra_operator()
	vim.cmd("normal vF%of%")
end
vim.keymap.set("o", "a%", percent_sign_text_object_extra_operator)
print("nvim loaded")
