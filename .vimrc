"==============================================================
" latelのvimenergy
" @version 0.2
" @update  2015/04/27
" @see     http://github.com/latel/vimenergy
"==============================================================
" 探测
"------------------------------------------------------
" 操作系统
if (has("win32") || has("win64") || has("win95") || has("win16")) 
    let g:isWindows = 1
else
    let g:isWindows = 0
endif
" 支持MAC
if has("gui_macvim")
  set macmeta
end
" 终端还是GUI
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" 辅助函数
"------------------------------------------------------
"1.自定义标尺
function! SetColorColumn()
    let col_num = virtcol(".")
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        execute "set cc+=".col_num
    else
        execute "set cc-=".col_num
    endif
endfunction

function! FormatHTML()
    %s/<[^>]*>/\r&\r/g
    g/^\s*$/d
endfunction

" 参数配置
"------------------------------------------------------
"1.基础
set nocompatible            "无需兼容vi
set nobomb                  "去掉BOMB头
set number                  "显示行号
set relativenumber          "显示相对行号
set ruler                   "显示标尺
set cc=90                   "越界标尺
winpos 20 40              "设置启动窗口的位置,坐标原点在屏幕左上角
set lines=50 columns=102    "设置启动窗口的大小
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set bsdir=buffer            "设置工作目录为当前编辑文件的目录
"set autochdir               "自动切换当前目录为当前文件所在的目录
"貌似和bufferexplorer有兼容性问题
set cmdheight=1             "设置命令栏/状态栏高度
"2.文档
filetype on                 "启用文件类型侦测
filetype indent on           "开启缩进规则，在文件类型检测生效后，可用的缩进规则将会被使用
filetype plugin on          "启用filetype plugin, 针对不同的文件类型加载对应的插件
filetype plugin indent on   "启用自动缩进
"set completeopt=longest,menu "禁用智能补全时的预览窗口
"3.整体视觉效果
if (!g:isWindows && g:isGUI)
    set transparency=2          "窗口透明度
endif
colo fruit
colo lucius
colo monokai
set cursorline              "高亮当前行
"set guioptions-=m           "隐藏菜单
if (!g:isWindows)
    set guioptions-=T           "隐藏工具栏
endif
set guioptions-=r           "隐藏右侧的滚动条
"set guioptions-=b           "隐藏底侧的滚动条
set guioptions-=L           "隐藏左侧的滚动条
"set guifont=Monospace\ 9   "字体名称空格用下划线代替或者\转义
"set guifont=DejaVu\ Sans\ Mono\ Book\ 8.7
"set guifont=Microsoft_YaHei_Mono:h10:cGB2312
"set guifont=YaHei\ Consolas\ Hybrid\ 9.1
"set guifont=YaHei Consolas Hybrid 13
"set guifont=Courier\ New\ Bold:h13
if (g:isWindows)
    set guifont=Consolas:h11
else
    set guifont=Consolas:h13
endif
"set gfw=YouYuan:h8:cGB2312
"4.体验
set noimdisable
autocmd! InsertLeave * set imdisable|set iminsert=0
autocmd! InsertEnter * set noimdisable|set iminsert=0
set shiftround              "当你的缩进不成倍时，让 Vim 自动帮你把周围的缩进化零为整
set list                    "显示特殊符号
if g:isWindows
    set list listchars=eol:˥,trail:., "详细的定义显示哪些符号
elseif
    set list listchars=eol:¬,tab:▸\ ,trail:., "详细的定义显示哪些符号
endif
set showmatch               "打开此选项使得你在输入成对的括号时，Vim 会帮助你跳转并高亮一下匹配的括号
set scrolloff=3             "上下滚动时，边缘保留的行数
set showcmd                 "在屏幕右下角显示未完成的指令输入
set hlsearch                "高亮搜索结果
set incsearch               "搜索时在未完全输入完毕要检索的文本时就开始检索
set ignorecase smartcase    "搜索时忽略大小写, 但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan              "禁止在搜索到文件两端时重新搜索
set nowrap                  "不要换行
set smartindent             "基于autoindent的一些改进
set autoindent!             "自动缩进，即为新行自动添加与当前行同等的缩进
"set shortmess=atI          "去掉欢迎界面
"au GUIEnter * simalt ~x    "窗口启动时自动最大化

