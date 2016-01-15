"execute pathogen#infect()
"call pathogen#runtime_append_all_bundles()
"call pathogen#infect()
set nocp
syntax on
filetype plugin indent on
":map <C-n> :NERDTreeToggle<CR>
set expandtab
set shiftwidth=4
set tabstop=4
set number
set showcmd  " show the command being typed in normal mode on the bottom right
set wildmenu
let mapleader = ","

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" Movement mappings
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Limita as linhas em 80 caracteres
" http://vim.wikia.com/wiki/80_character_line_wrap_without_broken_words
set formatoptions+=w
set tw=80

set modelines=0 " Disable modelines for security reasons
" Modelines set file specific settings
" Using the syntax (Do not forget the ":" in the end:
" vim:set cursorline:

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
