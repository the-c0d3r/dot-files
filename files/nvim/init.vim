"--------------------------------
" GENERAL CONFIG
"--------------------------------
syntax enable                                      " enable syntax highlighting
set conceallevel=0                                 " force vim to show all markdown characters
set cursorline                                     " show highlight on cursor line
set background=dark                                " dark background
set backspace=indent,eol,start                     " backspace behavior to allow over indent, over eol, over start
set number                                         " line Numbering
set list                                           " set list and listchar is used to show the space as trails
set listchars=tab:»\ ,extends:›,precedes:‹,trail:·
set incsearch ignorecase smartcase hlsearch        " incremental search, highlight search, smart case
set mouse=a                                        " all mouse modes
set laststatus=2                                   " Always show statusline
set clipboard^=unnamed,unnamedplus                 " Cross session vim copy-pasting, cross program copy-pasting

call plug#begin()
"---------------------------
" Aesthetics
"---------------------------
Plug 'scrooloose/nerdtree'                                        " File explorer
Plug 'scrooloose/nerdcommenter'                                   " commenting plugin
Plug 'ryanoasis/vim-devicons'                                     " nerdTree icons
Plug 'vim-python/python-syntax'                                   " For better python syntax highlighting
Plug 'tmhedberg/SimpylFold'                                       " Folding helper
Plug 'tpope/vim-fugitive'                                         " Airline git branch
Plug 'airblade/vim-gitgutter'                                     " git indicator
Plug 'vim-airline/vim-airline'                                    " status bar theme
Plug 'vim-airline/vim-airline-themes'                             " new airline themes
Plug 'junegunn/rainbow_parentheses.vim'                           " Rainbow parentheses color
Plug 'sakshamgupta05/vim-todo-highlight'                          " Highlights TODO FIXME
Plug 'kshenoy/vim-signature'                                      " displays the marks on the sidebar
Plug 'ap/vim-css-color'                                           " displays color for color code
Plug 'sainnhe/sonokai'                                            " sonokai color scheme
Plug 'miyakogi/conoline.vim'                                      " highlight current line
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}            " better syntax highlighting for python

"---------------------------
" Themes
"---------------------------
Plug 'morhetz/gruvbox'                                            " Gruvbox theme
Plug 'NLKNguyen/papercolor-theme'                                 " Papercolor theme
Plug 'octol/vim-cpp-enhanced-highlight'                           " c/c++ syntax highlight
Plug 'elzr/vim-json'                                              " json syntax highlighting

"---------------------------
" Tools
"---------------------------
Plug 'junegunn/vim-easy-align'                                    " code alignment gaip+keyword, gaip=, gaip*
Plug 'tpope/vim-surround'                                         " quote surround
Plug 'christoomey/vim-conflicted'                                 " Vim git merge conflict resolving tool
Plug 'qpkorr/vim-bufkill'                                         " to kill buffer without closing the vim
Plug 'moll/vim-bbye'                                              " buffer kill
Plug 'majutsushi/tagbar'                                          " the functions, globals, tagbar <F8>
Plug 'terryma/vim-multiple-cursors'                               " multiple cursor locations
Plug 'Yggdroot/indentLine'                                        " to show the indent lines
Plug 'mbbill/undotree'                                            " to undo to the original point
Plug 'vim-scripts/a.vim'                                          " for switching to header file and source cmd :A
Plug 'easymotion/vim-easymotion'                                  " Easy Motion

"---------------------------
" Autocompletes/linters
"---------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'zxqfl/tabnine-vim'                                          " AI based code completion

"---------------------------
" Search
"---------------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fzf binary
Plug 'junegunn/fzf.vim'

call plug#end()


"---------------------------------
" Color Theme Configuration
"---------------------------------
"colorscheme = [gruvbox, molokai, colorsbox-material, dracula, srcery, koe,PaperColor]
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_transparent_background=1

colorscheme sonokai

"---------------------------------
" NERDTree config
"---------------------------------
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc$','\~$','\.DS\_Store','\*\.swp', '\*\.o$', '\.o$'] "Ignore files for nerdtree
let NERDTreeWinSize=31
" autocmd VimEnter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

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

" Command mapping for the case to write as sudo when opened as non sudo
cmap w!! w !sudo /usr/bin/tee > /dev/null %

"---------------------------------
" EasyAlign
"---------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"---------------------------------
" Easy Motion
"---------------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

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

" Comment on command mode and visual mode with Ctrl + / (IDE type shortcut)
" FIXME: this doesn't work on mac
nnoremap <C-_> :call NERDComment(0,"toggle")<CR>
vnoremap <C-_> :call NERDComment(0,"toggle")<CR>

" Enable code folding
filetype plugin indent on
let g:SimpylFold_docstring_preview=0
" set foldlevel=1
set foldmethod=syntax
" Folding with spacebar
nnoremap <space> za
" Autocmd for unfolding at start
autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

" set smartindent
" PEP8 Indentation
au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$\
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set expandtab
    \ set autoindent
    \ fileformat=unix

autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab


set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set encoding=utf-8
" python highlighting
let python_highlight_all=1


"---------------------------------
" VIM TODO HIGHLIGHT
"---------------------------------
let g:todo_highlight_config = {
      \   'REVIEW': {},
      \   'NOTE': {
      \     'gui_fg_color': '#ffffff',
      \     'gui_bg_color': '#ffbd2a',
      \     'cterm_fg_color': 'white',
      \     'cterm_bg_color': '214'
      \   }
      \ }


"---------------------------------
" Airline settings
"---------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1
let g:airline_theme = 'sonokai'
let g:airline_section_z = '%3p%% %l:%L %{strftime("%I:%M%p")}' " %{battery#component()}'
let g:airline_section_warning = ""
" themes = molokai, powerlineish, gruvbox, dracula, hybrid, luna, zenburn, base16_atelierforest
" statusbar functions = '%{battery#component()}', '%{strftime("%I:%M%p")}', '%{wifi#component()}'

let g:python_host_prog = expand("~/.config/nvim/.p2/bin/python")
let g:python3_host_prog = expand("~/.config/nvim/.p3/bin/python")

"---------------------------------
" Indentline
"---------------------------------
" disable hiding of markdown characters
let g:indentLine_concealcursor = ""
let g:indentLine_conceallevel = 0

"---------------------------------
" fzf-vim
"---------------------------------
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" FZF file search
nnoremap <c-p> :FZF<cr>
" FZF Ag search similar to grep
nnoremap <Leader> :Ag<CR>

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

