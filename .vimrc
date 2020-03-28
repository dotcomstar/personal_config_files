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
let &titlestring = '%t%( %m%r%)%( <%{get(g:, "cur_project", "")}>%)' .
            \ '%( (%{expand("%:~:.:h")})%)' " .
           " \ '%( (%{getcwd()})%)%( %a%) - %(%{v:servername}%)'
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
let g:maplocalleader="\<Space>"

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
" autocmd FileType ocaml setlocal
au BufRead,BufNewFile *.ml,*.mli compiler ocaml

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
nnoremap <Leader><Space> :nohlsearch<CR>:let @/=""<CR>

" Toggle relativenumber.
nnoremap <Leader>n : set invrelativenumber<CR>

" Only use relativenumber in the current buffer.
augroup smartnumbertoggle
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
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

" Remap ';;' to escape.
" Note: By default, <C-[> also works.
imap ;; <esc>
vmap ;; <esc>
imap jk <esc>
vmap jk <esc>
imap kj <esc>
vmap kj <esc>

" " The first line maps escape to the right shift key when you enter Vim, and the second line returns normal functionality to right shift key when you quit.
" " This requires Linux with the xorg-xmodmap package installed.
" au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x3E = Escape'
" au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x3E = Shift_R'

" Remap :;; to ;; for use in Ocaml.
" Note: If I used three semicolons, then two semicolons would pause to check
" for the third.
" Note: A literal ;; can also be accomplished with ;<C-v>;
inoremap :;; ;;
tnoremap :;; ;;

" TODO: Disable scrolloff for mouse-based movements.
" TODO: Account for random accidental touch-pad clicks, perhaps outside of
" Vim.
vnoremap <LeftMouse> <Nop>

" Remap for smoother vertical mobility based on visual lines, not actual lines.
noremap <Up> g<Up>
noremap <Down> g<Down>

" Remap for nano-esque jumps to the beginning/end of a line.
" Note: Use `0` to go to the first column of a line.
map <C-a> ^
map <C-e> $
imap <C-a> <C-o>^
imap <C-e> <C-o>$

" Easier line navigation with capitalized movement commands.
nnoremap H ^
nnoremap L $
noremap <silent> <expr> K (line('.') - search('^\n.\+$', 'Wenb')) . 'kzv^'
noremap <silent> <expr> J (search('^\n.', 'Wen') - line('.')) . 'jzv^'

" Get back to where you were easily by setting a mark `p` before common jumps.
" Return to the previous line with 'p or `p.
nnoremap gg mpgg
nnoremap G mpG
nnoremap / mp/

" Easier indentation - does dot loose selection. (From what I understand, it
" puts you back into visual mode after you indent.)
vnoremap > >gv
vnoremap < <gv

" Catch accidental "U" usage.
nnoremap U :echo " < < ===== C H E C K   C A P S   L O C K.  Y O U  T Y P E D  \"U\". ==== > > "<CR>

" Select all.
" nnoremap A ggVG
" TODO: Return to previous line.

" Copy all to clipboard (only works in NeoVim).
if has('nvim')
    nnoremap yA gg"+yG''
endif

" I am too lazy to take my hands off shift. command! is preferred over
" cnoremap since you have to hit enter first.
command! WQ wq
command! Wq wq
command! W w

" Remap more common undo and redo buttons for non-vimmers.
nnoremap <C-z> u
inoremap <C-z> <C-o>u
nnoremap <C-y> <C-r>
inoremap <C-y> <C-o><C-r>

" Map Ctrl-s to save for non-vimmers.
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>

" Remap for easier window movement.
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Remap for easier tab movement.
nnoremap <C-t> :tabedit %<CR>
nnoremap <Leader>T :tabclose<CR>

" Instead of stumbling into ex mode, repeat the last macro used.
nnoremap Q @@

" Makes D act like d, except it doesn’t save the cut text to a register. Helps
" when I want to delete something without clobbering my unnamed register.
nnoremap D "_d

" Run the current line as if it were a command. Often more convenient than q:
" when experimenting.
nnoremap <leader>e :exe getline(line('.'))<cr>

" Also helpful commands to note:
"  Go to the first line of a file: gg
"  Go to the last line of a file: G
"  Go to the fist column of a line: 0
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
"  Paste in insert mode: Ctrl + r
"  Access registers: :reg
"  Copy to clipboard register in nvim: "+y
"  Check spellcheck suggestions: z=
"  Comment out a line using Vim Commentary plugin: gcc

" These are autocommands to override any highlights from plugins.
augroup ShowTrailingWhitespace
    autocmd VimEnter * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
    autocmd VimEnter * match ExtraWhitespace /\s\+$/
augroup end

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

" Setting up ignores
set wildignore+=*/tmp/*,*.so,*.pyc,*.png,*.jpg,*.gif,*.jpeg,*.ico,*.pdf
set wildignore+=*.wav,*.mp4,*.mp3
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*
set wildignore+=_pycache_,.DS_Store,.vscode,.localized
set wildignore+=.cache,node_modules,package-lock.json,yarn.lock,dist,.git


" ============== THE END OF SUPPORT FOR VANILLA VIM ==================
