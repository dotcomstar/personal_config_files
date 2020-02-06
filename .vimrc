" Pure Business
set encoding=UTF-8
set noerrorbells  " Disable error sounds.
set novisualbell  " Disable visual errors.
set history=500  " Remember these many lines of history.
set undolevels=10000
set lazyredraw  " Speed up macros by telling Vim to only redraw the screen when necessary.
set timeoutlen=1000  " Used for mapping delays (ms).
set ttimeoutlen=10  " Used for key code delays (ms).
set maxmempattern=10000
set termguicolors  " Allows pum menu opacity and squiggly lines for typos.

" Editor Quality of Life
set mouse=a  " Enable mouse support.
set backspace=indent,eol,start  " Allow the backspace key to delete any whitespace.
colorscheme darkblue  " darkblue and molokai are nice in my opinion.
autocmd VimEnter * silent! colorscheme molokai  " Set colorscheme to molokai if it exists.

" Enable background opacity in vim.
highlight Normal ctermfg=LightGray guibg=NONE ctermbg=NONE
set undofile  " Maintain undo history even after exiting a file.
" Reopen vim to the last position.
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
syntax enable  " Enable syntax processing.
set title  " Let Vim set the terminal title.
set ruler  " Always show current cursor coordinates at the bottom right.
set number relativenumber  " Display relative line numbers for easier jumping.
if has("spell") | set spell! spelllang=en_us | endif " Enable spell-check by default.

" Normal Mode Quality of Life
set list
set listchars=tab:\|·  " Display tab characters as a vertical line and dots.
set cursorline  " Underline the current line.
set wildmenu  " Allow for visual autocomplete of command menu.
set cmdheight=2  " Set the height of the command bar at the bottom.
set showcmd  " Show the last entered command in the bottom bar.
let g:mapleader="\<Space>"

" Tab Settings
filetype off  " Reset filetype indentation first...
filetype indent on  " Enable filetype-specific indentation preferences.
set expandtab  " Convert tabs to spaces.
set softtabstop=4  " How many spaces to add and remove for a simulated tab.
set shiftwidth=4  " Set the default tab stop to 4 spaces.
set softtabstop=4  " Treat space 'tabs' as a single character.
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype java setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype c setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype make setlocal noexpandtab tabstop=8 shiftwidth=8
autocmd Filetype ruby setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Set backup files
" Note: the "//" at the end of each directory means that file names will be
" built from the complete path to the file with all path separators
" substituted to percent "%" sign. This will ensure file name uniqueness in
" the preserve directory.
set undodir=~/.vim/.undo//
set directory=~/.vim/.swp//

" Search-related commands
set showmatch  " Highlight matches [{()}]
set incsearch  " Search as characters are entered.
set hlsearch  " Highlight matches.
let b:autopairs_loaded=1  " Disable automatic bracket and quote matching by ensuring it never runs.
" Turn off search highlight by pressing space.
nnoremap <leader><space> :nohlsearch<CR>

" Toggle relativenumber.
nnoremap <leader>n : set invrelativenumber<CR>

" Only use relativenumber in the current buffer.
augroup smartnumbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Search ignoring case, unless the parameter is uppercase.
set ignorecase
set smartcase

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Toggle spell-check with F6.
if has("spell")
    map <F6> :setlocal spell! spelllang=en_us<CR>
    imap <F6> <C-o>:setlocal spell! spelllang=en_us<CR>
    vmap <F6> :<C-u>setlocal spell! spelllang=en_us<CR>
endif

" Toggle the ability to keep the cursor in the middle of the screen.
set scrolloff=999  " Enabled by default.
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" TODO: Disable scrolloff for mouse-based movements.
" TODO: Account for random accidental touch-pad clicks, perhaps outside of
" Vim.
vnoremap <LeftMouse> <Nop>

" Remap for smoother vertical mobility based on visual lines, not actual lines.
noremap <Up> g<Up>
noremap <Down> g<Down>

" Remap for nano-esque jumps to the beginning/end of a line.
map <C-a> ^
map <C-e> $
imap <C-a> <C-o>^
imap <C-e> <C-o>$

" Remap ';;' to escape.
map ;; <esc>
imap ;; <esc>
vmap ;; <esc>

" Catch accidental "U" usage.
nnoremap U :echo " < < ===== C H E C K   C A P S   L O C K.  Y O U  T Y P E D  \"U\". ==== > > "<CR>

" Select all.
" nnoremap A ggVG
" TODO: Return to previous line.

" Copy all to clipboard (only works in NeoVim).
if has('nvim')
    nnoremap yA gg"+yG''
endif

" Remap more common undo and redo buttons for non-vimmers.
nnoremap <C-z> u
inoremap <C-z> <C-o>u
nnoremap <C-y> <C-r>
inoremap <C-y> <C-o><C-r>
" TODO: Figure out what else is mapped to Ctrl-y.

" Remap for easier window movement.
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Remap for easier tab movement.
nnoremap <C-t> :tabedit %<CR>
nnoremap <Leader>t :tabclose<CR>

