if vim.g.vscode then
	-- vscode 에서 visual mode 에서도 alt + up, down 키로 라인무브를 할 수 있는 설정
	-- https://github.com/vscode-neovim/vscode-neovim/issues/200#issuecomment-1245431983
	local function moveVisualSelection(direction)
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


	-- move line
	vim.keymap.set('v', '<a-up>', function() moveVisualSelection('Up') end, { noremap = true })
	vim.keymap.set('v', '<a-down>', function() moveVisualSelection('Down') end, { noremap = true })
end
