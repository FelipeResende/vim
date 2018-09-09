set nocompatible              " be iMproved, required
filetype off                  " required

" Vundle plugins -------------------------------------- {{{

" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My plugins
Plugin 'Valloric/YouCompleteMe'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'cohama/lexima.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'w0rp/ale'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line"execute pathogen#infect()
" }}}
" Basic settings {{{

let mapleader = ","
let maplocalleader = "\\"

syntax on
set expandtab
set shiftwidth=4
set tabstop=4
set number relativenumber
set showcmd  " show the command being typed in normal mode on the bottom right
set wildmenu " display possible matches above command-line when pressing <Tab>
set showmatch matchtime=1
set colorcolumn=+1,+41
set t_Co=256
set background=light
set laststatus=2 "Always show statusline
set foldlevelstart=0

" Limit lines up to 80 characters
" http://vim.wikia.com/wiki/80_character_line_wrap_without_broken_words
set formatoptions+=w
set textwidth=80

set backup
set writebackup
set backupdir=~/.vim/backups " Set directory for backup files
set directory=~/.vim/swaps " Set directory for swap files
set encoding=utf-8
set lazyredraw
set clipboard=unnamedplus   " Use 'default' register as clipboard

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

set modelines=0 " Disable modelines for security reasons
" Modelines set file specific settings
" Using the syntax (Do not forget the ":" in the end:
" vim:set cursorline:

" }}}
" Utils {{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

function! SetupEnvironment()
    let l:path = expand('%:p')
    " SE350 vim configuration file
    if l:path =~ '/home/felipe/Documents/Waterloo/SE_350/lab/SE350_Operating_Systems/'
        cd /home/felipe/Documents/Waterloo/SE_350/lab/SE350_Operating_Systems/
        source se350.vimrc
      elseif l:path =~ '/home/felipe/Documents/Projetos_Git/linux/'
        cd /home/felipe/Documents/Projetos_Git/linux/
        source linux.vimrc
    endif
endfunction

autocmd! BufReadPost,BufNewFile * call SetupEnvironment()

function! Include_guard()
  let f = join(['__', expand('%:t'), '__'], "")
  let f = toupper(f)
  let f = substitute(f, '\.', '_', "g")
  let @r = "#ifndef " . l:f
  let @r = @r . "\n#define " . l:f . "\n\n\n\n#endif"
  normal "rp
  normal 3j
endfunction

autocmd! BufNewFile *.h call Include_guard()
" }}}
" ### PLUGIN CONFIGS ### {{{
" # cscope {{{
if has("cscope")
    set cscopeprg=/usr/bin/cscope
    set cscopetagorder=0
    set cscopetag
    set nocscopeverbose
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
endif

nnoremap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-spacebar' then a search type makes the vim window
" split horizontally, with search result displayed in
" the new window.

nnoremap <Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>

" Hitting CTRL-space *twice* before the search type does a vertical
" split instead of a horizontal one

nnoremap <Space><Space>s
    \:vert scs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <Space><Space>g
    \:vert scs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <Space><Space>c
    \:vert scs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <Space><Space>t
    \:vert scs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <Space><Space>e
    \:vert scs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <Space><Space>i
    \:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <Space><Space>d
    \:vert scs find d <C-R>=expand("<cword>")<CR><CR>

" }}}
" # ctrlp {{{
" Ignore files ignored by git
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" Open new files in horizontal splits
let g:ctrlp_open_new_file = 'h'
" Open file in hsplit when <Enter> is pressed
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("h")': ['<c-h>', '<2-LeftMouse>'],
    \ 'AcceptSelection("e")': ['<cr>', '<RightMouse>'],
    \ }
" }}}
" # youcompleteme {{{
" Use virtualenv
"let g:ycm_python_binary_path = 'python'
"let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_goto_buffer_command = 'horizontal-split'
"let g:ycm_path_to_python_interpreter="/usr/bin/python"
"let g:ycm_server_python_interpreter="/usr/bin/python2"
"map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}
" # ALE {{{
let g:ale_python_mypy_options = '--strict-optional --silent-imports'
let g:ale_open_list = 1
let g:ale_lint_delay = 300
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
nnoremap <leader>k <Plug>(ale_previous_wrap)
nnoremap <leader>j <Plug>(ale_next_wrap)
"let g:ale_linters = {'c': ['gcc', 'clang', 'cppcheck'], 'cpp': ['gcc', 'clang'] }
let g:ale_linters = {'c': ['cppcheck'], 'cpp': [] }
"let linux_source = '/home/felipe/Documents/Projetos_Git/linux'
"let g:ale_c_clang_options = '-I' . linux_source . '/{include,arch/x86/include}'
"let g:ale_c_gcc_options = '-I' . linux_source . '/{include,arch/x86/include}'
"let g:ale_c_cppcheck_options = '-I' . linux_source . '/{include,arch/x86/include}'
"let g:ale_cpp_clang_options = '-I/home/felipe/Documents/Projetos_Git/linux/include'
"let g:ale_cpp_gcc_options = '-I/home/felipe/Documents/Projetos_Git/linux/include'
" }}}
" # CQUERY {{{
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif
" }}}
" }}}
" Mappings {{{
" Movement mappings
" move vertically by visual line
nnoremap j gj
nnoremap k gk

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

noremap <leader>- ddp
noremap <leader>_ ddkP
inoremap <leader><c-u> <esc>viwUea
nnoremap <leader><c-u> viwUe
nnoremap <leader>ev :sp $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>f"
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>f"
inoremap jk <esc>
" }}}
" Vimscript file settings ------------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
