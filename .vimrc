set ruler  " Always show current cursor location.
set number  " Show line numbers.
set cmdheight=2  " Set the height of the command bar at the bottom.
syntax enable  " Enable syntax processing.
colorscheme darkblue " darkblue and solarized are nice in my opinion.
" Enable background opacity in vim.
hi Normal guibg=NONE ctermbg=NONE
set history=500  " Remember these many lines of history.
set noerrorbells  " Disable error sounds.
set number " Show line numbers.
set showcmd  " Show the last entered command in the bottom bar.
set cursorline  " Highlight the current line.
set mouse=a  " Enable mouse support.
set wildmenu  " Allow for visual autocomplete of command menu.
set lazyredraw  " Speed up macros by telling vim to only redraw the screen when necessary.
set list
set listchars=tab:▸·  " Display tab characters with an arrow and dots.
filetype off  " Reset filetype indentation first...
filetype indent on  " Enable filetype-specific indentation preferences.
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype golang setlocal tabstop=4 shiftwidth=4
set expandtab  " Convert tabs to spaces.
set softtabstop=4  " How many spaces to add and remove for a simulated tab.
set timeoutlen=1000  " Used for mapping delays (ms).
set ttimeoutlen=10  " Used for key code delays (ms).
set showmatch  " Highlight matches [{()}]
set incsearch  " Search as characters are entered.
set hlsearch  " Highlight matches.
set number relativenumber  " Display relative line numbers for easier jumping.
set encoding=UTF-8

" Turn off search highlight by pressing space.
nnoremap <leader><space> :nohlsearch<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv


" Remap for smoother vertical mobility based on visual lines, not actual lines.
noremap <Up> g<Up>
noremap <Down> g<Down>

" Remap for nano-esque jumps to the beginning/end of a line in command mode.
nnoremap A ^
nnoremap E $
nnoremap <C-a> ^
nnoremap <C-e> $
let mapleader=","  " The leader is a comma.

" Remap for nano-esque jumps in insert mode.
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

" Remap for nano-esque jumps in visual mode.
vnoremap <C-a> ^
vnoremap <C-e> $

" Remap 'jk', ';l', ';'', and ';;' to escape in insert mode.
inoremap jk <esc>
inoremap ;l <esc>
inoremap ;' <esc>
inoremap ;; <esc>

" Remap ';;' to escape in visual mode.
vnoremap ;; <esc>


" Also helpful commands to note:
"  Go to the first line of a file: gg
"  Go to the last line of a file: G
"  Open a new window: sp (on top) or vsp (side to side)
"  Cut line: dd
"  Paste from vim clipboard: p
"  Insert tab character in insert mode: ctrl + v  + tab, or ctrl + q + tab
"    in windows mode, which is the default. ctrl + i occasionally works, but
"    is not consistent.
"  Run one command and then return automatically to insert mode
"  Automatically fix comment length: gw
"  Jump up 10 lines: 10k
"  Jump down 10 lines: 10j
"  Access registers: :reg
"  Copy to clipboard register in nvim: "+y

set backspace=indent,eol,start  " Allow the backspace key to delete any whitespace.

" Show trailing whitespace.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/
" Other colors include, Black, DarkBlue, DarkGreen, DarkCyan, DarkRed,
" DarkMagenta, Brown, DarkYellow, LightGray, LightGrey, Gray, Grey, DarkGray,
" DarkGrey, Blue, LightBlue, Green, LightGreen, Cyan, LightCyan, Red, LightRed,
" Magenta, LightMagenta, Yellow, LightYellow, and White.

" Draw a vertical border at 80 columns
if exists('+colorcolumn')
  set colorcolumn=80
else
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  2match OverLength /\%81v.\+/
endif


" From https://www.notion.so/NeoVim-Configuration-6611b6768eca4fc38da311f7e86572aa

" NERDTree Shortcut
nnoremap <C-n> :NERDTreeToggle<C-m>

" IDE Mode
nnoremap <C-i> :NERDTreeToggle<C-m>:TagbarToggle<C-m>

" Vim Plug Plugins
call plug#begin('~/.vim/plugged')

" Aesthetics
Plug 'bling/vim-airline'  " Include color box at the bottom.
Plug 'flazz/vim-colorschemes'  " Add more colorscheme options.

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Notes:
"   For golang to work, gopls must be installed
"
"   node and npm must be installed in general
"
"   For python to work, install jedi with pip
"
"   For clang to work, install clangd
"
"   For tsserver to work, install tsserver by globally installing typescript
"   with npm

" Editor
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mhinz/vim-startify'

" Syntax
Plug 'liuchengxu/graphviz.vim'
Plug 'lervag/vimtex'
Plug 'jceb/vim-orgmode'
Plug 'elzr/vim-json'
Plug 'habamax/vim-asciidoctor'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-crystal'

call plug#end()

" Extra Setup
let g:go_fmt_command = "goimports"

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Use <tab> for trigger completion and navigate to the next complete item.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Enable tab and shift-tab for navigation through autocompletion suggestions.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
