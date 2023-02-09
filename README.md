# vim, neovim and bash settings for Ubuntu (20.04, focal)
# neovim install
```
sudo snap install --beta nvim --classic
cp -r nvim ~/.config/nvim
sudo apt-get install autojump
```

for debian based systems (ubuntu):
```
echo "source /usr/share/autojump/autojump.sh" >> ~/.bashrc 
source ~/.bashrc
```

download vim-plug

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

download telescope dependencies:

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


