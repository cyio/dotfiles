# public config
source ~/.alias.zsh
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_LS_COLORS="true"
plugins=(git tmux git-flow-completion autojump ssh-agent)
DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# percol
function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

export PATH=usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/local/jdk/bin:$PATH
export PATH=$PATH:~/.npm-packages/bin:~/.yarn/bin

# computer config
export PATH=$PATH:~/d/cyio/android-studio/bin:~/d/cyio/android/sdk/platform-tools
export ANDROID_HOME=/media/d/cyio/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools

