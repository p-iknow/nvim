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
vim.g.camelcasemotion_key    = "<leader>"
vim.g.targets_nl             = "nh"
vim.cmd("set clipboard=unnamedplus")



--- Plugins: VimPlug
local Plug = vim.fn['plug#']
vim.call("plug#begin")
-- https://github.com/tpope/vim-repeat
Plug("tpope/vim-repeat")
-- https://github.com/sheerun/vim-polyglot language pack
Plug("sheerun/vim-polyglot")
-- https://devhints.io/vim-easyalign
Plug("junegunn/vim-easy-align")
-- https://github.com/kana/vim-textobj-user
Plug("kana/vim-textobj-user")
-- https://github.com/kana/vim-textobj-entire
-- vae vie
Plug("kana/vim-textobj-entire")
-- https://github.com/kana/vim-textobj-line/blob/master/doc/textobj-line.txt
Plug("kana/vim-textobj-line")
Plug("vim-textobj-function")
Plug("vim-textobj-function")
-- https://github.com/michaeljsmith/vim-indent-object
Plug("michaeljsmith/vim-indent-object")
Plug("vim-scripts/ReplaceWithRegister")
Plug("wellle/targets.vim")
vim.call("plug#end")

--- Plugins: Packer
require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
	use "farmergreg/vim-lastplace"
	use "ap/vim-css-color"
	use 'ggandor/lightspeed.nvim'
	use({
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("nvim-surround").setup()
		end
	})
end)
--https://github.com/ggandor/lightspeed.nvim/issues/76#issuecomment-1137568236
vim.cmd("hi LightspeedCursor gui=reverse")

-- Yank Hightlight
vim.cmd [[
	augroup highlight_yank
	autocmd!
	autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=100 }
	augroup END
]]

-- Mark fix
for c = string.byte("a"), string.byte("z") do
	local char = string.char(c)
	local upper_char = string.upper(char)
	vim.keymap.set("n", "m" .. char, "m" .. upper_char)
	vim.keymap.set("n", "`" .. char, "`" .. upper_char)
	vim.keymap.set("n", "<leader>m" .. char, "m" .. char)
end

-- Own constants

local THROWAWAY_REGISTER = 'o'
local THROWAWAY_MARK = 'I'

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

-- Own Vscode vim setting
if vim.g.vscode then
	local function center_screen() vim.cmd("call <SNR>4_reveal('center', 0)") end
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

	local function comment() vim.fn.VSCodeNotify("editor.action.commentLine") end
	vim.keymap.set("n", "gcc", comment)
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
end

local easyAlignMapping = "<Plug>(EasyAlign)"
vim.keymap.set("", "ga", easyAlignMapping)

local replaceWithRegisterMapping = "<Plug>ReplaceWithRegisterLine"
vim.keymap.set("n", "grr", replaceWithRegisterMapping)

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


local markdown_heading_text_object_self_sameline_visual = "?^#<cr>oNk"
vim.keymap.set("v", "ir", markdown_heading_text_object_self_sameline_visual)

local markdown_heading_text_object_self_diffline_visual = "?^#<cr>koNk"
vim.keymap.set("v", "iR", markdown_heading_text_object_self_diffline_visual)

local comment_text_object_self_visual = "[/3lo]/2h"
vim.keymap.set("v", "igc", comment_text_object_self_visual)

local comment_text_object_extra_visual = "[/o]/V"
vim.keymap.set("v", "agc", comment_text_object_extra_visual)

local function comment_text_object_extra_operator()
	vim.cmd("normal v[/o]/V")
end
vim.keymap.set("o", "agc", comment_text_object_extra_operator)

local function comment_text_object_self_operator()
	vim.cmd("normal v[/3lo]/2h")
end
vim.keymap.set("o", "igc", comment_text_object_self_operator)

local function goto_end_of_prev_line() FeedKeysInt(vim.v.count1 .. "k$") end
vim.keymap.set("", "_", goto_end_of_prev_line)

local goto_middle_of_line = "gM"
vim.keymap.set("", "gm", goto_middle_of_line)

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

local space_action = ""
vim.keymap.set("n", "<Space>", space_action)

local backspace_action = ""
vim.keymap.set("n", "<BS>", backspace_action)

local disable_u_visual = "<Esc>u"
vim.keymap.set("v", "u", disable_u_visual)

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

local twenty_lines_down = "20jzz"
vim.keymap.set("", "<C-f>", twenty_lines_down)

local twenty_lines_up = "20kzz"
vim.keymap.set("", "<C-b>", twenty_lines_up)

local twelve_lines_down = "12jzz"
vim.keymap.set("", "<C-d>", twelve_lines_down)

local twelve_lines_up = "12kzz"
vim.keymap.set("", "<C-u>", twelve_lines_up)

local insert_blank_line_up = "O<Esc>"
vim.keymap.set("n", "<C-k>", insert_blank_line_up)

local insert_blank_line_down = "o<Esc>"
vim.keymap.set("n", "<C-j>", insert_blank_line_down)

local function remove_highlighting() vim.cmd("noh") end

local function remove_highlighting__escape()
	remove_highlighting()
	FeedKeysInt("<Esc>")
end
vim.keymap.set("n", "<Esc>", remove_highlighting__escape)

local function toggle_highlight_search() vim.cmd("set hlsearch!") end

local function multiply() FeedKeysInt("yl" .. vim.v.count1 .. "p") end
vim.keymap.set("n", "<leader>q", multiply)

local vore_out_line_into_block = '"_ddddpvaB<Esc>'
vim.keymap.set("n", "<leader>di", vore_out_line_into_block)

local convert_to_arrow_function = 'vaBo<Esc>"_s=> <Esc>Jj"_dd'
vim.keymap.set("n", "<leader>da", convert_to_arrow_function)

local convert_to_normal_function = '^f(%f="_c3l{<cr><Esc>o}<Esc>'
vim.keymap.set("n", "<leader>dn", convert_to_normal_function)

local function add_character_at_the_end_of_line()
	local char = GetChar("Press a character:")
	if not char then return end
	FeedKeys("m" .. THROWAWAY_MARK .. "A" .. char)
	FeedKeysInt("<Esc>")
	FeedKeys("`" .. THROWAWAY_MARK)
end
vim.keymap.set("n", "<leader>;", add_character_at_the_end_of_line)

local function add_character_at_the_start_of_line()
	local char = GetChar("Press a character:")
	if not char then return end
	FeedKeys("m" .. THROWAWAY_MARK .. "I" .. char)
	FeedKeysInt("<Esc>")
	FeedKeys("`" .. THROWAWAY_MARK)
end
vim.keymap.set("n", "<leader>:", add_character_at_the_start_of_line)

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

local delete_line_but_take_inside_line = 'dil\'_dd'
vim.keymap.set("n", "<leader>dl", delete_line_but_take_inside_line, { remap = true })

local move_line_to_top = 'ddm' .. THROWAWAY_MARK .. 'ggP`' .. THROWAWAY_MARK
vim.keymap.set("", "<leader>do", move_line_to_top)

local move_line_to_bottom = 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK
vim.keymap.set("", "<leader>db", move_line_to_bottom)

function Search_for_selection(search_operator)
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(search_operator .. '\\V' .. escaped_selection)
		FeedKeysInt('<cr>')
	end)
end

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
