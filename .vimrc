" vim: fdm=marker foldenable sw=4 ts=4 sts=4
" "zo" to open folds, "zc" to close, "zn" to disable.
"Performance improvements
set synmaxcol=200 "Don't bother highlighting anything over 200 chars
let did_install_default_menus = 1 "No point loading gvim menu stuff
let loaded_matchparen = 1 "highlighting matching pairs so slow

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

" When vimrc is edited, reload it 当 .vimrc 被修改时，自动生效
autocmd! bufwritepost vimrc source ~/.vim_runtime/vimrc

" leader
map <SPACE> <leader>

" fix whitespace
nnoremap <F4> :retab<CR>:%s/\s\+$//e<CR><C-o>

" fix syntax hilightin, expc vue large file
nnoremap <F3> :syn sync fromstart<CR>

" move the current line below
nnoremap <leader>- ddp

" move the current line above
nnoremap <leader>_ ddkP

" switch tab
nnoremap <S-right> :tabn<CR>
nnoremap <S-left> :tabp<CR>

" node
" noremap <leader>e <Esc>:AsyncRun -save=1 node --harmony %<CR>
noremap <leader>e <Esc>:AsyncRun -save=1 deno run %<CR>

" C++
nnoremap <silent> <F9> :AsyncRun -save=1 g++ -O3 "%" -o "%<" -lpthread && $(VIM_FILEDIR)/$(VIM_FILENOEXT) <cr>
" nnoremap <silent> <F8> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" open new tab
nnoremap <leader>t :tabnew<CR>
" sudo
cmap w!! %!sudo tee > /dev/null % 
" save
" nnoremap <leader>w :w<CR>
" copy paste
" nmap <Leader>p :set paste<CR>"+]p:set nopaste<CR>
" nmap <Leader>P :set paste<CR>"+]P:set nopaste<CR>
" vmap <Leader>y "+y
" vmap <Leader>Y "+Y

" insert mode uppercase the current word
"  <esc> : go to normal mode
"  v 	 : visual mode
"  iw 	 : select the current word
"  U 	 : uppercase selection
"  i 	 : back to insert mode
inoremap <c-u> <esc>viwUi

set nohlsearch
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
" map <leader>tn :tabnew<cr>
" map <leader>te :tabedit
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove

" settings for resize splitted window
nmap w[ :vertical resize -3<CR>
nmap w] :vertical resize +3<CR>

nmap w- :resize -3<CR>
nmap w= :resize +3<CR>

" natural split window
set splitbelow
set splitright

" use in  edit
imap <C-A> <C-C><c-p>

" edit note index file
nnoremap <leader>ww :e ~/Projects/worknotes/src/index.md<cr>
nnoremap <leader>wb :e ~/Projects/Personal/cyio/docs/catalog.md<cr>
nnoremap <leader>wn :exe 'e life/'.strftime("%F.md")<cr>

" 切换最大化窗口，不丢失布局
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction
" }}}
if has('nvim')
  tnoremap <C-w>N <C-\><C-n>
  tnoremap <C-w>. <C-w>
endif

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
let g:UltiSnipsSnippetsDir='~/UltiSnips'
let g:UltiSnipsExpandTrigger = "<nop>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-e>"
let g:UltiSnipsEditSplit="vertical"

" Plug 'letientai299/vim-react-snippets', { 'branch': 'es6' }
Plug 'honza/vim-snippets'
" }}}

Plug 'tpope/vim-unimpaired'
" Plug 'vimcn/vimcdoc'
Plug 'skywind3000/asyncrun.vim'
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" {{{ vue syntax
Plug 'posva/vim-vue', { 'branch': 'performance-enhancement' }
" let g:vue_disable_pre_processors=1
" Plug 'ellisonleao/vim-polyglot' " slow for vue
" }}}
Plug 'Shougo/context_filetype.vim'
" Plug 'tyru/caw.vim'
Plug 'rhysd/vim-gfm-syntax'
Plug 'ajh17/VimCompletesMe'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
nnoremap <C-p> :<C-u>FZF<CR>
Plug 'junegunn/fzf.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
if !has("macunix")
    Plug 'lilydjwg/fcitx.vim'
