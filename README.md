# dotfiles
## Install onto a new system  
1. Clone: `git clone --bare https://github.com/kogonia/dotfiles.git $HOME/.cfg`  
2. Define the alias: `alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`  
3. Checkout the actual content from the bare repository to your $HOME: `config checkout`  

If you have error on the last step, move somewhere all of existings (default) dotfiles like this:
```
mkdir -p .config-backup && \  
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \  
xargs -I{} mv {} .config-backup/{}  
```
and try again `config checkout`  
