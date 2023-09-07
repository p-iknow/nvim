--- Plugins: VimPlug
--:PlugInstall: .vimrc 또는 init.vim에 지정된 모든 플러그인들을 설치합니다.
--:PlugUpdate: 모든 플러그인을 최신 상태로 업데이트합니다.
--:PlugUpgrade: Vim-plug 자체를 최신 상태로 업데이트합니다.
--:PlugClean: .vimrc 또는 init.vim에서 더 이상 참조하지 않는 플러그인들을 제거합니다.
--:PlugStatus: 설치된 플러그인들의 상태를 확인합니다.
--:PlugDiff: 마지막 :PlugUpdate 명령 이후 변경된 내용을 볼 수 있습니다.
--:PlugSnapshot: 현재 플러그인의 상태를 스냅샷 파일로 저장합니다. 이 파일은 나중에 vim -S <파일명>으로 복구할 수 있습니다.
local Plug = vim.fn['plug#']
vim.call("plug#begin")
-- https://github.com/tpope/vim-repeat
Plug("tpope/vim-repeat")
-- https://github.com/sheerun/vim-polyglot language pack
Plug("sheerun/vim-polyglot")
-- https://github.com/kana/vim-textobj-user
Plug("kana/vim-textobj-user")
-- https://github.com/kana/vim-textobj-entire
-- vae vie
Plug("kana/vim-textobj-entire")
-- https://github.com/kana/vim-textobj-line/blob/master/doc/textobj-line.txt
-- val vil
Plug("kana/vim-textobj-line")
--https://github.com/inside/vim-textobj-jsxattr
-- vix vax tag attriube
Plug 'inside/vim-textobj-jsxattr'
--https://github.com/beloglazov/vim-textobj-punctuation
-- viu vau select to punctuation
Plug 'beloglazov/vim-textobj-punctuation'
--https://github.com/vimtaku/vim-textobj-keyvalue/blob/master/doc/textobj-key-value.txt
-- vik vaK viv viV select to key value
Plug 'vimtaku/vim-textobj-keyvalue'
-- vscode neovim 에서 제대로 작동하지 않음
-- https://github.com/michaeljsmith/vim-indent-object
--Plug("michaeljsmith/vim-indent-object")
Plug("vim-scripts/ReplaceWithRegister")
--https://github.com/wellle/targets.vim
-- 학습 필요
Plug("wellle/targets.vim")
-- https://github.com/nvim-treesitter/nvim-treesitter
--Plug ('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})
vim.call("plug#end")


--- Plugins: Packer
--:PackerInstall: 플러그인 설치
--:PackerUpdate: 모든 플러그인 업데이트
--:PackerSync: 필요한 플러그인을 설치하고 더 이상 필요하지 않은 플러그인을 제거
--:PackerClean: init.lua에서 제거된 플러그인 삭제
require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
	use "savq/melange"
	use "sainnhe/everforest"
	use "sainnhe/edge"
	use "sainnhe/gruvbox-material"
	use "jacoborus/tender.vim"
	use "ap/vim-css-color"
	use "farmergreg/vim-lastplace"
	use 'ggandor/lightspeed.nvim'
	use 'thinca/vim-textobj-function-javascript'
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	})
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true }
	}
end)


vim.cmd("hi LightspeedCursor gui=reverse")
