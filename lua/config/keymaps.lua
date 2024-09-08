-- ------------------------- vscode specific config ----------------------------
if vim.g.vscode then
  -- selection 한 뒤 paste 할 때 selection 내용이 register 에 yank 되지 않도록 변경
  vim.keymap.set({ "n", "x" }, "p", "P", { silent = true })

  -- 라인 삭제 한 내용이 register 에 등록되지 않도록 변경
  vim.keymap.set({ "n" }, "dd", [["_dd]], { silent = true })
  -- [["_dd]] 설명 및 아래 두 설정의 차이점:
  -- vim.keymap.set({ "n" }, "dd", "_dd", { silent = true })
  -- vim.keymap.set({ "n" }, "dd", [["_dd]], { silent = true })
  -- 1. 첫 번째 설정: vim.keymap.set({ "n" }, "dd", "_dd", { silent = true })
  --    - "_dd"가 일반 Lua 문자열로 전달됨
  --    - Lua가 문자열을 처리한 후 Vim에 전달
  --
  -- 2. 두 번째 설정: vim.keymap.set({ "n" }, "dd", [["_dd]], { silent = true })
  --    - [["_dd]]는 Lua의 Raw String Literal 문법
  --    - 문자열이 그대로 Vim에 전달됨
  --
  -- 주요 차이점:
  -- 1. 이스케이프 처리:
  --    - 첫 번째: Lua가 문자열 처리 후 Vim에 전달
  --    - 두 번째: 문자열이 그대로 Vim에 전달
  --
  -- 2. 특수 문자 해석:
  --    - 첫 번째: '_'가 Lua 문자열의 일부로 취급될 수 있음
  --    - 두 번째: '"_'가 명확하게 Vim 명령의 일부로 인식됨
  --
  -- 3. 안정성:
  --    - 두 번째 방식이 더 안정적
  --    - Vim 명령어에 특수 문자나 따옴표 포함 시 문제 방지
  --
  -- 실제 효과:
  -- - 이 경우("_dd) 두 방식 모두 같은 결과 가능성 높음
  -- - 복잡한 명령이나 특수 문자 포함 시 두 번째 방식이 더 안전
  --
  -- 예시:
  -- vim.keymap.set('n', 'test', 'i"test"<Esc>', { noremap = true })
  -- vim.keymap.set('n', 'test', [[i"test"<Esc>]], { noremap = true })
  -- - 첫 번째 줄: 문제 가능성 있음
  -- - 두 번째 줄: 안전하게 작동
  --
  -- 결론:
  -- Raw String Literal 사용하는 두 번째 방식([["_dd]])이 더 명확하고 안전
  -- 복잡한 Vim 명령어 매핑 시 이 방식 권장
  -- vim.keymap.set({ "n" }, "dd", "_dd", { silent = true })


  -- 라인 가장 앞쪽으로 이동
  vim.keymap.set({ "n", "x" }, "<C-h>", "^", { silent = true })
  -- 라인 가장 끝으로 이동
  vim.keymap.set({ "n", "x" }, "<C-l>", "$", { silent = true })

  -- 라인 이동
  -- 현재 라인을 한줄 위로
  vim.keymap.set("n", "<A-k>", "ddkP", { silent = true })
  -- 현재 라인을 한줄 아래로
  vim.keymap.set("n", "<A-j>", "ddp", { silent = true })
  --  아래 내용 2024.09.09 기준 동작하지 않음, NVIM v0.10.1
  -- `[v`] => 방금 paste 했던 부분을 selection
  --  https://stackoverflow.com/questions/4312664/is-there-a-vim-command-to-select-pasted-texta
  --  `[v`] 뒤에  V의 역할 => select하고 나면 라인 전체가 select 된게 아니라서 V를 통해 마지막 라인 전체를 select에 포함
  -- 현재 visual block을 한줄 위로
  -- vim.keymap.set("x", "<A-k>", "dkP`[v`]V", { silent = true })
  -- -- 현재 visual block을 한줄 아래로
  -- vim.keymap.set("x", "<A-j>", "dp`[v`]V", { silent = true })

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