"set pastetoggle=<F11>      "切换粘贴模式
syntax enable               "启用语法高亮
syntax on                   "打开语法高亮
"set autoread               "文件被外部修改时自动重载
"5.约定
set shiftwidth=4            "换行时行间交错使用4个空格
set cindent                 "类似C语言程序的缩进
set tabstop=4               "设置tab键的宽度
set expandtab               "将tab键转换为空格
set backspace=2             "设置退格键可用
set smarttab                "指定按一次backspace就删除4个空格
"6.保存和备份
set nobackup                "禁用自动备份
"set noswapfile             "不要生产swap文件
set writebackup             "保存文件前建立备份，保存成功后删除该备份
"set dir=~/.vim/vimswaps/   "在固定目录存储SWAP文件而不是文件所在目录而不是文件所在目录
if !g:isWindows
    set undofile            "关闭文件后重新打开仍可以撤销之前的改动
    set undolevels=1000     "当前编辑允许的撤消深度
    set undoreload=1000     "关闭文件重新打开后可撤消上次编辑改动的深度
    set undodir=~/.vim/undos "在固定目录存储UNDO文件
endif
set history=400             "history文件中需要记录的行数
set confirm                 "在处理未保存或只读文件的时候，弹出确认
"7.编码
set encoding=utf-8          "vim内部编码
set fileencoding=utf-8      "当前打开的文件编码
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936 "支持打开的文件编码
set langmenu=zh_CN.UTF-8    "菜单编码
set helplang=cn             "使用中文帮助信息
if (g:isWindows && g:isGUI)
    "解决菜单乱码  
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "解决console乱码
    language message zh_CN.UTF-8
endif
set nospell                 "不要检查错别字
set mousemodel=popup        "右键菜单类型

" 键图绑定
"------------------------------------------------------
"F10打开NerdTree
map <F10> <ESC>:NERDTreeToggle<cr>
"A-x 切换所有对齐线可见
nmap <A-x> :IndentLinesToggle<cr>
"使用A-o在当前行下插入一个空白行
nmap <A-o> o<ESC>k
"常规模式下输入 cls 清除行首和行尾空格
nmap cls :%s/\s\+$//g<cr>
"常规模式下输入 clm 清除行尾的M符号
nmap clm :%s/\r$//g<cr>:noh<cr>
"选中模式下允许C-c复制文本
vmap <C-c> "+y
"常规模式下允许 Ctrl+s 保存文档
map <C-s> <esc>:w<cr>
"正常模式下 Ctrl+w 将代码向上移动一行
nmap <C-w> dd<esc>k<esc>P
"A-c切换一个自定义标尺的开关
map <A-c> :call SetColorColumn()<cr>
"使用空格键开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<cr>
"输入模式下 Ctrl+h 光标向左移动
imap <C-h> <Left>
"输入模式下 Ctrl+j 光标上向移动
imap <C-j> <Down>
"输入模式下 Ctrl+k 光标向下移动
imap <C-k> <Up>
"输入模式下 Ctrl+l 光标向右移动
imap <C-l> <Right>
nmap <F4> :AuthorInfoDetect<cr>
nmap <F7> :call FormatHTML()<cr>gg=G

" 自动化
"------------------------------------------------------
"1.自动重载vimrc,无需重启Vim即可看到修改vimrc的效果
if g:isWindows
    autocmd! bufwritepost $VIMRUNTIME/../_vimrc source %
else
    autocmd! bufwritepost ~/_vimrc source %
endif
"2.启动插件管理器
execute pathogen#infect()
"call pathogen#runtime_append_all_bundles() " 老版本写法

"3.每行超过80个的字符用下划线标示
" autocmd BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 90 . 'v.\+', -1)

"4.根据文档类型自动处理
"PHP
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType php map <C-A> :!php -l %<CR>

"JAVASCRIPT
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

"CSS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"HTML
autocmd FileType css set omnifunc=csscomplete#CompleteTags

"5.启动时自动全屏
"autocmd GUIEnter * simalt ~x

" 插件配置
"------------------------------------------------------
""""""""""""""""""""""""""""""
" < TagList插件配置 >
""""""""""""""""""""""""""""""
if g:isWindows
    let Tlist_Ctags_Cmd='c:/windows/ctags'      "指定标签生成程序
else
    let Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8/bin/ctags' "指定标签生成程序