" Also helpful commands to note:
"  Go to the first line of a file: gg
"  Go to the last line of a file: G
"  Open a new window: sp (on top) or vsp (side to side)
"  Cut line: dd
"  Paste from Vim clipboard: p
"  Insert tab character in insert mode: ctrl + v + tab, or ctrl + q + tab
"    in windows mode, which is the default. ctrl + i occasionally works, but
"    is not consistent.
"  Run one command and then return automatically to insert mode
"  Automatically fix comment length: gw
"  Jump up 10 lines: 10k
"  Jump down 10 lines: 10j
"  Access registers: :reg
"  Copy to clipboard register in nvim: "+y
"  Check spellcheck suggestions: z=
"  Comment out a line using Vim Commentary plugin: gcc

" Show trailing whitespace.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" Strip trailing whitespace on file exit.
autocmd BufWritePre * :%s/\s\+$//e
" TODO: Be more careful about stripping necessary whitespace.

" Other colors include, Black, DarkBlue, DarkGreen, DarkCyan, DarkRed,
" DarkMagenta, Brown, DarkYellow, LightGray, LightGrey, Gray, Grey, DarkGray,
" DarkGrey, Blue, LightBlue, Green, LightGreen, Cyan, LightCyan, Red, LightRed,
" Magenta, LightMagenta, Yellow, LightYellow, and White.

" Draw a vertical border at 80 columns
if exists('+colorcolumn')
  set colorcolumn=80
  highlight colorcolumn ctermbg=DarkGray guibg=#606060
else
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  2match OverLength /\%81v.\+/
endif

" netrw config settings.

" Make netrw file explorer act like NERDTree.
let g:netrw_liststyle = 3  " Use a tree-style listing in directories.
let g:netrw_browse_split = 4  " Open files to the right of the tree, in the previous window.
let g:netrw_altv = 1  " Split on the right side instead of the left.
let g:netrw_winsize = 23  " Set width of window to 23%.
let g:netrw_banner = 0  " Disables the banner by default. Toggle with "I".
let g:netrw_list_hide = &wildignore  " Inherit Vim's wildignores.

" Automatically close Vim if netrw is the last open buffer.
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
autocmd WinEnter * if winnr('$') == 2 && getbufvar(winbufnr(winnr()), "&filetype") == "ctags" || &buftype == 'quickfix' |q|endif
" autocmd BufLeave * call ToggleTerminalAtBottom()
" TODO: Implement for tagbar and terminal.



" ============== THE END OF SUPPORT FOR VANILLA VIM ==================


" =============<= PLUGIN CONFIG =>=============

" Tagbar config settings.
let g:tagbar_left = 1
let g:tagbar_vertical = 5
let g:tagbar_width = 23

" Tagbar config settings.
let g:tagbar_singleclick = 1  " Jump to tag with single click. Default is double click.
" TODO: Allow dynamic resizing of tagbar window on startup.
" TODO: Remap <ENTER> to open and close folders like '+' and '-' do currently.

" Many settings stem from https://www.notion.so/NeoVim-Configuration-6611b6768eca4fc38da311f7e86572aa

" Set more intuitive mappings for the terminal.
tnoremap <Esc> <C-\><C-n>
tmap ;; <Esc>
tmap <C-w> <Esc><C-w>

" Open File Explorer
nnoremap <C-n> :Lexplore<C-m>

" Toggle the built-in NeoVim terminal
let g:is_terminal_open = 0  " Off by default.
function! ToggleTerminalAtBottom()
    if g:is_terminal_open == 0
        wincmd n  " Open a new buffer.
        terminal
        wincmd J  " Move the terminal to the very bottom.
        exec 'resize '. string(&lines * 0.13)
        let g:is_terminal_open = 1
    else  " The terminal is already on.
        " TODO: Figure out how to properly close the terminal.
        " WARNING: This is a super janky implementation that closes the bottom
        " buffer, regardless of what it is.
        wincmd j
        close
        let g:is_terminal_open = 0
    endif
endfunction

" IDE Mode
function! OpenIDEMode()
    Lexplore  " Open the file explorer.
    TagbarToggle  " Open the tag bar.
    wincmd r  " Put the tagbar below the file explorer.
    wincmd =  " Resize the buffers to equal size.
    wincmd p  " Return back to the previous buffer.
    call ToggleTerminalAtBottom()
    wincmd p  " Return back to the previous buffer.
endfunction

" Map Tab to open IDE Mode.
nnoremap <Tab> :call OpenIDEMode()<CR>

" Map Ctrl+` to open the terminal, similar to VSCode.
nnoremap <C-Space> :call ToggleTerminalAtBottom()<CR>

" Launch IDE Mode on Vim startup.
augroup LaunchIDEModeOnStartup
    " TODO: Make this only run on valid file types.
    autocmd VimEnter * :call OpenIDEMode()<CR>
    " autocmd VimEnter * nested :call tagbar#autoopen(1)  " Only open for supported filetypes.
augroup END

" Set the Airline colorscheme.
autocmd VimEnter * silent! AirlineTheme jet " Set airline theme to jet if it exists.

