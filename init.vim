
===== 安装nvim =====
"sudo apt install neovim
"安装插件管理器vim plug
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"配置COC时需要安装依赖
"   1. nodejs
"   2. Yarn
"   3. python3 (pip3 install neovim)

"配置CPP时
"需要安装ccls
"apt install ccls


===== 建立nvim的配置文件 =====

" Mkdir ~/.config/nvim
" nvim ~/.config/nvim






===== Basic =====

"设置行号
set number

"设置相对行号
set relativenumber

"忽略大小写
set ignorecase "

"智能大小写
set smartcase

"关闭命令输入的等待超时
set notimeout

"设置敲两次空格为缩进
set expandtab 
set tabstop=2 "tab宽度
set shiftwidth=2 "统一缩进为2
set softtabstop=2 


"代码补全
set completeopt=preview,menu

"自动保存
set autowrite

"打开状态栏标尺
set ruler

"突出显示当前行
set cursorline

"设置魔术
set magic

"设置状态行显示的信息
set foldcolumn=0
set foldmethod=indent
set foldlevel=3
set foldenable

"语法高亮
set syntax=on

"去掉输入错误的提示音
set noeb

"退出时确认保存
set confirm













===== Keyboard ======


"插入模式下，设置jk是退出键
imap jk <esc>

"设置：为空格
nmap <space> :

"设置ctrl+e是打开文件管理器
map <silent> <C-e> :NERDTreeToggle<CR>





===== Plug插件管理器 =====


call plug#begin('~/.vim/plugged')
" nerd
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'

" lsp

Plug 'neoclide/coc.nvim', {'branch': 'release'}

"debug
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-rust --enable-python'}

" highlight
Plug 'cateduo/vsdark.nvim'
Plug 'jackguo380/vim-lsp-cxx-highlight'



call plug#end()



" ==== jackguo380/vim-lsp-cxx-highlight ====

hi default link LspCxxHlSymFunction cxxFunction
hi default link LspCxxHlSymFunctionParameter cxxParameter
hi default link LspCxxHlSymFileVariableStatic cxxFileVariableStatic
hi default link LspCxxHlSymStruct cxxStruct
hi default link LspCxxHlSymStructField cxxStructField
hi default link LspCxxHlSymFileTypeAlias cxxTypeAlias
hi default link LspCxxHlSymClassField cxxStructField
hi default link LspCxxHlSymEnum cxxEnum
hi default link LspCxxHlSymVariableExtern cxxFileVariableStatic
hi default link LspCxxHlSymVariable cxxVariable
hi default link LspCxxHlSymMacro cxxMacro
hi default link LspCxxHlSymEnumMember cxxEnumMember
hi default link LspCxxHlSymParameter cxxParameter
hi default link LspCxxHlSymClass cxxTypeAlias


" ==== puremourning/vimspector ====
let g:vimspector_enable_mappings = 'HUMAN'

function! s:generate_vimspector_conf()
  if empty(glob( '.vimspector.json' ))
    if &filetype == 'c' || 'cpp' 
      !cp ~/.config/nvim/vimspector_conf/c.json ./.vimspector.json
    elseif &filetype == 'python'
      !cp ~/.config/nvim/vimspector_conf/python.json ./.vimspector.json
    endif
  endif
  e .vimspector.json
endfunction

command! -nargs=0 Gvimspector :call s:generate_vimspector_conf()



===== Code Title =====

".c, .h, .sh,
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.py,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if expand("%:e") == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."),"\#########################################################################")
        call append(line(".")+1, "\# File Name:".expand("%"))
        call append(line(".")+2, "\# Author:Merlin")
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "\#########################################################################")
        call append(line(".")+5, "")
    elseif expand("%:e") == 'py'
        call setline(1,"\#!/usr/bin/env python")
        call append(line("."),"\#########################################################################")
        call append(line(".")+1, "\# File Name: ".expand("%"))
        call append(line(".")+2, "\# Author:Merlin")
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "\#########################################################################")
        call append(line(".")+5, "")
    else
        call setline(1,"/*#########################################################################")
        call append(line("."), "\# File Name: ".expand("%"))
        call append(line(".")+1, "\# Author:Merlin")
        call append(line(".")+2, "\# Created Time: ".strftime("%c"))
        call append(line(".")+3, "#########################################################################*/")
        call append(line(".")+4, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include <bits/stdc++.h>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if expand("%:e") == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    "新建文件后，自动定位到文件末尾
    endfunc
    autocmd BufNewFile * normal G


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:generate_compile_commands()
  if empty(glob('CMakeLists.txt'))
    echo "Can't find CMakeLists.txt"
    return
  endif
  if empty(glob('.vscode'))
    execute 'silent !mkdir .vscode'
  endif
  execute '!cmake -DCMAKE_BUILD_TYPE=debug
      \ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .vscode'
endfunction
command! -nargs=0 Gcmake :call s:generate_compile_commands()








"设置分屏快捷键
"禁用s快捷键"
map s <nop>
"sl:右sh:左sk:上sj:下"
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>
"设置分屏后光标移到方向
map . <C-w><C-w>
 
"设置上下左右移动分屏大小
"map <up> :res +5<CR>
"map <down> :res -5<CR>
"map <left> :vertical resize-5<CR>
"map <right> :vertical resize+5<CR>
map <LEADER>k :res +5<CR>
map <LEADER>j :res -5<CR>
map <LEADER>h :vertical resize-5<CR>
map <LEADER>l :vertical resize+5<CR>



"代码编译器安装
let g:coc_global_extensions = [
	\ 'coc-cmake',
	\ 'coc-pyright',
	\ 'coc-vimlsp',
	\ 'coc-tsserver',
	\ 'coc-highlight'
	\]

"代码补全选择
" <TAB> to select candidate forward or
" pump completion candidate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" <s-TAB> to select candidate backward
inoremap <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.')-1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction
" <CR> to comfirm selected candidate
" only when there's selected complete item
if exists('*complete_info')
  inoremap <silent><expr> <CR> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif



"K查看该命令的帮助文档
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if(index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


"全局对象重命名
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f <Plug>(coc-format-selected)
command! -nargs=0 Format :call CocAction('format')





" diagnostic info 错误信息
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<CR>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nmap <LEADER>qf <Plug>(coc-fix-current)













