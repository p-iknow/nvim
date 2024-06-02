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
## ESC로 한영변환 하는법 
```zsh
# MAC키 변환 App
# https://karabiner-elements.pqrs.org/
brew install --cask karabiner-elements
```
![image](https://github.com/p-iknow/nvim/assets/35516239/ea277fe1-afa9-4596-b3bd-4be3ccf1b3b9)

![image](https://github.com/p-iknow/nvim/assets/35516239/2ad8a280-99bd-46ba-a045-221d5291ec46)

[검색결과 링크](https://ke-complex-modifications.pqrs.org/?q=for%20vim%20user%20esc%20to%20en_US%2FABC)

![image](https://github.com/p-iknow/nvim/assets/35516239/62db9e33-ca16-4c36-835c-3e5ac68d3815)
![image](https://github.com/p-iknow/nvim/assets/35516239/ff44ee91-a208-4963-8f7e-112464adb5ea)
![image](https://github.com/p-iknow/nvim/assets/35516239/deb774fb-eff3-4157-a984-c8d2f0b2cc81)
![image](https://github.com/p-iknow/nvim/assets/35516239/6d46ba6d-2059-4275-820e-3a4961ecded6)

![image](https://github.com/p-iknow/nvim/assets/35516239/745fb1c0-f6ac-4c4c-97b3-f2b8a01f801a)
