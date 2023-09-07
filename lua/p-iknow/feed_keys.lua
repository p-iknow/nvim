-- `FeedKeys` 함수는 주어진 `keys` 문자열을 Neovim에 "입력"으로 전달하는 역할을 합니다. 이 함수는 Neovim의 Lua API인 `vim.api.nvim_feedkeys`를 사용하여 이 작업을 수행합니다.

-- `vim.api.nvim_feedkeys` 함수의 각 인자에 대한 설명은 다음과 같습니다:
-- 1. **keys**: 입력하려는 키 또는 키 시퀀스를 나타내는 문자열입니다.
-- 2. **mode**: 입력 모드를 나타내는 문자열입니다. 여기서는 "n" (normal mode)으로 설정되어 있습니다.
-- 3. **escape_csi**: Boolean 값으로, 키 문자열 내의 특수 문자를 해석할지 여부를 결정합니다. 여기서는 `false`로 설정되어 있어 특수 문자를 그대로 전달합니다.
-- `FeedKeys` 함수를 사용하면, Lua 스크립트 내에서 Vim/Neovim의 키 명령을 프로그래밍 방식으로 "입력"할 수 있습니다.

-- 예를 들어, 다음과 같이 `FeedKeys` 함수를 호출하면:
-- ```lua
-- FeedKeys(":w<CR>")
-- ```
-- 이는 Neovim에서 `:w` 명령을 입력하고 Enter 키(`<CR>`)를 누른 것과 동일한 효과를 가집니다, 즉 현재 버퍼를 저장합니다.
function FeedKeys(keys)
	vim.api.nvim_feedkeys(keys, "n", false)
end

-- https://neovim.io/doc/user/api.html#nvim_replace_termcodes()
--이 줄에서 vim.api.nvim_replace_termcodes 함수를 호출하여 특정 키 코드를 실제 키 값으로 변환합니다. 이 함수는 Neovim API의 일부로, 키 코드를 해당 키의 실제 값으로 변환하는 데 사용됩니다.
-- nvim_replace_termcodes({str}, {from_part}, {do_lt}, {special}) Replaces terminal codes and keycodes (<CR>, <Esc>, ...) in a string with the internal representation.
-- Parameters:

-- {str}: keys, 변환할 키 코드 문자열입니다.
-- {from_part}: true Legacy Vim parameter. Usually true.
--  - from_part 파라미터는 Vim의 replace_termcodes() 함수에서 사용되는 것과 유사한 역할을 합니다. 이 파라미터는 주로 터미널 코드를 내부 코드로 변환할 때, 특정 키 코드가 다른 문자열의 일부로 해석되는 것을 방지하는 데 사용됩니다.
--  - 예를 들어, 사용자가 <Tab> 키 코드를 문자열의 일부로 사용하고 싶을 때 (예: Hello<Tab>World), from_part가 true로 설정되면 <Tab>은 탭 문자로 해석되지 않습니다. 대신 그대로 <Tab> 문자열로 남게 됩니다.
--  - 반면 from_part가 false로 설정되면, <Tab>은 실제 탭 문자로 변환될 수 있습니다.
--  - from_part 파라미터는 주로 키 매핑이나 명령어에서 키 코드를 문자열의 일부로 사용하고 싶을 때 유용합니다. 이를 통해 사용자는 키 코드를 명시적으로 문자열로 사용하거나 실제 키 값으로 변환하는 것을 선택할 수 있습니다.
--  - 대부분의 경우, 키 코드를 문자열의 일부로 사용하고 싶을 때 from_part를 true로 설정합니다. 따라서 "대체로 true로 설정됩니다."라는 표현이 사용되었습니다.
-- {do_lt}: false <...> 형식의 키 코드를 실제 키 값으로 변환합니다. 예를 들어, <CR>은 "Enter" 키를 나타냅니다..
-- {special}: true Replace keycodes, e.g. <CR> becomes a "\r" char. 키 코드를 변환할지 여부를 지정합니다. 예를 들어, <CR>은 "\r" 문자로 변환됩니다.

--  {do_lt} 과 {special} 의 관계
-- special: 이 파라미터가 true로 설정되면, 문자열 내의 키 코드들 (<CR>, <Esc>, 등)이 해당 키의 내부 표현값으로 변환됩니다. 만약 false로 설정되면, 키 코드 변환 기능이 비활성화됩니다.
-- do_lt: 이 파라미터는 <lt> 키 코드를 실제 < 기호로 변환할지 여부를 지정합니다. 그러나 이 파라미터의 설정은 special 파라미터가 true일 때만 유효합니다. 즉, special이 false인 경우 do_lt 설정은 무시됩니다.
-- 요약하면, special은 키 코드 변환 기능 전체를 제어하는 반면, do_lt는 특정 키 코드인 <lt>의 변환을 제어합니다. 그리고 do_lt의 동작은 special이 활성화되어 있을 때만 유효합니다.

function FeedKeysInt(keys)
	local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(feedable_keys, "n", true)
end

-- #사용사례
--### 1. 키 코드 변환 (`FeedKeysInt` 사용 사례)

-- **상황**: 사용자가 Neovim에서 특정 작업을 자동화하려고 합니다. 이 작업은 파일의 끝으로 이동한 다음, 새 줄을 추가하고 "Hello, World!"를 입력하는 것입니다.

-- **스크립트**:
--```lua
--FeedKeysInt("G<CR>oHello, World!")
--```
--여기서 `G`는 파일의 끝으로 이동, `<CR>`은 Enter 키, `o`는 새 줄을 추가하는 명령입니다. `FeedKeysInt` 함수는 이러한 키 코드를 실제 키 입력으로 변환하여 Neovim에 전달합니다.

--### 2. 직접 키 입력 시뮬레이션 (`FeedKeys` 사용 사례)

--**상황**: 사용자가 Neovim 플러그인을 개발 중입니다. 이 플러그인은 특정 키 조합을 감지하면 자동으로 다른 키 조합을 입력하도록 설계되었습니다. 예를 들어, 사용자가 `jj`를 빠르게 입력하면 Escape 키가 입력되도록 설정하려고 합니다.
--이 경우, 플러그인은 `jj`를 감지하면 실제 Escape 키 입력을 시뮬레이션해야 합니다.

--**스크립트**:
--```lua
---- 'jj'를 감지하는 로직 후
--FeedKeys("\x1b")  -- "\x1b"는 Escape 키의 ASCII 코드입니다.
--```
--이 예시에서는 `FeedKeys` 함수를 사용하여 직접 Escape 키 입력을 시뮬레이션합니다.
--이 두 예시는 `FeedKeys`와 `FeedKeysInt`의 주요 사용 사례를 보여줍니다. `FeedKeysInt`는 키 코드를 실제 키 입력으로 변환하는 반면, `FeedKeys`는 이미 변환된 키 값을 직접 시뮬레이션합니다.