endif
Plug 'digitaltoad/vim-pug'
" {{{ ctrlsf
" Plug 'dyng/ctrlsf.vim'
Plug 'dyng/ctrlsf.vim', { 'commit': '0c35992' }
if executable("rg")
    let g:ctrlsf_ackprg = 'rg'
elseif executable("ag")
    let g:ctrlsf_ackprg = 'ag'
endif
nnoremap <Leader>sp :CtrlSF<CR>
cnoreabbrev ag CtrlSF
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_auto_focus = {
	\ "at": "done",
	\ "duration_less_than": 1000
	\ }
let g:ctrlsf_mapping = {
    \ "next": "n",
    \ "prev": "N",
    \ }
let g:ctrlsf_extra_backend_args = {
    \ 'rg': ''
    \ }
" }}}
" {{{ emmet
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-Z>'
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" }}}
" {{{ nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
:map <leader>n :NERDTree<CR>
:map <leader>nf :NERDTreeFind<CR>
"let loaded_nerd_tree=1
let NERDChristmasTree=1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeWinSize=32
let NERDTreeShowBookmarks=1
let NERDTreeNodeDelimiter = "\t"
" map <leader>f :NERDTreeToggle<CR>
" }}}
" {{{ align / table
Plug 'junegunn/vim-easy-align', { 'for': 'markdown' }
" <leader>\ Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner='|'
" }}}
" {{{ nerdcommenter 
Plug 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" comment depending on the region of the .vue file
" let g:ft = ''
" fu! NERDCommenter_before()
  " if &ft == 'vue'
    " let g:ft = 'vue'
    " let stack = synstack(line('.'), col('.'))
    " if len(stack) > 0
      " let syn = synIDattr((stack)[0], 'name')
      " if len(syn) > 0
        " let syn = tolower(syn)
        " exe 'setf '.syn
      " endif
    " endif
  " endif
" endfu
" fu! NERDCommenter_after()
  " if g:ft == 'vue'
    " setf vue
    " g:ft
  " endif
" endfu
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
" Plug 'vim-scripts/xml.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
let g:session_autoload = 'no'
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
" let g:indent_guides_enable_on_vim_startup=0
" let g:indent_guides_start_level=2
" let g:indent_guides_guide_size=1
":nmap <silent> <Leader>i <Plug>IndentGuidesToggle
" }}}
" {{{ work indentline 
" Plug 'Yggdroot/indentLine'
" map <leader>il :IndentLinesToggle<CR>
" let g:indentLine_char = '┊'
" let g:indentLine_enabled = 1
" let g:indentLine_color_term = 100 
" let g:indentLine_noConcealCursor=""
" Let indentLine use current conceal options
" let g:indentLine_conceallevel=&conceallevel
" let g:indentLine_concealcursor=&concealcursor
" }}}
"Plug 'ianva/vim-youdao-translater'
" {{{ tern
" Plug 'marijnh/tern_for_vim'

" let tern_show_signature_in_pum = 1
" let g:tern_map_keys=1
" let tern_show_argument_hints = 'on_hold'
" autocmd FileType javascript setlocal omnifunc=tern#Complete
" }}}
"Plug 'Valloric/YouCompleteMe'
" Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' }
Plug 'othree/html5.vim'
" Plug 'hail2u/vim-css3-syntax'
" {{{ vim-prettier
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install',
    \ 'branch': 'release/1.x',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
nmap <Leader>pr <Plug>(Prettier)
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#semi = 'false'
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
let g:prettier#config#single_quote = 'true'
let g:prettier#config#print_width = '80'
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync
" }}}
" Plug 'othree/javascript-libraries-syntax.vim'
" let g:used_javascript_libs = 'vue' "react
" Plug 'othree/yajs.vim' " js syntax
Plug 'HerringtonDarkholme/yats.vim' " TypeScript
" {{{ vim-json
Plug 'elzr/vim-json'

