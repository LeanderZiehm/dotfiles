" Disable Vi compatibility
colorscheme unokai " wildcharm
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
"
"
"
"
"###################
set laststatus=2
set statusline=
set statusline=%f\ %y\ %m\ %r\ [%{&ff}]\ [%l,%c]
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
"Highlight on? function:

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction
"Colors (adapted from ligh2011.vim):

hi User1 guifg=#ffdad8  guibg=#880c0e
hi User2 guifg=#000000  guibg=#F4905C
hi User3 guifg=#292b00  guibg=#f4f597
hi User4 guifg=#112605  guibg=#aefe7B
hi User5 guifg=#051d00  guibg=#7dcc7d
hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
hi User8 guifg=#ffffff  guibg=#5b7fbb
hi User9 guifg=#ffffff  guibg=#810085
hi User0 guifg=#ffffff  guibg=#094afe

" Key mappings
nnoremap <C-p> :find<Space>
nnoremap <C-S-P> :vimgrep /<C-r>=expand("<cword>")<CR>/ **/*<CR>:copen<CR>
syntax on
filetype plugin indent on

"blue  darkblue  default  delek  desert  elflord  evening  habamax  industry
"koehler  lunaperche  morning  murphy  pablo  peachpuff  quiet  retrobox  ron
"shine slate  sorbet  torte  unokai  wildcharm  zaibatsu  zellner     

" In normal mode, press # to comment the current line
nnoremap # I#<Esc>
"nnoremap # :s/^#\?/#/<CR>


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

