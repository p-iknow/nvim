-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.mapleader = " "
-- vim.g.mapleader = " " 일때 leader 키가 작동하기 위한 세팅
-- 아래 세팅을 하지 않으면 vscode neovim extension 에서 leader 키가 작동하지 않음
vim.keymap.set({ 'n', 'x' }, '<Space>', '', {})
vim.opt.timeoutlen = 500                   -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.whichwrap:append("<>hl[]")         -- allow movement between end/start of line
vim.opt.linebreak = true                   -- if text should be wrapped at certain characters
vim.opt.clipboard:append { 'unnamedplus' } -- copy to system clipboard
vim.opt.encoding = 'utf-8'

-- 2024.09.09 기준 nvim nightly에서는 문제가 해결됬다고 하니 살펴보고 아래 설정 삭제할지 결정
-- https://github.com/ggandor/leap.nvim/issues/27#issuecomment-2094752976
-- vim leap 플러그인 이슈를 해결하기 위한 세팅
-- https://github.com/ggandor/leap.nvim/issues/27#issuecomment-1445046929
vim.api.nvim_set_hl(0, 'Cursor', { reverse = true })
