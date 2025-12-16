export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"


function conda-activate(){
source ~/miniconda3/bin/activate
}

alias dotfiles='/home/user/dotfiles/dotfiles.sh'

xset b off

# PATH 
export PATH="$PATH:/home/user/.local/bin/"
export PATH="$PATH:/home/user/bin/"

# store the command history forever 
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
export PATH="$HOME/bin:$PATH"

# pnpm
export PNPM_HOME="/home/user/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
pac() {
    case "$1" in
        install)
            shift
            sudo pacman -S "$@"
            ;;
        update)
            shift
            sudo pacman -Syu "$@"
            ;;
        remove)
            shift
            sudo pacman -Rs "$@"
            ;;
        clean)
            sudo pacman -Rns $(pacman -Qtdq)
            ;;
        installed)
            shift
            # Default: explicitly installed packages
            if [[ "$1" == "--all" ]]; then
                pacman -Q
            elif [[ "$1" == "--count-all" ]]; then
                pacman -Q | wc -l
            elif [[ "$1" == "--count" ]]; then
                pacman -Qe | wc -l
            elif [[ "$1" == "--desc" ]]; then
                pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{size=$4} END{print name,size}' | sort -nrk2
                # More reliable: we'll fix below
            else
                pacman -Qe
            fi
            ;;
        *)
            echo "pac usage:"
            echo "  pac install <pkg>"
            echo "  pac update"
            echo "  pac remove <pkg>"
            echo "  pac clean"
            echo "  pac installed [--all|--count|--desc]"
            ;;
    esac
}




#export PATH="/home/user/.local/share/gem/ruby/3.4.0/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

#export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$HOME/go/bin:$PATH"

export PATH="$HOME/bin/commands:$PATH"
