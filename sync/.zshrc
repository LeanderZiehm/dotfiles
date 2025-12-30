# X11 disable beeping
xset b off

# store the command history forever 
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

unsetopt autocd

# Oh My ZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Programming Languages 

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

# python miniconda
function conda-activate(){
source ~/miniconda3/bin/activate
}

# pnpm
export PNPM_HOME="/home/user/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


# ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# go 
export PATH="$HOME/go/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/home/user/.bun/_bun" ] && source "/home/user/.bun/_bun"


# PATH 

# PATH global bin for my scripts and cli tools
export PATH="$PATH:/home/user/.local/bin/"
export PATH="$PATH:/home/user/bin/"
export PATH="$HOME/bin:$PATH"

# commands 
export PATH="$HOME/bin/commands:$PATH"

# dotfiles sync
alias dotfiles='/home/user/dotfiles/dotfiles.sh'













# CLI tools
eval "$(zoxide init zsh)"


# pacman
alias pacman-ophins-list="pacman -Qtdq"
alias pacman-ophins-remove="sudo pacman -Rns $(pacman -Qtdq)"
alias pacman-installed="pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{size=$4} END{print name,size}' | sort -nrk2"


# vi mode (vim lite)
#bindkey -v
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
export EDITOR=vim

### NVIM

#alias nvim-chad="NVIM_APPNAME=NvChad nvim"
#alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

alias lvim="NVIM_APPNAME=LazyVim nvim"
alias svim="NVIM_APPNAME=SlimNvim nvim"

function nvims() {
  items=("LazyVim" "NvChad" "AstroNvim" "SlimNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

#bindkey -s ^a "nvims\n"

alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"

alias todo="vim ~/dev/todo/todo.md"
alias notes="vim ~/dev/notes/notes.md"
alias wiki="vim ~/dev/wiki/index.md"

ff_find_files() {
    local dirs=(~/dev ~/.config)
    find "${dirs[@]}" \
        \( -name "node_modules" -o -name ".git" -o -name ".venv" \
           -o -name "*.png" -o -name "*.jpg" -o -name "*.svg" -o -name "*.webp" -o -name "*.gif" -o -name "*.ico" \
           -o -name "*.ttf" -o -name "*.woff" -o -name "*.woff2" -o -name "*.pfb" -o -name "*.hyb" -o -name "*.bcmap" \
           -o -name "*.class" -o -name "*.so" -o -name "*.jar" -o -name "*.pyc" -o -name "*.tflite" -o -name "*.tgz" \
           -o -path "*/leveldb/*" -o -name "*.dat" -o -name "*.lock" -o -name "*.db" -o -name "*.syms" -o -path "*/dist-info/*" -o -name "*.old" -o -name "*.map" \
        \) -prune -o -type f -print 2>/dev/null | sed "s|^$HOME|~|"
}

fd_find_dirs_deep() {
    local dirs=(~/dev ~/.config)
    find "${dirs[@]}" \
        \( -name "node_modules" -o -name ".git" -o -name ".venv" -o -name "lib"  \
           -o -path "*/leveldb/*" -o -path "*/dist-info/*" \
        \) -prune -o -type d -print 2>/dev/null | sed "s|^$HOME|~|"


}

ff_find_dirs_one_level() {
    local dirs=(~/dev ~/.config)
    find "${dirs[@]}" -maxdepth 1 \
        \( -name "node_modules" -o -name ".git" -o -name ".venv" \
           -o -path "*/leveldb/*" -o -path "*/dist-info/*" \
        \) -prune -o -type d -print 2>/dev/null | sed "s|^$HOME|~|"
}


ff() {
    local file
    file=$(ff_find_files | fzf --exact --ignore-case --query="$1") || return
    vim "$file"
}

fd() {
    local dir
    dir=$(ff_find_dirs_one_level | fzf --exact --ignore-case --query="$1") || return
    vim "$dir"
}


ff_stats() {
    ff_find_files | awk -F. 'NF>1 {ext[tolower($NF)]++} END {for (e in ext) if (ext[e]>10) print ext[e], e}' | sort -n
}

replaceHomeWithWaves(){
     sed "s|^$HOME|~|"
}

local projects=(~/dev/todo ~/dev/notes)

fp() {
    local selection
    # Flatten the directories into a list of files
    selection=$(find "${projects[@]}" -maxdepth 0 -type d | sed "s|^$HOME|~|"  | fzf --exact --ignore-case --query="$1") || return
    vim "$selection"
}







