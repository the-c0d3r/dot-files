
"colorscheme = [gruvbox, molokai, colorsbox-material, dracula, srcery, koe]
colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"

syntax enable
" set lazyredraw
set cursorline background=dark backspace=indent,eol,start
set nu    " Line Numbering
set list    " set list and listchar is used to show the space as trails
set listchars=tab:»\ ,extends:›,precedes:‹,trail:·
" set listchars=tab:→\ ,trail:␣,extends:…,eol:⏎
set incsearch ignorecase smartcase hlsearch
set mouse=a
" Always show statusline
set laststatus=2
" Use 256 colors
set t_Co=256
" To enable cross session vim copy-pasting
set clipboard=unnamed
" to keep the terminal open after switching tabs
set hidden
" to disable line numbering for terminal
au TermOpen * setlocal nonumber norelativenumber

call plug#begin()
Plug 'gmarik/Vundle.vim'
" Disabled plugins
" Plug 'w0rp/ale'                      " The linter
" Plug 'roxma/nvim-completion-manager' " for autocompletion
" Plug 'lambdalisue/wifi.vim'           " wifi widget
" Plug 'lambdalisue/battery.vim'        " battery widget
" Plug 'zchee/deoplete-clang'           " c completion
" Plugin 'scrooloose/syntastic'
" Plugin 'nvie/vim-flake8'
" Plugin 'Valloric/YouCompleteMe'
" Plug 'davidhalter/jedi-vim'

" Aesthetics
Plug 'scrooloose/nerdtree'            " File explorer
Plug 'scrooloose/nerdcommenter'       " commenting plugin
Plug 'ryanoasis/vim-devicons'         " nerdTree icons
Plug 'vim-python/python-syntax'       " For better python syntax highlighting
Plug 'tmhedberg/SimpylFold'           " Folding helper
Plug 'jistr/vim-nerdtree-tabs'        " Tab explorer
Plug 'tpope/vim-fugitive'             " Airline git branch
Plug 'airblade/vim-gitgutter'         " git indicator
Plug 'vim-airline/vim-airline'        " status bar theme
Plug 'vim-airline/vim-airline-themes' " new airline themes
Plug 'junegunn/goyo.vim'              " distraction free writing
Plug 'junegunn/limelight.vim'         " for paragraph coloring to use with goyo
Plug 'junegunn/vim-easy-align'        " alignments
Plug 'sbdchd/neoformat'               " to pretty print
Plug 'liuchengxu/space-vim-dark'      " Space Vim Dark color scheme

" Tools
Plug 'junegunn/vim-easy-align'        " code alignment gaip+keyword, gaip=, gaip*
Plug 'tpope/vim-surround'             " quote surround
Plug 'christoomey/vim-conflicted'     " Vim git merge conflict resolving tool
Plug 'qpkorr/vim-bufkill'             " to kill buffer without closing the vim
Plug 'moll/vim-bbye'                  " buffer kill
Plug 'dracula/vim'                    " The dracula theme
Plug 'majutsushi/tagbar'              " the functions, globals, tagbar <F8>
Plug 'terryma/vim-multiple-cursors'   " multiple cursor locations
Plug 'elzr/vim-json'                  " json syntax highlighting
Plug 'Yggdroot/indentLine'            " to show the indent lines
Plug 'mbbill/undotree'                " to undo to the original point
Plug 'sheerun/vim-polyglot'           " vim extra language packs
Plug 'vim-scripts/a.vim'              " for switching to header file and source cmd :A

" Autocompletes/linters
Plug 'Shougo/deoplete.nvim'           " completion manager
Plug 'zchee/deoplete-jedi'            " completion manager for deoplete using jedi
Plug 'ervandew/supertab'              " use tab for autocompletion prompts

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'kien/ctrlp.vim'                 " Fuzzy search

call plug#end()


"---------------------------------
" NERDTree config
"---------------------------------
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc$','\~$','\.DS\_Store','\*\.swp', '\*\.o$', '\.o$'] "Ignore files for nerdtree
let NERDTreeWinSize=31
" autocmd VimEnter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" To close deoplete preview on completion and insertion
autocmd CompleteDone * silent! pclose!
autocmd InsertLeave * silent! pclose!

"---------------------------------
" Highlight line
"---------------------------------

augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" function to strip whitespace on save
augroup vimrc
    autocmd!
augroup END
autocmd vimrc BufWritePre * :call s:StripTrailingWhitespaces()

"---------------------------------
"Key mapping for cycling through buffers
"---------------------------------
let mapleader=","
"Key mapping for split navigations
" Neovim doesn't need control after c-w
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <C-\> :NERDTreeToggle<CR>

" cycling buffers
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
nnoremap <Leader>q :BD<CR>  " kill buffer

tnoremap <Esc> <C-\><C-n>  " terminal escape
nmap <F8> :TagbarToggle<CR> " Toggle tab bar
nnoremap \ :nohlsearch<CR><CR>:<backspace> " Clear previous search term by pressing enter

"---------------------------------
" EasyAlign
"---------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"---------------------------------
" NERDCommenter configs
"---------------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


" Enable code folding
filetype plugin indent on
let g:SimpylFold_docstring_preview=0
" set foldlevel=1
" set foldmethod=indent
" Folding with spacebar
nnoremap <space> za
" Autocmd for unfolding at start
autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

" set smartindent
" PEP8 Indentation
au BufNewFile, BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=80
    \ set expandtab
    \ set autoindent
    \ fileformat=unix

au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$\
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set expandtab
    \ set autoindent

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set encoding=utf-8
" python highlighting
let python_highlight_all=1

"---------------------------------
" Airline settings
"---------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1
let g:airline_theme = 'gruvbox'
let g:airline_section_z = '%3p%% %l:%L %{strftime("%I:%M%p")}}' " %{battery#component()}'
let g:airline_section_warning = ""
" airline themes = molokai, powerlineish, gruvbox, dracula, hybrid, luna, zenburn
" statusbar functions = '%{battery#component()}', '%{strftime("%I:%M%p")}', '%{wifi#component()}'

let g:python_host_prog = expand("~/.config/nvim/.p2/bin/python")
let g:python3_host_prog = expand("~/.config/nvim/.p3/bin/python")

"---------------------------------
" fzf-vim
"---------------------------------
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Type'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Character'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


"---------------------------------
" Strip Trailing Spaces on save
"---------------------------------
function! s:StripTrailingWhitespaces()
    let l:l = line(".")
    let l:c = col(".")
    %s/\s\+$//e
    call cursor(l:l, l:c)
endfunction

"---------------------------------
" Highlight line
"---------------------------------
highlight Pmenu ctermbg=white ctermfg=black cterm=bold
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none
highlight CursorLine cterm=NONE ctermbg=black gui=NONE

"---------------------------------
" Quote selection
"---------------------------------
vnoremap q <esc>:call QuickWrap("'")<cr>
vnoremap Q <esc>:call QuickWrap('"')<cr>

function! QuickWrap(wrapper)
  let l:w = a:wrapper
  let l:inside_or_around = (&selection == 'exclusive') ? ('i') : ('a')
  normal `>
  execute "normal " . inside_or_around . escape(w, '\')
  normal `<
  execute "normal i" . escape(w, '\')
  normal `<
endfunction
