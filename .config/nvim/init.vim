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
" Note: If you have ugly colors, try `set notermguicolors` instead.

" Editor Quality of Life
" For full mouse support, use `set mouse=a`.
set mouse=nic  " Enable mouse support but disable mouse selection.
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

" Copy all to clipboard (only works in NeoVim).
if has('nvim')
    nnoremap yA gg"+yG''
endif

" Toggle the ability to keep the cursor in the middle of the screen.
set scrolloff=999  " Enabled by default.
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Remap ';;' to escape.
" Note: By default, <C-[> also works.
imap ;; <esc>
vmap ;; <esc>
" imap jk <esc>
" imap kj <esc>

" " The first line maps escape to the caps lock key when you enter Vim, and the second line returns normal functionality to caps lock when you quit.
" " This requires Linux with the xorg-xmodmap package installed.
" au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
" au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

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

" Add literal options for common symbols.
inoremap ;a α
inoremap ;b β
inoremap ;D Δ
inoremap ;d δ
inoremap ;t θ
inoremap ;l λ
inoremap ;m μ
inoremap ;P Π
inoremap ;p π
inoremap ;S Σ
inoremap ;s σ
inoremap ;O Ω
inoremap ;o ω
inoremap ;w ω

" Remap for smoother vertical mobility based on visual lines, not actual lines
" unless a count is included, so that 10j and 10k still work as expected.
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> <Up> (v:count == 0 ? 'g<Up>' : '<Up>')
nnoremap <expr> <Down> (v:count == 0 ? 'g<Down>' : '<Down>')

" Remap for nano-esque jumps to the beginning/end of a line.
" Note: Use `0` to go to the first column of a line.
map <C-a> ^
map <C-e> $
imap <C-a> <C-o>^
imap <C-e> <C-o>$
cnoremap <C-a> <C-b>

" Make control + backspace delete entire words.
" Note:  may not represent control + backspace on your machine.
" To test this, use <C-q> or <C-v> and then hit the desired keys to find the
" literal interpretation.
" TODO: Add functionality to detect camel-case words. Integrate with the
" camelcasemotion plugin.
inoremap  <C-w>
cnoremap  <C-w>
tnoremap  <C-w>

" Easier line navigation with capitalized movement commands.
nnoremap H b
nnoremap L e
noremap <silent> <expr> K (line('.') - search('^\n.\+$', 'Wenb')) . 'kzv^'
noremap <silent> <expr> J (search('^\n.', 'Wen') - line('.')) . 'jzv^'
" In the same vein, make <C-Right> function like other editors.
nnoremap <C-Right> e

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

" I am too lazy to take my hands off shift. command! is preferred over
" cnoremap since you have to hit enter before the string is checked.
command! WQ wq
command! Wq wq
command! W w

" Delete to end of line in insert mode.
inoremap <C-d> <C-o>D
" Note: Delete to beginning of line in insert mode with <C-u>

" Increment with + and decrement with -
noremap + <C-a>
noremap - <C-x>
noremap g+ g<C-a>
noremap g- g<C-x>

" Remap more common undo and redo buttons for non-vimmers.
nnoremap <C-z> u
inoremap <C-z> <C-o>u
nnoremap <C-y> <C-r>
inoremap <C-y> <C-o><C-r>

" Map Ctrl-s to save for non-vimmers.
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>

" Add more sensible paste in insert mode:
if has('nvim')
    inoremap <C-v> <C-r>+
endif

" Map shift-arrows to visual mode (select) for non-vimmers.
nnoremap <S-Left> <C-v><Left>
nnoremap <S-Right> <C-v><Right>
nnoremap <S-Up> <C-v><Up>
nnoremap <S-Down> <C-v><Down>
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <C-Up> {
vnoremap <C-Down> }

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

" Copy everything to the + register and close vim without saving.
" This is used for temporary vim instances.
" Note: Dangerous to use in regular files.
if has('nvim')
    nnoremap <M-End> :%y+<CR>:q!<CR>
    inoremap <M-End> <Esc>:%y+<CR>:q!<CR>
endif

