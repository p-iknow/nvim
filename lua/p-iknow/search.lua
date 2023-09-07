local function getChar(prompt)
	vim.api.nvim_echo({ { prompt, "Input" } }, true, {})
	local char = vim.fn.getcharstr()
	-- That's the escape character (<Esc>). Not sure how to specify it smarter
	-- In other words, if you pressed escape, we return nil
	if char == '' then
		char = nil
	end
	return char
end

local function validate_register(register)
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

local function escapeForLiteralSearch(input)
	input = string.gsub(input, '\\', '\\\\')
	input = string.gsub(input, '/', '\\/')
	return input
end

function Search_for_selection(search_operator)
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = escapeForLiteralSearch(vim.fn.getreg('"'))
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



function EscapeFromLiteralSearch(input)
	if string.sub(input, 1, 2) ~= "\\V" then return input end
	input = string.sub(input, 3)
	input = string.gsub(input, '\\/', '/')
	input = string.gsub(input, '\\\\', '\\')
	return input
end

function Literal_search(searchOperator)
	local escaped_text = escapeForLiteralSearch(vim.fn.input("Type in your literal search: "))
	if escaped_text == '' then
		return
	end
	FeedKeys(searchOperator .. '\\V' .. escaped_text)
	FeedKeysInt("<cr>")
end

vim.keymap.set("", "/", "<cmd>lua Literal_search('/')<cr>")
vim.keymap.set("", "?", "<cmd>lua Literal_search('?')<cr>")

function Search_for_register(search_operator)
	local char = getChar("Input register key to search for:")
	if not char then return end
	local register = validate_register(char)
	local escaped_register = escapeForLiteralSearch(vim.fn.getreg(register))
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
