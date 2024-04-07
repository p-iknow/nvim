-- ------------------------- vscode specific config ----------------------------
if vim.g.vscode then
  -- selection 한 뒤 paste 할 때 selection 내용이 register 에 yank 되지 않도록 변경
  vim.keymap.set({ "n", "x" }, "p", "P", { silent = true })

  -- 라인 가장 앞쪽으로 이동
  vim.keymap.set({ "n", "x" }, "<C-h>", "^", { silent = true })
  -- 라인 가장 끝으로 이동
  vim.keymap.set({ "n", "x" }, "<C-l>", "$", { silent = true })

  -- 새로운 라인을 만들기
  local make_new_line_under = "o<Esc>"
  vim.keymap.set("n", "oo", make_new_line_under)

  local make_new_line_upper = "O<Esc>"
  vim.keymap.set("n", "OO", make_new_line_upper)

  local twelve_lines_down = "13j"
  vim.keymap.set({ "n", "x" }, "<C-d>", twelve_lines_down)

  local twelve_lines_up = "13kzz"
  vim.keymap.set({ "n", "x" }, "<C-u>", twelve_lines_up)
  -- better up/down (wrapped line 을 반영하여 움직이도록 합니다.)
  -- @link: https://github.com/vscode-neovim/vscode-neovim/blob/eb33ddd6c8794f1eeabe5b5e3ef7eba8619b60c7/vim/vscode-motion.vim#L14-L16
  vim.keymap.set({ "n" }, 'k', function()
    vim.cmd("call VSCodeNotify('cursorMove', {'to': 'up', 'by': 'wrappedLine', 'value': " .. vim.v.count1 .. "})")
  end, { silent = true })

  vim.keymap.set({ "n" }, 'j', function()
    vim.cmd("call VSCodeNotify('cursorMove', {'to': 'down', 'by': 'wrappedLine', 'value': " .. vim.v.count1 .. "})")
  end, { silent = true })
else
  -- -- ------------------------- neovim specific config ----------------------------
end
