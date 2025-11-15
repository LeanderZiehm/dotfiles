" Disable Vi compatibility
colorscheme wildcharm
set nocompatible

" Clipboard
set clipboard=unnamedplus

set is 
set hls
set relativenumber

" Wildmenu & recursive search
set wildmenu
set wildmode=longest:full,full
set path+=**

" Yank highlight
"augroup YankHighlight
 " autocmd!
 " autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup='Yanked', timeout=300})
"augroup END



" Key mappings
nnoremap <C-p> :find<Space>
nnoremap <C-S-P> :vimgrep /<C-r>=expand("<cword>")<CR>/ **/*<CR>:copen<CR>
syntax on
filetype plugin indent on

"blue  darkblue  default  delek  desert  elflord  evening  habamax  industry
"koehler  lunaperche  morning  murphy  pablo  peachpuff  quiet  retrobox  ron
"shine slate  sorbet  torte  unokai  wildcharm  zaibatsu  zellner     



" CHATGPT

" Jump around wrapped lines naturally
"set linebreak
"set showbreak=↪\ 

" Faster scrolling
"nnoremap <C-d> 5j
"nnoremap <C-u> 5k


" Case-insensitive unless uppercase used
set ignorecase
set smartcase

" Incremental search
set incsearch
set hlsearch


" Persistent undo
"set undofile
"set undodir=~/.vim/undodir

" Backup and swap files in a separate directory
"set backupdir=~/.vim/backup//
"set directory=~/.vim/swap//
"set backup
"set swapfile


" Better indentation
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab

" Show matching brackets
set showmatch


" Simple statusline
"set laststatus=2
"set statusline=%f\ %y\ %m\ %r\ [%{&ff}]\ [%l,%c]

" Show tabs as spaces
"set list
"set listchars=tab:▸\ ,trail:·
" Define the highlight group
"highlight Yanked ctermbg=yellow guibg=yellow

" Clear any existing autocmds in this group
"augroup YankHighlight
 " autocmd!

  " Highlight yanked text
 " autocmd TextYankPost * call s:HighlightYank()
"augroup END

" Function to temporarily highlight yanked text
"function! s:HighlightYank() abort
 " if v:event.operator ==# 'y' && v:event.regname !=# ''
    " Get the range of the yank
  "  silent! execute 'normal! gvy'
    " Highlight the last yanked text with the Yanked group
   " silent! execute 'match Yanked /\%' . line("'<") . 'l\%' . col("'<") . 'c.*\%' . line("'>") . 'l\%' . col("'>") . 'c/'
    " Clear the highlight after 300ms
    "call timer_start(300, {-> execute('match none')})
  "endif
"endfunction




" Cursor line and column
set cursorline
"set cursorcolumn

" Show line and column in statusline
set ruler

" Highlight current line
hi CursorLine cterm=none ctermbg=236 guibg=Grey20

