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
Plug 'SirVer/ultisnips'                                           " Snippet engine
Plug 'honza/vim-snippets'                                         " Sinppets for ^

"---------------------------
" Autocompletes/linters
"---------------------------
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }     " completion manager
Plug 'zchee/deoplete-jedi'                                        " completion manager for deoplete using jedi
Plug 'zchee/deoplete-clang'                                       " c completion
Plug 'zxqfl/tabnine-vim'                                          " AI based code completion

"---------------------------
" Search
"---------------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fzf binary
Plug 'junegunn/fzf.vim'
Plug 'dkprice/vim-easygrep'                                       " easy grep
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }     " clap file manager
Plug 'wsdjeg/FlyGrep.vim'                                         " Asynchronyous grepping on the fly

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

"---------------------------------
" Deoplete config
"---------------------------------
" To close deoplete preview on completion and insertion
autocmd CompleteDone * silent! pclose!
autocmd InsertLeave * silent! pclose!
let g:deoplete#enable_at_startup = 1
" Disable documentation window
set completeopt-=preview

" To detect the OS and change clang header accordingly
let uname = substitute(system('uname'), '\n', '', '')
if uname == 'Linux'
    let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
    let g:deoplete#sources#clang#clang_header = "/usr/lib/clang"
elseif uname == 'Darwin'
    let g:deoplete#sources#clang#libclang_path = "/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
    let g:deoplete#sources#clang#clang_header = "/Library/Developer/CommandLineTools/usr/lib/clang"
endif

" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

"---------------------------------
" UltiSnips config
"---------------------------------
" Enter to expand on macro, and to jump to next trigger
" Usage: select on the popup macro, press ExpandTrigger
let g:UltiSnipsExpandTrigger="<C-R>"
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" Function to allow pressing enter for the expand
let g:ulti_expand_or_jump_res = 0 " default value, just set once
function! Ulti_ExpandOrJump_and_getRes()
    call UltiSnips#ExpandSnippetOrJump()
    return g:ulti_expand_or_jump_res
endfunction
inoremap <CR> <C-R>=(Ulti_ExpandOrJump_and_getRes() > 0)?"":"\n"<CR>

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
" nmap <C-_>   <Plug>NERDCommenterToggle
" vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

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
au BufNewFile, BufRead *.py,*.c,*.h
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
" Clap settings
"---------------------------------
let g:clap_theme = 'material_design_dark'
nnoremap <Leader>t :Clap<CR>
nnoremap <Leader>f :Clap grep2<CR>

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
nnoremap <c-p> :FZF<cr>

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

