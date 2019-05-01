alias termnot='terminal-notifier -message "Done" -title "Done"'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias byt='bytewiser'
alias dt='date --rfc-3339="date"'
alias v='vim'
alias z='cd'
alias pc='percol'
alias px='proxychains'
alias hig='history|grep'
alias goo='proxychains googler -l zh --colors bjdxxy' 
alias typ='/usr/bin/open -a typora'
alias h2p='pbpaste|html2jade --bodyless -|pbcopy'
# alias vim="nvim"
# mosh
alias spc='mosh oaker@192.168.1.143'
alias smb='mosh --ssh="ssh -p 8022" u0_a78@192.168.1.233'
alias p='ALL_PROXY=http://127.0.0.1:8787'
alias x='ALL_PROXY=socks5://127.0.0.1:1080'
alias t='trans -b -t en'
alias aria='aria2c'
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
function lazygit() {
  git add .
  git commit -a -m "$1"
  git push
}

# npm script shortcuts
alias t="yarn test"
alias tu="yarn test:unit"
alias te="yarn test:e2e"
alias b="yarn build"
alias d="yarn dev"
alias s="yarn serve"
alias dt="yarn dev:test"
alias ds="yarn dev:ssr"
alias nr="yarn"