endif
let Tlist_Auto_Update = 1                       "自动更新
let Tlist_Show_One_File=1                       "不同时显示多个文件的tag，只显示当前文件
let Tlist_Exit_OnlyWindow = 1                   "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1                  "在右侧窗口中显示taglist窗口, 0 就是在左边
let Tlist_Process_File_Always = 1               "如果希望taglist始终解析文件中的tag，不管taglist窗口有没有打开
let tlist_php_settings = 'php;c:class;f:function;i:interfaces;d:constant'
"let Tlist_Auto_Open=1                          "启动时自动打开窗口
"let Tlist_Use_SingleClick = 1                  "单击跳转
"let Tlist_File_Fold_Auto_Close=1               "自动折叠
"let Tlist_WinWidth=30                          "设置窗口宽度

"常规模式下输入 tl 调用TagList插件
nmap tl :TagbarClose<cr>:TlistToggle<cr>

""""""""""""""""""""""""""""""
" < Tagbar 插件配置 >
""""""""""""""""""""""""""""""
"相对 TagList 能更好的支持面向对象
let g:tagbar_width=30                       "设置窗口宽度
let g:tagbar_ctags_bin='/usr/local/Cellar/ctags/5.8/bin/ctags'
"let g:tagbar_left=1                        "在左侧窗口中显示

"常规模式下输入 tb 调用插件，如果有打开 TagList 窗口则先将其关闭
nmap tb :TlistClose<cr>:TagbarToggle<cr>

""""""""""""""""""""""""""""""
" < MiniBufferExplorer 插件配置 >
""""""""""""""""""""""""""""""
"快速浏览和操作Buffer
"主要用于同时打开多个文件并相与切换
let g:miniBufExplMapCTabSwitchBufs=1  "功能增强, 在当前窗口中打开 C-tab向后，C-S-tab向前的buffer
let g:miniBufExplMapWindowNavVim=1    "用<C-k,j,h,l>切换到上下左右的窗口中去
let g:miniBufExplMapWindowNavArrows=1 "用Ctrl加方向键切换到上下左右的窗口中去
let g:miniBufExplModSelTarget = 1     "不要在不可编辑内容的窗口（如TagList窗口）中打开选中的buffer

""""""""""""""""""""""""""""""
" < MRU 插件配置 >
""""""""""""""""""""""""""""""
"let MRU_File = 'd:\myhome\_vim_mru_files' 
"let MRU_Max_Entries = 1000 
"let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix 
"let MRU_Exclude_Files = '^c:\\temp\\.*'           " For MS-Windows
"let MRU_Include_Files = '\.c$\|\.h$' //文件名匹配
let MRU_Use_Current_Window = 1
let MRU_Auto_Close = 1

""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" < IndentLines 插件配置 >
""""""""""""""""""""""""""""""
let g:indentLine_faster = 1

""""""""""""""""""""""""""""""
" < Grep 插件配置 >
""""""""""""""""""""""""""""""
nnoremap <silent> <F3> :Grep<CR>

""""""""""""""""""""""""""""""
" Neocomplcache
""""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup = 1 "随着vim启动而启动

""""""""""""""""""""""""""""""
" < 一键添加作者信息 插件配置 >
""""""""""""""""""""""""""""""
let g:vimrc_author='Kezhen Wang' 
let g:vimrc_email='latelx64@gmail.com' 
let g:vimrc_homepage='http://kezhen.info/'

""""""""""""""""""""""""""""""
" < Vim-Markdown 插件配置 >
""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled=1

""""""""""""""""""""""""""""""
" < Gist-Vim 插件配置 >
""""""""""""""""""""""""""""""
let g:gist_detect_filetype = 1                  " 探测文件类型
let g:gist_open_browser_after_post = 1          " 发布后自动使用浏览器打开
" let g:gist_browser_command = 'opera %URL% &'  " 使用指定的浏览器
" let g:gist_post_private = 1                   " 默认发布私人Gist



" 功能性函数定义
"------------------------------------------------------
function! CheckPhpSyntax()
    if &filetype!="php"
        echohl WarningMsg | echo "Fail to check syntax! Please select the right file!" | echohl None
        return
    endif
    if &filetype=="php"
        " Check php syntax
        setlocal makeprg=\"php\"\ -l\ -n\ -d\ html_errors=off
        " Set shellpipe
        setlocal shellpipe=>
        " Use error format for parsing PHP error output
        setlocal errorformat=%m\ in\ %f\ on\ line\ %l
    endif
    execute "silent make %"
    set makeprg=make
    execute "normal :"
    execute "copen"
endfunction
