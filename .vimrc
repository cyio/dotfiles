" vim: fdm=marker foldenable sw=4 ts=4 sts=4
" "zo" to open folds, "zc" to close, "zn" to disable.

" {{{ Alias and Snippets
iabbrev cls console.log('')

" Create a new HTML document.
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a
" }}}

" {{{ Keymaps

" {{{ hardcore mode
" inoremap <esc> <nop>
" inoremap <left> <nop>
inoremap jk <esc>
" }}}

" edit my vimrc
nnoremap <leader>ev :tabnew $MYVIMRC<cr>

" source my vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" leader
map <SPACE> <leader>

" fix whitespace
nnoremap <F4> :retab<CR>:%s/\s\+$//e<CR><C-o>

" fix syntax hilighting
nnoremap <F3> :syn sync fromstart<CR>

" move the current line below
nnoremap <leader>- ddp

" move the current line above
nnoremap <leader>_ ddkP

" switch tab
nnoremap <S-right> :tabn<CR>
nnoremap <S-left> :tabp<CR>

" node
noremap <leader>e <Esc>:AsyncRun -save=1 node --harmony %<CR>

" open new tab
nnoremap <leader>t :tabnew<CR>
" sudo
cmap w!! %!sudo tee > /dev/null % 
" save
nnoremap <leader>w :w<CR>
" copy paste
nmap <Leader>p :set paste<CR>"+]p:set nopaste<CR>
nmap <Leader>P :set paste<CR>"+]P:set nopaste<CR>
vmap <Leader>y "+y
vmap <Leader>Y "+Y

" insert mode uppercase the current word
"  <esc> : go to normal mode
"  v 	 : visual mode
"  iw 	 : select the current word
"  U 	 : uppercase selection
"  i 	 : back to insert mode
inoremap <c-u> <esc>viwUi

" remove last search highlight
nnoremap <C-l> :nohlsearch<CR><C-l>

