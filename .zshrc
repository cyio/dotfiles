# public config
# ulimit -Sn 4096
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_LS_COLORS="true"
eval "$(fasd --init auto)"
plugins=(git tmux)
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
# source $HOME/.zsh-plugins/antigen.zsh
# antigen bundle fteem/git-semantic-commits
# antigen apply

export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/local/jdk/bin
export PATH=$PATH:$HOME/.npm-packages/bin:$HOME/.yarn/bin
export ANDROID_HOME=/usr/local/share/android-sdk
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools:$PATH
export NDK_HOME=/usr/local/share/android-ndk
export PATH=$NDK_HOME:$PATH

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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export HOMEBREW_NO_AUTO_UPDATE=1

# added by travis gem
[ -f /Users/oaker/.travis/travis.sh ] && source /Users/oaker/.travis/travis.sh
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

# Install zsh-async if it’s not present
if [[ ! -a ~/.zsh-async ]]; then
  git clone git@github.com:mafredri/zsh-async.git ~/.zsh-async
fi
source ~/.zsh-async/async.zsh

export NVM_DIR="$HOME/.nvm"
function load_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

# Initialize worker
async_start_worker nvm_worker -n
async_register_callback nvm_worker load_nvm
async_job nvm_worker sleep 0.1
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
