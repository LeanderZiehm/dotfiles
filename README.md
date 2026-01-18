
# Vim
```
# Backup old config (if config existed before)
mv ~/.vimrc ~/.vimrc.backup.$(date +%Y%m%d%H%M%S)
# Install
curl -fsSL https://raw.githubusercontent.com/LeanderZiehm/dotfiles/main/sync/.vimrc -o ~/.vimrc

```


# Nvim
```
# Backup old config (if config existed before)
mv ~/.config/nvim/init.lua ~/.config/nvim/init.lua.backup.$(date +%Y%m%d%H%M%S)

# Setup (if never had config)
mkdir -p ~/.config/nvim

# Install
curl -fsSL https://raw.githubusercontent.com/LeanderZiehm/dotfiles/refs/heads/main/sync/.config/nvim/init.lua -o ~/.config/nvim/init.lua
```

# Tmux

```


# Install
curl -fsSL https://raw.githubusercontent.com/LeanderZiehm/dotfiles/refs/heads/main/sync/.tmux.conf -o ~/.tmux.conf

```
