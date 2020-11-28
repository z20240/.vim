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
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'                " 在 vim 中開啟目錄
Plugin 'Xuyuanp/nerdtree-git-plugin'        " git 在 nerdtree 上的工具
Plugin 'Yggdroot/indentLine'                " 縮排提示線
Plugin 'tmhedberg/SimpylFold'               " 配置代碼摺疊的管理套件
Plugin 'Valloric/YouCompleteMe'             " vim上的自动补全神器
Plugin 'leafgarland/typescript-vim'         " typescript-vim
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

" =========== 輔助管理 ==============

syntax on                   " 開啟語法高亮
set encoding=utf-8          " 設置編譯語言
set fileencoding=utf-8
set termencoding=utf-8
set shiftwidth=4
set tabstop=4
set softtabstop=4
set foldmethod=marker
set et
set nrformats=hex
set noautowrite
set showmatch               " 显示匹配的括号
set bg=dark
set cursorline
set number                  " 顯示行號
set laststatus=2            " 開啟vim的狀態列
set mouse=a                 " 開啟/vim的滑鼠控制功能[a]=all
set autoread

" ================ 版面顯示 ===============
set t_Co=256                " 設定顏色 256
colo molokai                " 色彩配置

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

hi Folded guibg=black guifg=grey40 ctermfg=grey ctermbg=darkgrey

if $TERM == "screen"
    " set title
    set t_ts=k
    set t_fs=\
    let &titleold = strpart($SHELL, strridx($SHELL, '/') + 1)
    auto BufEnter,BufRead,BufWinEnter,WinEnter * :set title | let &titlestring = '[V]' . strpart(expand('%'), 1 + strridx(expand('%'), '/'))
    auto VimLeave * :set title | let &titlestring = &titleold
endif

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
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

" set path=,,..

" source $HOME/.vim/plugin/snipMate.vim
imap <C-s> <Esc>:Trim<CR>

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


" 修改vim的狀態列 ============================================================
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
" 修改vim的狀態列 =============================================================

" Remove trailing whitespace when writing a buffer, but not for diff files ====
function RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()
" Remove trailing whitespace when writing a buffer, but not for diff files ====


" =========================  配置NERDTree======================================
"使用F2键快速调出和隐藏它
map <F2> :NERDTreeToggle<CR>

let NERDTreeChDirMode=1

"显示书签"
let NERDTreeShowBookmarks=1

"设置忽略文件类型"
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']

"窗口大小"
let NERDTreeWinSize=25

" 修改默认箭头
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"How can I open a NERDTree automatically when vim starts up if no files were specified?
"若 vim 開啟目錄，自動仔入 NETRDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" 打开vim时自动打开NERDTree
autocmd vimenter * NERDTree

"How can I open NERDTree automatically when vim starts up on opening a directory?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" 关闭vim时，如果打开的文件除了NERDTree没有其他文件时，它自动关闭，减少多次按:q!
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" 开发的过程中，我们希望git信息直接在NERDTree中显示出来，
" 和Eclipse一样，修改的文件和增加的文件都给出相应的标注，
" 这时需要安装的插件就是 nerdtree-git-plugin , 配置信息如下
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1

" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1

" 支持任意ASCII码，也可以使用特殊字符：¦, ┆, or │ ，但只在utf-8编码下有效
let g:indentLine_char='¦'

" 使indentline生效
let g:indentLine_enabled = 1

" =========================  配置NERDTree======================================

" ========================= 代码折叠 ===========================
" 必须手动输入za来折叠（和取消折叠）
set foldmethod=indent                " 根据每行的缩进开启折叠
set foldlevel=99

" 使用空格键会是更好的选择,所以在你的配置文件中加上这一行命令吧：
nnoremap <space> za

" 希望看到折叠代码的文档字符串？
let g:SimpylFold_docstring_preview=1

" ========================= 代码折叠 ===========================

" 配置 Youcompleteme 設定 =====================================
"
" 參考：
" https://www.jianshu.com/p/923aec861af3?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
" https://www.jianshu.com/p/132afa869394
" https://gist.github.com/ChengLong/6208775
"
" 安裝方法：
" 先安裝： 「cmake」
" $brew install cmake
" 到 ~/.vim/bundle/YouCompleteMe/ 下方
" 執行 ./install.py 或是 ./install.sh
" 如果發生無法安裝的問題，使用：
" git submodule update --init --recursive 先行安裝第三方套件
" 然後再重新執行一次 ./install.py
" (for debian9 : 可能需要下 sudo apt install vim-python-jedi
" 來完成。其中可能會碰到 python 安裝不完全的問題，你要上網找方法)
" https://blog.csdn.net/LHYzyp/article/details/71514322 【Linux】-- apt-get install 出错，Python 未配置
" 补全菜单的开启与关闭
set completeopt=longest,menu                                    " 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
let g:ycm_min_num_of_chars_for_completion=2                     " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0                                      " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_autoclose_preview_window_after_completion=1           " 智能关闭自动补全窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif         " 离开插入模式后自动关闭预览窗口

" 补全菜单中各项之间进行切换和选取：默认使用tab  s-tab进行上下切换，使用空格选取。可进行自定义设置：
let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']              " 通过上下键在补全菜单中进行切换
let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
" 回车即选中补全菜单中的当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

" 开启各种补全引擎
let g:ycm_collect_identifiers_from_tags_files=1         " 开启 YCM 基于标签引擎
let g:ycm_auto_trigger = 1                  " 开启 YCM 基于标识符补全，默认为1
let g:ycm_seed_identifiers_with_syntax=1                " 开启 YCM 基于语法关键字补全
let g:ycm_complete_in_comments = 1              " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1               " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0 " 注释和字符串中的文字也会被收入补全

" 重映射快捷键
"上下左右键的行为 会显示其他信息,inoremap由i 插入模式和noremap不重映射组成，只映射一层，不会映射到映射的映射
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>           " force recomile with syntastic
"nnoremap <leader>lo :lopen<CR>    "open locationlist
"nnoremap <leader>lc :lclose<CR>    "close locationlist
"inoremap <leader><leader> <C-x><C-o>

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处
let g:ycm_confirm_extra_conf=0                  " 关闭加载.ycm_extra_conf.py确认提示
" 配置 Youcompleteme 設定 =====================================

" ==== Typescript Syntax for Vim =====
let g:typescript_indent_disable = 1
let g:typescript_opfirst='\%([<>=,?^%|*/&]\|\([-:+]\)\1\@!\|!=\|in\%(stanceof\)\=\>\)'
au BufRead,BufNewFile *.ts   setfiletype typescript
" ==== Typescript Syntax for Vim =====
