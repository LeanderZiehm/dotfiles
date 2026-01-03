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
alias slides="vim ~/dev/repos/00_active-repos/presentation-artificial-intelligence/slides.md"
# Notes setup

export NOTES_ROOT=~/dev/notes

alias sync-notes="cd $NOTES_ROOT && git add . && git commit -m 'sync' && git push"

alias todo="vim $NOTES_ROOT/todo/todo.md"
alias notes="vim $NOTES_ROOT/notes/notes.md"
alias wiki="vim $NOTES_ROOT/wiki/index.md"

# --------------------
# Journal function with embedded template
journal() {
  local NOTES_DIR="$NOTES_ROOT/journal"
  local TS="$(date '+%Y-%m-%d_%H%M')"
  local DATE="$(date '+%Y-%m-%d')"
  local FILE="$NOTES_DIR/$TS.md"

  mkdir -p "$NOTES_DIR"

  cat > "$FILE" <<EOF
# Journal — $DATE

## Context
- Location:
- Mood:
- Focus:

## Notes

## Reflection
EOF

  vim "$FILE"
}

# --------------------
# Idea function with embedded template
idea() {
  local NOTES_DIR="$NOTES_ROOT/ideas"
  local TS="$(date '+%Y-%m-%d %H:%M:%S')"
  local ID="$(date +%s)-$(openssl rand -hex 2)"
  local FILE="$NOTES_DIR/$ID.md"

  mkdir -p "$NOTES_DIR"

  cat > "$FILE" <<EOF
---
id: $ID
created: $TS
tags: []
---

# $ID

## Idea

## Links
- 
EOF

  vim "$FILE"
}



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

local projects=(~/dotfiles ~/dev/wiki)

#fp() {
    #local selection
    # Flatten the directories into a list of files
    #selection=$(find "${projects[@]}" -maxdepth 0 -type d | sed "s|^$HOME|~|"  | fzf --exact --ignore-case --query="$1") || return
    #code "$selection"
#}
fp() {
    local selection
    selection=$(printf "%s\n" "${projects[@]}" | sed "s|^$HOME|~|" |  fzf --exact --ignore-case --query="$1") || return
    code "$selection"

}




du_top10() {
    local TARGET="/home/user"
    local EXCLUDES="--exclude=.git --exclude=.venv"

    echo "Top 10 largest files in $TARGET"
    du -ah $TARGET $EXCLUDES 2>/dev/null \
        | grep -v '/$' \
        | sort -hr \
        | head -n 10

    echo
    echo "Top 10 largest directories in $TARGET"
    du -h --max-depth=1 $TARGET $EXCLUDES 2>/dev/null \
        | sort -hr \
        | head -n 10
}

serve_clipboard_live() {
    host_dir="$HOME/host-clipboard"
    mkdir -p "$host_dir"                   # ensure folder exists
    tmpfile="$host_dir/clipboard.html"     # file to write clipboard
    port=3214

    # Check wl-paste exists
    if ! command -v wl-paste &>/dev/null; then
        echo "wl-paste not found. Install wl-clipboard."
        return 1
    fi

    # Initial write
    wl-paste > "$tmpfile" || echo "" > "$tmpfile"

    # Start server in background, serving host_dir explicitly
    # Do NOT redirect errors while debugging
    python3 -m http.server $port -d "$host_dir" &
    server_pid=$!

    url="http://localhost:$port/clipboard.html"
    echo "Serving clipboard live at $url"

    # Give server a moment to start
    sleep 1
    xdg-open "$url" &>/dev/null

    prev=""
    trap 'kill $server_pid; echo "Server stopped."; exit' INT

    # Live update loop
    while true; do
        current=$(wl-paste || echo "")
        if [[ "$current" != "$prev" ]]; then
            echo "$current" > "$tmpfile"
            prev="$current"
        fi
        sleep 0.5
    done
}
