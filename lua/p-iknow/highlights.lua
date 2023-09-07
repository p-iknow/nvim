-- Yank Hightlight
vim.cmd [[
	augroup highlight_yank
	autocmd!
	autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=100 }
	augroup END
]]

local function remove_highlighting()
	vim.cmd("noh")
end
local function remove_highlighting__escape()
	remove_highlighting()
	FeedKeysInt("<Esc>")
end
vim.keymap.set("n", "<Esc>", remove_highlighting__escape)