" Also helpful commands to note:
"  Go to the first line of a file: gg
"  Go to the last line of a file: G
"  Go to the fist column of a line: 0
"  Enter normal mode from insert mode: Ctrl + [
"  Open a new window: :sp (on top) or :vsp (side to side)
"  Cut line: dd
"  Paste from Vim clipboard: p
"  Insert tab character in insert mode: Ctrl + v + tab, or Ctrl + q + tab
"    in windows mode, which is the default. Ctrl + i occasionally works, but
"    is not consistent.
"  Run one command and then return automatically to insert mode
"  Automatically fix comment length: gw
"  Jump up 10 lines: 10k
"  Jump down 10 lines: 10j
"  Paste in insert mode: Ctrl + r
"  Select all: :%
"  Access registers: :reg
"  Copy to clipboard register in nvim: "+y
"  Copy all to clipboard (only works in NeoVim): :%y+
"  Check spellcheck suggestions: z=
"  Comment out a line using Vim Commentary plugin: gcc
"  Navigate to next instance of letter: f
"  Navigate to next instance of letter: F
"  Move character one over: xp
"  Replace character: r
"  Delete the rest of the word and enter insert mode: cw

" These are autocommands to override any highlights from plugins.
augroup CustomHighlighting
    " Show Trailing Whitespace
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

" Add Ctrl-R pasting functionality to the terminal.
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

augroup terminal_autocommands

    " Automatically enter insert mode in the terminal.
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert

    " Automatically close a terminal that exited with status 0.
    " Ignore various filetypes as those will close terminal automatically
    " Ignore fzf, ranger, coc
    " TODO: Automatically re-enter the main window instead of the top-left.
    autocmd TermClose term://*
          \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
          \   call nvim_input('<CR>')  |
          \ endif

    " TODO: Add functionality to seek by terminal prompts.
    " " Search for the shell prompt
    " function! GoToPrompt(flags) abort
    "     " Regexp representing my shell prompt
    "     let l:shell_prompt = 'jet@jet-Laptop:'
    "     call search(shell_prompt, a:flags)
    " endfunction

    " " Jump to the previous shell prompt
    " autocmd TermOpen * noremap <buffer> <silent> [g
    "             \ :call GoToPrompt('eb')<cr>
    " " Jump to the next shell prompt
    " autocmd TermOpen * noremap <buffer> <silent> ]g
    "             \ :call GoToPrompt('e')<cr>

    " " Jump to the uppermost shell prompt
    " autocmd TermOpen * nmap <buffer> [G 1G]g
    " " Jump to the 2nd bottommost shell prompt (since you can just use `G` to
    " " go to the 1st bottommost shell prompt)
    " autocmd TermOpen * nmap <buffer> ]G G[g

    " " Doesn't work in visual mode, so unmap it for visual mode
    " autocmd TermOpen * vunmap <buffer> [g
    " autocmd TermOpen * vunmap <buffer> ]g

augroup end

" Open File Explorer
nnoremap <Leader>fe :Lexplore<C-m>

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
    autocmd VimEnter *.md if !exists('g:started_by_firenvim') | Lexplore | wincmd p | endif
    autocmd VimEnter *.py,*.c,*.go,*.rb,*.java,*.js,*.cpp,*.h,*.hpp,*.vim,*.*vimrc,*.ml,*.mli if !exists('g:started_by_firenvim') | call OpenIDEMode() | endif
    " autocmd VimEnter * nested :call tagbar#autoopen(1)  " Only open for supported filetypes.
augroup END

augroup CloseIDEMode
    autocmd QuitPre call ToggleTerminalAtBottom()
augroup end

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
Plug 'plasticboy/vim-markdown'  " Requires 'godlygeek/tabular' before it.
"Plug 'TaskList.vim'  " TODO Checker.
Plug 'daeyun/vim-matlab'
Plug 'bkad/CamelCaseMotion'  " Add CamelCase and snake_case as word objects.
Plug 'coderifous/textobj-word-column.vim'  " Add vertical columns as a word object with `ic` and `ac`.
Plug 'mbbill/undotree'

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

