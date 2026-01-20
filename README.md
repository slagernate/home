
# VIM and Bash setup
```
cd home
cp .vimrc .bashrc ~
```

# Dependencies:
```
sudo apt install clangd python3-pylsp -y
```

# Neovim Setup
### manual (recommended)
```
# neovim dependencies
sudo apt-get install ninja-build gettext cmake unzip curl
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout v0.11.0  # list versions with: git tag -l "v*" | sort -V | tail -20
sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```
### snap
```
sudo snap install --beta nvim --classic 
```
### apt-get
```
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt upgrade
sudo apt-get install neovim
pip[3] install pynvim
sudo apt-get install xsel
```

```
cp -r nvim ~/.config/nvim
```

install [vim-plug](https://github.com/junegunn/vim-plug):
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

download telescope (fast text search) dependencies:

```
sudo apt-get install ripgrep fd-find -y
```

open a neovim session and run `:PlugInstall` within it
```
nvim ~/.config/nvim/init.vim
:PlugInstall
```
Run `:checkhealth telescope` for example to verify everything is OK

Install node
```
# For Ubuntu 20.04 (Focal)
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo apt-get update
sudo apt-get install nodejs
```

Copilot:
```
sudo apt install npm
npm install n -g # sudo possibly required
unalias n
n stable # sudo possibly required
alias n='nvim'
```
run
```
n ~/.vimrc
:Copilot setup
```
If copilot cannot open browser, go directly to: http://github.com/login/device

# AUTOJUMP 
for debian based systems (ubuntu):
```
sudo apt-get install autojump
echo "source /usr/share/autojump/autojump.sh" >> ~/.bashrc 
source ~/.bashrc
```

#  
### Disclaimer: vim, neovim and bash settings for Ubuntu (tested on 20.04/focal, 22.04/jammy, and 24.04/noble)
