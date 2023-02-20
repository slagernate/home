# vim, neovim and bash settings for Ubuntu (tested on 20.04/focal and 22.04/jammy)

# vim and bash setup
```
cd home
cp .vimrc .bashrc ../
```

### install [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) 
# snap
```
sudo snap install --beta nvim --classic 
```
# apt-get
```
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt upgrade
sudo apt-get install neovim
```

```
cp -r nvim ~/.config/nvim
```

install [vim-plug](https://github.com/junegunn/vim-plug):
```
sudo apt-get install curl
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

download telescope (fast text search) dependencies:

```
sudo apt-get install ripgrep
sudo apt-get install fd-find
```

open a neovim session and run `:PlugInstall` within it
```
nvim ~/.config/nvim/init.vim
:PlugInstall
```
Run `:checkhealth telescope` for example to verify everything is OK
```
sudo snap install --classic node
```

test it out
```
n ~/.vimrc
```

### autojump 
for debian based systems (ubuntu):
```
sudo apt-get install autojump
echo "source /usr/share/autojump/autojump.sh" >> ~/.bashrc 
source ~/.bashrc
```