" Wrap a word in double quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" Wrap a word in single quotes
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" select inside parents
onoremap in( :<c-u>normal! f(vi(<cr>

" select inside braces
onoremap in{ :<c-u>normal! f{vi{<cr>

" select inside brackets
onoremap in[ :<c-u>normal! f[vi[<cr>

"tabs
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" move lines up or down (command - D)
nmap <D-j> mz:m+<cr>`z
nmap <D-k> mz:m-2<cr>`z
vmap <D-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <D-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Tab move lines left or right (c-Ctrl,s-Shift)
" nmap    <c-tab>     v>
" nmap    <s-tab>     v<
" vmap    <c-tab>     >gv
" vmap    <s-tab>     <gv

" tab navigation like zsh
:nmap <leader>h :tabprevious<CR>
:map <leader>h :tabprevious<CR>
:imap <leader>h <Esc>:tabprevious<CR>i

:nmap <leader>l :tabnext<CR>
:map <leader>l :tabnext<CR>
:imap <leader>l <Esc>:tabnext<CR>i

" settings for resize splitted window
nmap w[ :vertical resize -3<CR>
nmap w] :vertical resize +3<CR>

nmap w- :resize -3<CR>
nmap w= :resize +3<CR>

" use in  edit
imap <C-A> <C-C><c-p>

" }}}

" {{{ Search and Completion

" grep ignore
set wildignore+=*/.git/*,*/tmp/*,*.swp

"improve autocomplete menu color
"highlight Pmenu ctermbg=238 gui=bold

"auto completed
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
" }}}
"
" {{{ Plugins and Settings
" Configuration section of plug
filetype off  " required!

call plug#begin('~/.vim/plugged')

" My Plugins here:
" {{{ react
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0
" }}}
" {{{ ultisnips
Plug 'SirVer/ultisnips'
" let g:UltiSnipsSnippetsDir='~/UltiSnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-tab>"

Plug 'letientai299/vim-react-snippets', { 'branch': 'es6' }
Plug 'honza/vim-snippets'
" }}}
Plug 'tpope/vim-unimpaired'
Plug 'vimcn/vimcdoc'
Plug 'skywind3000/asyncrun.vim'
" {{{ vue syntax
" Plug 'posva/vim-vue'
" Plug 'ellisonleao/vim-polyglot'
" let g:vue_disable_pre_processors=1
" }}}
Plug 'rhysd/vim-gfm-syntax'
Plug 'mzlogin/vim-markdown-toc'
Plug 'ajh17/VimCompletesMe'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
if !has("macunix")
    Plug 'lilydjwg/fcitx.vim'
endif
Plug 'digitaltoad/vim-pug'
Plug 'mileszs/ack.vim'
" {{{ emmet
Plug 'mattn/emmet-vim'
"imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" }}}
" {{{ supertab
Plug 'ervandew/supertab'
let g:SuperTabRetainCompletionType="context"
" }}}
" {{{ nerdtree
Plug 'scrooloose/nerdtree'
"  映射NERDTree插件
:map <leader>n :NERDTree<CR>
"let loaded_nerd_tree=1
let NERDChristmasTree=1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeWinSize = 32
" map <leader>f :NERDTreeToggle<CR>
" }}}
" {{{ nerdcommenter 
Plug 'scrooloose/nerdcommenter'

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" comment depending on the region of the .vue file
let g:ft = ''
fu! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        let syn = tolower(syn)
        exe 'setf '.syn
      endif
    endif
  endif
endfu
fu! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    g:ft
  endif
endfu
" }}}
" {{{ tagbar 
"Plug 'majutsushi/tagbar'

map <leader>g :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds' : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin' : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
" }}}
Plug 'vim-scripts/xml.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'flazz/vim-colorschemes'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"Plug 'bling/vim-airline'
" {{{ easymotion
"Plug 'Lokaltog/vim-easymotion'

" Settings for vim-easymotion
let g:EasyMotion_leader_key = ","
" }}}
"Plug 'TimothyYe/vim-tips'
"Plug 'Shougo/neocomplete'
Plug 'vim-scripts/wildfire.vim'
" {{{ indent guide
" Plug 'nathanaelkane/vim-indent-guides'
" indent 默认不显示，按 i 显示
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
":nmap <silent> <Leader>i <Plug>IndentGuidesToggle
" }}}
" {{{ indentline 
Plug 'Yggdroot/indentLine'
map <leader>il :IndentLinesToggle<CR>
" let g:indentLine_char = '┊'
"let g:indentLine_color_term = 0 
let g:indentLine_noConcealCursor=""
" }}}
"Plug 'yonchu/accelerated-smooth-scroll'
"Plug 'ianva/vim-youdao-translater'
" {{{ tern
Plug 'marijnh/tern_for_vim'

let tern_show_signature_in_pum = 1
let g:tern_map_keys=1
let tern_show_argument_hints = 'on_hold'
autocmd FileType javascript setlocal omnifunc=tern#Complete
" }}}
Plug 'elixir-lang/vim-elixir'
"Plug 'Valloric/YouCompleteMe'
Plug 'maksimr/vim-jsbeautify'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript'
let g:used_javascript_libs = 'jquery, underscore, vue'
" {{{ vim-prettier
Plug 'mitermayer/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
nmap <Leader>pr <Plug>(Prettier)
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#semi = 'false'
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync
" }}}
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'HerringtonDarkholme/yats.vim'
" {{{ vim-json
Plug 'elzr/vim-json'

" vim json disable conceal for json 
let g:vim_json_syntax_conceal = 0
" }}}
"support markdown
Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
Plug 'irrationalistic/vim-tasks'
" {{{ devdocs.io
Plug 'rhysd/devdocs.vim'
nmap K <Plug>(devdocs-under-cursor)
" :DD
" :DD Map
" :DD scss @mixin
" setlocal keywordprg=:DD
let url = "open 'http://devdocs.io/?q="
command! -nargs=* DD silent! call system(len(split(<q-args>, ' ')) == 0 ?
			\ url . &ft . ' ' . expand('<cword>') . "'" : len(split(<q-args>, ' ')) == 1 ?
			\ url . &ft . ' ' . <q-args> . "'" : url . <q-args> . "'")
" }}}
" {{{ zeal
Plug 'KabbAmine/zeavim.vim', {'on': [
			\	'Zeavim', 'Docset',
			\	'<Plug>Zeavim',
			\	'<Plug>ZVVisSelection',
			\	'<Plug>ZVKeyDocset',
			\	'<Plug>ZVMotion'
			\ ]}
nmap gZ <Plug>ZVKeyDocset
" }}}
" {{{ LeaderF
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
let g:Lf_ShortcutF = '<C-P>'
" }}}

call plug#end()
filetype plugin indent on     " required!
 " End of plug configuration

colorscheme PaperColor
"colorscheme mango
"let g:hybrid_use_iTerm_colors = 1
"colorscheme hybrid
 
"For ack code search
"let g:ackprg = 'ag --nogroup --nocolor --column'
if executable("rg")
  let g:ackprg = 'rg --vimgrep --no-heading'
  let g:CtrlSpaceGlobCommand = 'rg -g ""'
elseif executable("ag")
  let g:ackprg = 'ag --vimgrep --smart-case'
  let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
cnoreabbrev rg Ack
cnoreabbrev rG Ack
cnoreabbrev Rg Ack
cnoreabbrev RG Ack

" language format
" autocmd FileType javascript set formatprg=prettier\ --stdin\ --parser\ flow\ --single-quote\ --trailing-comma\ es5
" autocmd BufWritePre *.js :normal gggqG
" autocmd BufWritePre,TextChanged,InsertLeave *.js :normal gggqG

" }}}

" {{{ File / Explorer
set bsdir=buffer " 设定文件浏览器目录为当前目录
"autocmd BufEnter * lcd %:p:h "打开文件时改变path
" 切换当前环境工作目录为已打开文件所在目录
map <leader>cd :lcd %:h<CR>
" open files always in new tabs
"autocmd VimEnter * tab all
"autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'

if has('unix')
  if has('mac')
    map <leader>tp :!/usr/bin/open -a typora %<CR>
  else
    map <leader>tp :!/usr/bin/xdg-open %<CR>
  endif
elseif has('win32') || has('win64')
  " set guifont=...
endif

" }}}
"
" {{{ Encoding / Basic

" for mac
set clipboard=unnamed

" 设置编码
set encoding=utf-8
set nocompatible
set laststatus=2
" 设置文件编码
set fenc=utf-8

" 设置文件编码检测类型及支持格式
set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

"显示行号
set number
"Show related row numbers
set relativenumber

"indent
set smartindent
set autoindent
set copyindent

"忽略大小写查找
set ic

" tab宽度
set cindent shiftwidth=2
set autoindent shiftwidth=2
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab smarttab
"vim 换行时不切断单词
set linebreak

" set 折叠
set foldmethod=indent
" 打开文件默认不折叠
set foldlevelstart=99

" 高亮多余的空白字符及 Tab
"highlight RedundantSpaces ctermbg=red guibg=red
"match RedundantSpaces /\s\+$\| \+\ze\t\|\t/
set listchars=tab:——,trail:⋅,nbsp:⋅

"文件系统跟编码
set encoding=utf8
set ffs=unix,mac

" For clever completion with the :find command
set path+=**

" Typing behavior
set backspace=2
set backspace=indent,eol,start
set showmatch
set wildmode=full
set wildmenu
set complete-=i
" }}}

" {{{ Syntax highlighting

syntax on
set background=dark
set t_Co=256
set autoread
set nobackup
set nowritebackup
set noswapfile

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
"支持vue高亮
autocmd BufRead,BufNewFile *.vue setlocal filetype=javascript
" autocmd FileType vue syntax sync fromstart
autocmd BufNewFile,BufRead *.wpy set filetype=html
" }}}
