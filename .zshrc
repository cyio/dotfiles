# public config
source ~/.alias.zsh
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_LS_COLORS="true"
plugins=(git tmux git-flow-completion autojump ssh-agent)
DISABLE_AUTO_UPDATE="true"
export TERM="xterm-256color"
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

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/local/jdk/bin:$PATH
export PATH=$PATH:~/.npm-packages/bin:~/.yarn/bin

# history setting
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# 不保留重复的历史记录项
setopt hist_ignore_all_dups
# 在命令前添加空格，不将此命令添加到记录文件中
setopt hist_ignore_space
setopt hist_fcntl_lock 2>/dev/null
setopt hist_reduce_blanks
setopt SHARE_HISTORY

# computer config

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
