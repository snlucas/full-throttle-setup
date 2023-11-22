call plug#begin()
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'mattn/emmet-vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

" Airline Theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" JavaScript and JSX syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" React
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

" YouCompleteMe
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }

" Salesforce
Plug 'neowit/vim-force.com'
call plug#end()

let g:instant_markdown_slow = 1
au VimLeave * !pkill -f 'instant-markdown-d'

" Theme
"colorscheme industry

" Indentation
set tabstop=2
set shiftwidth=2
set expandtab

" Line Number
set number relativenumber
highlight LineNr ctermfg=Magenta

" Line Highlight
set cursorline
highlight CursorLine ctermbg=green ctermfg=red cterm=bold gui=bold

" Clipboard
set clipboard+=unnamed

" Sidebar Files Manager
inoremap <c-b> <Esc>:Lex<cr>:vertical resize 30<cr>
nnoremap <c-b> <Esc>:Lex<cr>:vertical resize 30<cr>

" Force-com Config
set nocompatible
filetype plugin on
syntax on

let g:apex_backup_folder="~/temp/apex/backup"
let g:apex_temp_folder="~/temp/apex"
let g:apex_properties_folder="~/temp/apex/properties"
let g:apex_tooling_force_dot_com_path="~/tooling-force"

let &runtimepath=&runtimepath . ',~/.vim/plugged/vim-force.com'
runtime ftdetect/vim-force.com.vim

" React
let g:ycm_filetype_blacklist = {'javascript': 1, 'javascript.jsx': 1}
