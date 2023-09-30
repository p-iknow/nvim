

  -- ------------------------- vscode specific config ----------------------------
if vim.g.vscode then
    -- 새로운 라인을 만들기
    local make_new_line_under = "o<Esc>"
    vim.keymap.set("n", "oo", make_new_line_under)
  
    local make_new_line_upper = "O<Esc>"
    vim.keymap.set("n", "OO", make_new_line_upper)
  
    local twelve_lines_down = "13j"
    vim.keymap.set("", "<C-d>", twelve_lines_down)
  
    local twelve_lines_up = "13kzz"
    vim.keymap.set("", "<C-u>", twelve_lines_up)
    -- better up/down
    vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
else
-- -- ------------------------- neovim specific config ----------------------------
end
