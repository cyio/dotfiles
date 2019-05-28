# public config
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_LS_COLORS="true"
eval "$(fasd --init auto)"
plugins=(git tmux ssh-agent)
DISABLE_AUTO_UPDATE="true"
export TERM="xterm-256color"
source $ZSH/oh-my-zsh.sh
source ~/.alias.zsh

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

	function ppgrep() {
		if [[ $1 == "" ]]; then
			PERCOL=percol
		else
			PERCOL="percol --query $1"
		fi
		ps aux | eval $PERCOL | awk '{ print $2 }'
	}

	function ppkill() {
		if [[ $1 =~ "^-" ]]; then
			QUERY=""            # options only
		else
			QUERY=$1            # with a query
			[[ $# > 0 ]] && shift
		fi
		ppgrep $QUERY | xargs kill $*
	}
fi

# antigen
source $HOME/.zsh-plugins/antigen.zsh
antigen bundle fteem/git-semantic-commits
antigen apply

export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/local/jdk/bin
export PATH=$PATH:$HOME/.npm-packages/bin:$HOME/.yarn/bin

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

# Enable Ctrl-x-Ctrl-e to edit command line
autoload -U edit-command-line
# Vi style:
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# computer config
