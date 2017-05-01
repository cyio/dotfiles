alias termnot='terminal-notifier -message "Done" -title "Done"'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias byt='bytewiser'
alias dt='date --rfc-3339="date"'
alias v='vim'
alias z='cd'
alias pc='percol'
alias px='proxychains4'
alias hig='history|grep'
alias goo='proxychains googler -l zh --colors bjdxxy' 
alias typ='/usr/bin/open -a typora'
# alias vim="nvim"
# mosh
alias spc='mosh oaker@192.168.1.143'
alias smb='mosh --ssh="ssh -p 8022" u0_a78@192.168.1.233'
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
function lazygit() {
  git add .
  git commit -a -m "$1"
  git push
}
