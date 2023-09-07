require('p-iknow.base')
require('p-iknow.plugins')
require('p-iknow.highlights')
require('p-iknow.feed_keys')
require('p-iknow.move_visual_selection')
require('p-iknow.search')

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
local move_cursor_to_end_of_yanked_text = "y`]"
vim.keymap.set("v", "y", move_cursor_to_end_of_yanked_text)

local move_cursor_to_end_of_pasted_text = "p`]"
vim.keymap.set("n", "p", move_cursor_to_end_of_pasted_text)

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


local twelve_lines_down = "12jzz"
vim.keymap.set("", "<C-d>", twelve_lines_down)

local twelve_lines_up = "12kzz"
vim.keymap.set("", "<C-u>", twelve_lines_up)



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


local substitute_letter = "s"
vim.keymap.set("n", "r", substitute_letter)



-- Own Vscode vim setting
if vim.g.vscode then
	-- visual mode mapping to register paste

	vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true })
	vim.keymap.set('v', 'P', '"_dP', { noremap = true, silent = true })
	-- refactor

	-- visual mode mapping to replace selected text
	vim.keymap.set('', 'gs', 'y:%s/\\<<c-r>"\\>/<c-r>"/g', { noremap = true, })

	-- non-interactively delete all occurrences of selected text
	vim.keymap.set('v', 'gd', 'y:%s/\\<<c-r>"\\>//g<cr>', { noremap = true, silent = true })

	-- make navigation more intuitive
	vim.keymap.set('n', 'k', '(v:count == 0 ? "gk" : "k")', { expr = true })
	vim.keymap.set('n', 'j', '(v:count == 0 ? "gj" : "j")', { expr = true })
	vim.keymap.set('n', '^', '(v:count == 0 ? "g^" : "^")', { expr = true })

	-- don't copy single letter deletes
	vim.keymap.set('n', 'x', '"_x', { noremap = true })

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
	local function outdent_vis()
		vim.fn.VSCodeNotify("editor.action.outdentLines", false)
	end
	vim.keymap.set("v", "<", outdent_vis)

	local function indent_vis()
		vim.fn.VSCodeNotify("editor.action.indentLines", false)
	end
	vim.keymap.set("v", ">", indent_vis)

	local function comment()
		vim.fn.VSCodeNotify("editor.action.commentLine")
	end

	vim.keymap.set("n", "gc", comment)
	local function comment_vis()
		vim.fn.VSCodeNotify("editor.action.commentLine", false)
	end
	vim.keymap.set("v", "gc", comment_vis)
end



print("nvim loaded")
