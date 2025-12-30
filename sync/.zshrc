# X11 disable beeping
xset b off

# store the command history forever 
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

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
# pnpm end
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

# bun completions
[ -s "/home/user/.bun/_bun" ] && source "/home/user/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


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