" vim json disable conceal for json 
let g:vim_json_syntax_conceal = 0
" }}}
"support markdown
" 对齐文本
Plug 'godlygeek/tabular', { 'for': 'markdown' }
" 支持 :Toc 命令，依赖 tabular 
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_level = 2
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = ['js=javascript', 'css=scss']
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
" Plug 'skanehira/preview-markdown.vim'
Plug 'irrationalistic/vim-tasks'
" {{{ devdocs.io
Plug 'rhysd/devdocs.vim'
nmap <leader>dd <Plug>(devdocs-under-cursor)
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
" Plug 'KabbAmine/zeavim.vim', {'on': [
			" \	'Zeavim', 'Docset',
			" \	'<Plug>Zeavim',
			" \	'<Plug>ZVVisSelection',
			" \	'<Plug>ZVKeyDocset',
			" \	'<Plug>ZVMotion'
			" \ ]}
" nmap gZ <Plug>ZVKeyDocset
" }}}
" {{{ LeaderF
" Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" let g:Lf_ShortcutF = '<C-P>'
" let g:Lf_UseVersionControlTool = 0
" let g:Lf_CommandMap = {'<C-K>': ['<C-P>']}  " 避免与 tmux prefix 冲突
" let g:Lf_ShowDevIcons = 0
" }}}
" {{{ supertab 用 tab 键进行插入补全
" Plug 'ervandew/supertab'
" let g:SuperTabRetainCompletionType="context"
" }}}
" {{{ coc
" Plug 'neoclide/coc.nvim', {'do': 'yarn install'}
Plug 'neoclide/coc.nvim', {'branch': 'release',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'vue', 'yaml', 'html', 'jsx', 'tsx'] }
" CoC extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-json']

" Add CoC Prettier if prettier is installed
" if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  " let g:coc_global_extensions += ['coc-prettier']
" endif

" Add CoC ESLint if ESLint is installed
" if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  " let g:coc_global_extensions += ['coc-eslint']
" endif
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" codeaction
vmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>fc  <Plug>(coc-fix-current)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" snippets
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:coc_snippet_prev = '<c-l>' " 跟 tmux prefix 有冲突，改之

" Improve the completion experience not work?
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"}}}
Plug 'paroxayte/vwm.vim'
let s:vimdiff = {
      \  'name': 'vimdiff',
      \  'top':
      \  {
      \    'init': ['wincmd o', 'normal ibase'],
      \    'left':
      \    {
      \      'init': ['normal ilocal']
      \    },
      \    'right':
      \    {
      \      'init': ['normal iremote']
      \    }
      \  },
      \  'bot':
      \  {
      \    'init': ['normal imerge'],
      \    'sz': 20
      \  }
      \}

let s:frame = {
      \  'name': 'frame',
      \  'top': {
      \    'left': {
      \      'init': []
      \    },
      \    'right': {
      \      'init': []
      \    }
      \  },
      \  'bot': {
      \    'left': {
      \      'init': []
      \    },
      \    'right': {
      \      'init': []
      \    }
      \  },
      \  'left': {
      \    'init' :[]
      \  },
      \  'right': {
      \    'init' :[]
      \  }
      \}

let s:bot_panel = {
      \    'name': 'bot_panel',
      \    'bot':
      \    {
      \      'sz': 12,
      \      'left':
      \      {
      \        'init': []
      \      }
      \    }
      \  }

let g:vwm#layouts = [ s:vimdiff, s:frame, s:bot_panel ]

Plug 'cyio/markdown-preview.nvim', { 'branch': 'feat-sidebar-toc',  'do': 'cd app & yarn install'  }
let g:mkdp_auto_close = 0

" {{{ ale lint
" Plug 'w0rp/ale'
" let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
" let g:ale_lint_on_text_changed = 'never'
" }}}

Plug 'junegunn/goyo.vim'

" Plug 'vimwiki/vimwiki'
" let g:vimwiki_list = [{'path': '~/Projects/worknotes/src',
                      " \ 'syntax': 'markdown', 'ext': '.md'}]

