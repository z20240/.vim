let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-gitgutter'
Plugin 'posva/vim-vue'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


source $VIMRUNTIME/vimrc_example.vim

set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set shiftwidth=4
set tabstop=4
set softtabstop=4
set foldmethod=marker
set et
set nrformats=hex
set noautowrite
"set colorcolumn=120

if $TERM == "screen"
    " set title
    set t_ts=k
    set t_fs=\
    let &titleold = strpart($SHELL, strridx($SHELL, '/') + 1)
    auto BufEnter,BufRead,BufWinEnter,WinEnter * :set title | let &titlestring = '[V]' . strpart(expand('%'), 1 + strridx(expand('%'), '/'))
    auto VimLeave * :set title | let &titlestring = &titleold
endif

syn on

au BufNewFile,BufRead *.wpm setf wpm
au BufNewFile,BufRead *.c,*.cpp,*.java set cin
au BufNewFile,BufRead *.c,*.cpp,*.java,*.pl,*.pm set path=,,..:wq
au BufNewFile,BufRead *.log,*.txt set nowrap
au BufRead svn-commit* set nobackup viminfo=
au BufRead svn-prop* set nobackup viminfo=
au BufRead COMMIT_EDITMSG* set nobackup viminfo=
au BufRead git-rebase-todo set nobackup viminfo=
au BufRead .faketime set nobackup viminfo=
au BufRead *patch set nofoldenable

if maparg("<C-C>") != ""
    au TabEnter * unmap <C-C>
endif
if maparg("<C-C>", "i") != ""
    au TabEnter * iunmap <C-C>
endif
au BufNewfile,BufRead,TabEnter *.pl map <C-C> :w<CR>:!perl -c %<CR>
au BufNewfile,BufRead,TabEnter *.pm map <C-C> :w<CR>:!perl -I $HOME/perl5/lib/perl5/site_perl/5.20:wq/mach -c %<CR>
au BufNewfile,BufRead,TabEnter *.pl imap <C-C> <Esc>:w<CR>:!perl -c %<CR>
au BufNewfile,BufRead,TabEnter *.pm imap <C-C> <Esc>:w<CR>:!perl -I $HOME/perl5/lib/perl5/site_perl/5.20/mach -c %<CR>
au BufNewfile,BufRead,TabEnter *.php map <C-C> :w<CR>:!php -l %<CR>
au BufNewfile,BufRead,TabEnter *.php imap <C-C> <Esc>:w<CR>:!php -l %<CR>

au BufWritePre *.pl,*.pm,*.php,*.js,*.css :%s/\s\+$//e
" au BufWritePost *.pl,*.pm :!perl -c %
" au BufWritePost *.php :!php -l %

" highlight trailing whitespaces and spaces before a tab
au BufNewFile,BufRead * hi ExtraWhitespace ctermbg=red guibg=red
au BufNewFile,BufRead * match ExtraWhitespace /\s\+$\| \+\ze\t/

if version >= 700
  map g1 :tabn 1<CR>
  map g2 :tabn 2<CR>
  map g3 :tabn 3<CR>
  map g4 :tabn 4<CR>
  map g5 :tabn 5<CR>
  map g6 :tabn 6<CR>
  map g7 :tabn 7<CR>
  map g8 :tabn 8<CR>
  map g9 :tabn 9<CR>
  map g0 :tabn 10<CR>
  map gm1 :tabm 0<CR>
  map gm2 :tabm 1<CR>
  map gm3 :tabm 2<CR>
  map gm4 :tabm 3<CR>
  map gm5 :tabm 4<CR>
  map gm6 :tabm 5<CR>
  map gm7 :tabm 6<CR>
  map gm8 :tabm 7<CR>
  map gm9 :tabm 8<CR>
  map gm0 :tabm 9<CR>
  map gc :tabnew<CR>
  map gn :tabn<CR>
  " map gp :tabp<CR>
  map <C-j> :tabn<CR>
  map <C-k> :tabp<CR>
  map <Char-0x7f> <C-h>

  imap <C-j> <Esc>:tabn<CR>
  imap <C-k> <Esc>:tabp<CR>

  highlight TabLineSel term=bold,underline cterm=bold,underline ctermfg=7 ctermbg=0
  highlight TabLine    term=bold cterm=bold
  highlight clear TabLineFill

  au BufNewFile,BufRead *.txt,*.tex set spell

  :command! Trim %s/\s\+$
end

hi Folded guibg=black guifg=grey40 ctermfg=grey ctermbg=darkgrey
set bg=dark
set cursorline
set number              " 顯示行號
set laststatus=2        " 開啟vim的狀態列
set mouse=a        " 開啟/vim的滑鼠控制功能[a]=all


" Vim 的 Intellisence
" " 非以下幾種語言的話，可以達到 auto complete
" " 使用 Ctrl+N 來觸發
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" set path=,,..

" source $HOME/.vim/plugin/snipMate.vim
imap <C-s> <Esc>:Trim<CR>


set t_Co=256
colo molokai

"於 vim 中顯示 tab 及行尾空白
set list listchars=tab:»·,trail:·,extends:»,precedes:«
highlight SpecialKey ctermfg=234

" 忽略大小寫搜尋
set ignorecase

"智慧大小寫搜尋
set smartcase

" 擴增 backspace 的功能
set backspace=indent,eol,start

" vim的指令暫存提示
set showcmd

" 關閉 vim 的自動存檔
set noautowrite

" 剪下、貼上時自動偵測轉換為 set paste 模式
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif


" 修改vim的狀態列
set statusline=[%{expand('%:p')}][%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%{FileSize()}%{IsBinary()}%=%c,%l/%L\ [%3p%%]

function IsBinary()
    if (&binary == 0)
        return ""
    else
        return "[Binary]"
    endif
endfunction

function FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return "[Empty]"
    endif
    if bytes < 1024
        return "[" . bytes . "B]"
    elseif bytes < 1048576
        return "[" . (bytes / 1024) . "KB]"
    else
        return "[" . (bytes / 1048576) . "MB]"
    endif
endfunction
