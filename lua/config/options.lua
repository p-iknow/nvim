-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.mapleader = ","
vim.opt.timeoutlen = 500                   -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.whichwrap:append("<>hl[]")         -- allow movement between end/start of line
vim.opt.linebreak = true                   -- if text should be wrapped at certain characters
vim.opt.clipboard:append { 'unnamedplus' } -- copy to system clipboard
vim.opt.encoding = 'utf-8'


if vim.g.vscode then
else
    -- -- ------------------------- neovim specific config ----------------------------
    -- for showing line numbers
    vim.opt.number = true
    -- for cursor set in the middle of the screen
    vim.opt.scrolloff = 15
end