Plug 'junegunn/goyo.vim'
Plug 'coot/vim-term'
" {{{ vim-translator
" 默认将结果显示在状态栏 W 窗口 R 替换 X 剪贴板
" 局限性：可视模式，W R 命令不可用
Plug 'voldikss/vim-translator'
let g:vtm_default_mapping = 0
let g:vtm_default_to_lang = 'en'
let g:translator_default_engines = ['google', 'bing']
nmap <silent> <Leader>w <Plug>TranslateW
" }}}
Plug 'heavenshell/vim-jsdoc'
Plug 'rhysd/git-messenger.vim'
" {{{ vimspector
" Plug 'puremourning/vimspector'
" let g:vimspector_enable_mappings = 'HUMAN'
" }}}
" Plug 'lvht/mru' " 查看最近使用的文件列表
" Plug 'airblade/vim-gitgutter'
" Plug 'jreybert/vimagit'
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'

call plug#end()
filetype plugin indent on     " required!
 " End of plug configuration

" let g:onedark_terminal_italics=1
" colorscheme onedark
" colorscheme codedark

" let g:colors_name = get(g:, 'colors_name', 'default')
" autocmd FileType markdown colorscheme onedark
" let s:saved_colorscheme = g:colors_name
" function! s:check_colorscheme_on_bufenter() abort
    " if &ft == 'markdown' && g:colors_name != 'PaperColor'
        " let s:saved_colorscheme = g:colors_name
        " colorscheme PaperColor
        " autocmd VimEnter,SessionLoadPost * :colorscheme PaperColor
    " elseif &ft != 'markdown' && g:colors_name == 'PaperColor'
        " exe 'colorscheme '.s:saved_colorscheme
    " endif
" endfunction

" augroup MarkdownColorScheme
    " au!
    " au BufEnter * call s:check_colorscheme_on_bufenter()
" augroup END

colorscheme papercolor
" colorscheme gruvbox
autocmd VimEnter,SessionLoadPost * :colorscheme papercolor
  " \         'color00' : ['#080808', '232'], " more dark
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'override' : {
  \       }
  \     }
  \   }
  \ }
 
" language format
" autocmd FileType javascript set formatprg=prettier\ --stdin\ --parser\ flow\ --single-quote\ --trailing-comma\ es5
" autocmd BufWritePre *.js :normal gggqG
" autocmd BufWritePre,TextChanged,InsertLeave *.js :normal gggqG

" }}}
"

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
    map <leader>tc :!/usr/bin/open -a "Visual Studio Code" %<CR>
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

" Set to auto read when a file is changed from the outside 设置自动读取一个文件时，从外部改变
set autoread

" 设置编码
set encoding=utf-8
set nocompatible
set laststatus=2
" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

" 设置文件编码
set fenc=utf-8

" 设置文件编码检测类型及支持格式
set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

"显示行号
set number

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
set ruler "Always show current position

"Persistent undo 永久撤销
try
	if MySys() == "windows"
	  set undodir=C:\Windows\Temp
	else
	  set undodir=~/.vim_runtime/undodir
	endif

	set undofile
catch
endtry

" {{{ Syntax highlighting

syntax on
" #1e1e1e
set background=dark
" set background=light
set t_Co=256
set nobackup
set nowritebackup
set noswapfile
" Better display for messages
set cmdheight=2
set relativenumber
" 让vim可以自动识别DOS和UNIX文本文件格式, 使用vim打开DOS文本文件就不会显示^M字符了
" set fileformats=dos,unix

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
nmap <Leader>pj :setlocal filetype=javascript<CR>
nmap <Leader>pn :setlocal filetype=none<CR>
nmap <Leader>pv :setlocal filetype=vue<CR>
" autocmd FileType vue syntax sync fromstart
autocmd FileType vue setlocal commentstring=//\ %s
autocmd FileType vue :set norelativenumber
autocmd BufNewFile,BufRead *.wpy set filetype=html
" autocmd BufNewFile,BufRead *.ts* set filetype=javascript
" }}}

set exrc " allow local vimrc
set secure
" set shell=/bin/zsh

set smartcase