" Virtual Text
let g:ale_warn_about_trailing_whitespac = 0
highlight link ALEVirtualTextStyleError ALEVirtualTextError
highlight link ALEVirtualTextStyleWarning ALEVirtualTextWarning
highlight link ALEVirtualTextError ErrorMsg
highlight link ALEVirtualTextWarning WarningMsg
highlight link ALEVirtualTextInfo Comment

" Add code folding.
set nofoldenable  " Ensure files are opened unfolded.
set foldmethod=syntax  " Add code folding based on syntax.

" Tabular configurations for common auto-alignment commands.
" TODO: Make into a function to accept any input literal.
nnoremap <Leader>a=  :Tabularize /=<CR>
vnoremap <Leader>a=  :Tabularize /=<CR>
nnoremap <Leader>A=  :Tabularize /=\zs<CR>
vnoremap <Leader>A=  :Tabularize /=\zs<CR>
nnoremap <Leader>a:  :Tabularize /:<CR>
vnoremap <Leader>a:  :Tabularize /:<CR>
nnoremap <Leader>A:  :Tabularize /:\zs<CR>
vnoremap <Leader>A:  :Tabularize /:\zs<CR>
nnoremap <Leader>a#  :Tabularize /#<CR>
vnoremap <Leader>a#  :Tabularize /#<CR>
nnoremap <Leader>A#  :Tabularize /#\zs<CR>
vnoremap <Leader>A#  :Tabularize /#\zs<CR>
nnoremap <Leader>a/  :Tabularize /\/\/<CR>
vnoremap <Leader>a/  :Tabularize /\/\/<CR>
nnoremap <Leader>A/  :Tabularize /\/\/\zs<CR>
vnoremap <Leader>A/  :Tabularize /\/\/\zs<CR>
nnoremap <Leader>a\| :Tabularize /\|<CR>
vnoremap <Leader>a\| :Tabularize /\|<CR>
nnoremap <Leader>A\| :Tabularize /\|\zs<CR>
vnoremap <Leader>A\| :Tabularize /\|\zs<CR>


"Markdown
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_fenced_languages = ['csharp=cs','js=javascript','viml=vim','rust','go','help','vim','javascript','cs']
let g:vim_markdown_folding_disabled = 1

" Set pum to be transparent. termguicolors must be enabled for it to look
" nice.
set pumblend=15
highlight PmenuSel blend=0

" Use <Tab> to navigate to the next complete item.
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<Tab>'

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" inoremap <silent><expr> <Tab>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<Tab>" :
"       \ coc#refresh()

" Enable tab and shift-tab for navigation through autocompletion suggestions.
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
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

" " firenvim editor settings
" " TODO: Debug this.
" " TODO: Set GitHub.com to markdown by default, but don't run
" " MarkdownPreview.
" if exists('g:started_by_firenvim') && g:started_by_firenvim
"     let fc = g:firenvim_config['localSettings']
"     " general options
"     set laststatus=0 noshowcmd
"     set cmdheight=2  " Set the height of the command bar at the bottom.
"     nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
"     nnoremap <C-z> :call firenvim#hide_frame()<CR>
" endif

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
            \ 'takeover': 'never',
        \ },
    \ }
\ }

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

" Merlin Configuration
" TODO: Only set the LocalLeader to `Space` if in an Ocaml file.
" autocmd VimEnter *.ml,*.mli let maplocalleader="\<Space>"
nmap <LocalLeader>r  <Plug>(MerlinRename)
nmap <LocalLeader>R  <Plug>(MerlinRenameAppend)

" COC Configuration
" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" CamelCaseMotion
map <silent> <C-Left> <Plug>CamelCaseMotion_b
map <silent> <C-Right> <Plug>CamelCaseMotion_w
imap <silent> <C-Left> <C-o><Plug>CamelCaseMotion_b
imap <silent> <C-Right> <C-o><Plug>CamelCaseMotion_w
imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_b
imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge
" Note: `ie` seems to function like `iw`, and `iw` like `aw`.
omap <silent> iw <Plug>CamelCaseMotion_ie
xmap <silent> iw <Plug>CamelCaseMotion_ie
" omap <silent> aw <Plug>CamelCaseMotion_iw
" xmap <silent> aw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
