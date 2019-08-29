set ruler  " Always shows current cursor location.
set number  " Shows line numbers.
set cmdheight=2  " Sets the height of the command bar at the bottom.
syntax enable  " Enables syntax processing.
colorscheme darkblue " darkblue and solarized are nice in my opinion.
set history=500  " How many lines of history to remember.
set expandtab  " Converts tabs to spaces.
set softtabstop=4  " Number of spaces to convert a tab to.
set number " Shows line numbers.
set showcmd  " Shows the last entered command in the bottom bar.
set cursorline  " Highlights the current line.
set mouse=a  " Enables mouse support.
filetype indent on  " Enables filetype-specific indentation preferences.
set wildmenu  " Allows for visual autocomplete.
set lazyredraw  " Speeds up macros by telling vim to only redraw the screen when necessary.
set showmatch  " Highlight matches [{()}]
set incsearch  " Searches as characters are entered.
set hlsearch  " Highlights matches
" Turns off search highlight by pressing space.
nnoremap <leader><space> :nohlsearch<CR>
" Remapping for smoother vertical mobility based on visual lines, not actual lines.
nnoremap j gj
nnoremap k gk
" Remapping for nano-esque jumps to the beginning/end of a line.
nnoremap A ^
nnoremap E $
let mapleader=","  " The leader is a comma.
" Remapping 'jk', ';l', and ';'' to escape.
inoremap jk <esc>
inoremap ;l <esc>
inoremap ;' <esc>