" Vim Plug Plugins
call plug#begin('~/.vim/plugged')

" Aesthetics
Plug 'flazz/vim-colorschemes'  " Add more colorscheme options.
" Disable vim-airline when firenvim starts since vim-airline takes two lines.
if !exists('g:started_by_firenvim')
    Plug 'bling/vim-airline'  " Include color box at the bottom.
    Plug 'vim-airline/vim-airline-themes'  " Check out screenshots at https://github.com/vim-airline/vim-airline/wiki/Screenshots.
endif

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
Plug 'w0rp/ale'
"Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'  " Enable commenting out lines with `gcc`.
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Plug 'ntpeters/vim-better-whitespace'
Plug 'mhinz/vim-startify'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}  " Only run for Markdown files.
"Plug 'TaskList.vim'  " TODO Checker.

" Syntax
Plug 'liuchengxu/graphviz.vim'
Plug 'lervag/vimtex'
Plug 'jceb/vim-orgmode'
Plug 'elzr/vim-json'
Plug 'habamax/vim-asciidoctor'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-crystal'

" External Support
Plug 'ianding1/leetcode.vim'
" For Linux and Windows
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" For MacOS (from shell command line)
" nvim --headless -c "call firenvim#install(0, 'export PATH=\"$PATH\"')" -c quit

call plug#end()

" Extra Setup
let g:go_fmt_command = "goimports"

let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'

set tags=./tags,tags;$HOME

" Note: Cannot get this to function properly. TODO: Test more extensively.
function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction

"Uncomment to override instant_markdown defaults:
"let g:instant_markdown_slow = 1
"let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0

" Note: This makes vim load too slowly.
" Automatically load NERDTree and TagbarToggle upon Vim boot.
" autocmd VimEnter * NERDTree
" autocmd VimEnter * TagbarToggle
" " Jump to the previous (main) window.
" autocmd VimEnter * wincmd p
"
" " Find the current file in NERDTree.
" map <leader>f :NERDTreeFind<cr>
"
" " Automatically close Vim if NERDTree is the last open buffer.
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Add code folding.
set nofoldenable  " Ensure files are opened unfolded.
set foldmethod=syntax  " Add code folding based on syntax.

" Tabular configurations for common auto-alignment commands.
" TODO: Make into a function to accept any input literal.
nnoremap <leader>a=  :Tabularize /=<CR>
vnoremap <leader>a=  :Tabularize /=<CR>
nnoremap <leader>A=  :Tabularize /=\zs<CR>
vnoremap <leader>A=  :Tabularize /=\zs<CR>
nnoremap <leader>a:  :Tabularize /:<CR>
vnoremap <leader>a:  :Tabularize /:<CR>
nnoremap <leader>A:  :Tabularize /:\zs<CR>
vnoremap <leader>A:  :Tabularize /:\zs<CR>
nnoremap <leader>a#  :Tabularize /#<CR>
vnoremap <leader>a#  :Tabularize /#<CR>
nnoremap <leader>A#  :Tabularize /#\zs<CR>
vnoremap <leader>A#  :Tabularize /#\zs<CR>
nnoremap <leader>a/  :Tabularize /\/\/<CR>
vnoremap <leader>a/  :Tabularize /\/\/<CR>
nnoremap <leader>A/  :Tabularize /\/\/\zs<CR>
vnoremap <leader>A/  :Tabularize /\/\/\zs<CR>
nnoremap <leader>a\| :Tabularize /\|<CR>
vnoremap <leader>a\| :Tabularize /\|<CR>
nnoremap <leader>A\| :Tabularize /\|\zs<CR>
vnoremap <leader>A\| :Tabularize /\|\zs<CR>


" Set pum to be transparent. termguicolors must be enabled for it to look
" nice.
set pumblend=15
highlight PmenuSel blend=0

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
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <ENTER> pumvisible() ? "\<C-y>" : "\<ENTER>"

" Use pum for vim commands as well.
set wildoptions+=pum
cnoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
cnoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
cnoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
" cnoremap <expr> <ENTER> pumvisible() ? "\<C-y>" : "\<ENTER>"

" Tagbar Options:
let g:tagbar_autoshowtag = 1  " Recursively open folds to show selected tag.
let g:tagbar_map_togglefold = "<Space>"
let g:tagbar_map_showproto = "o"

" Enable LeetCode support.
let g:leetcode_browser = 'firefox'
let g:leetcode_solution_filetype = 'python'
" Values: 'cpp', 'java', 'python', 'python3', 'csharp', 'javascript', 'ruby', 'swift', 'golang', 'scala', 'kotlin', 'rust'.
" Default value is 'cpp'.

" firenvim editor settings
if exists('g:started_by_firenvim') && g:started_by_firenvim
    let fc = g:firenvim_config['localSettings']
    " general options
    set laststatus=0 noshowcmd
    set cmdheight=2  " Set the height of the command bar at the bottom.
    nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
    nnoremap <C-z> :call firenvim#hide_frame()<CR>
endif

" firenvim browser extension settings
let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
    \ }
\ }

