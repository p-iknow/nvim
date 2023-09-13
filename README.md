## Neovim Install 
- [neovim 설치](https://github.com/neovim/neovim/wiki/Installing-Neovim#homebrew-on-macos-or-linux) 
- [neovim vscode extension 설치](https://github.com/vscode-neovim/vscode-neovim)
- ^ 설치 https://github.com/vscode-neovim/vscode-neovim#-getting-started 가이드에 따라 vscode 설정 꼭 할 것 
- `/Users/${userName}/.config/nvim` 에  `https://github.com/p-iknow/nvim`(neovim 세팅) clone 하기  


## How To Init

```bash
##  nvim 폴더 이동
cd ~/.config/nvim 
## vim을 open
vi
```

```vim
<!--vim command 명령어,  Vimplug 패키지관리 메니저로 설정한 플러그인 설치 .vimrc 또는 init.vim에 지정된 모든 플러그인들을 설치합니다.-->
:PlugInstall 
<!--vim command 명령어, Packer 패키지 관리 메니저로 설정한 플러그인 설치 .vimrc 또는 init.vim에 지정된 모든 플러그인들을 설치합니다.-->
:PackerInstall  
```