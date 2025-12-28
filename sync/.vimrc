"packadd vimwiki

"# personal settings
let mapleader = " "

" make vim more vscode like with keyboard shortcuts
nnoremap <C-Down> :m .+1<CR>==

" Move current line up with Ctrl + Up
nnoremap <C-Up> :m .-2<CR>==

" File Explorer
nnoremap <C-b> :Lex<Esc>
nnoremap <leader>e :Lex<Esc>
nnoremap <leader>n :Lex<Esc>
nnoremap <leader>dd :Lexplore %:p:h<CR>

" press # to comment the current line (currently is not file extension aware
" so it only works for filetypes using hashtag comments)
nnoremap # I#<Esc>


"# Settings 
syntax on
filetype indent on
set nocompatible
" Case-insensitive unless uppercase used
set ignorecase
set smartcase

" Incremental search
set incsearch
set hlsearch


"set scrolloff = 10
set scrolloff=10

" Disable Vi compatibility
colorscheme unokai " wildcharm
" Clipboard
set clipboard=unnamedplus
set is 
set hls
"set relativenumber
set number

set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set showmatch
set cursorline
set ruler
" Highlight current line
hi CursorLine cterm=none ctermbg=236 guibg=Grey20



" Wildmenu & recursive search
set wildmenu
set wildmode=longest:full,full
set path+=**
" Key mappings
"nnoremap <C-p> :find<Space>
"nnoremap <C-S-P> :vimgrep /<C-r>=expand("<cword>")<CR>/ **/*<CR>:copen<CR>
"blue  darkblue  default  delek  desert  elflord  evening  habamax  industry
"koehler  lunaperche  morning  murphy  pablo  peachpuff  quiet  retrobox  ron
"shine slate  sorbet  torte  unokai  wildcharm  zaibatsu  zellner     

"nnoremap # :s/^#\?/#/<CR>
" Persistent undo
"set undofile
"set undodir=~/.vim/undodir
" Backup and swap files in a separate directory
"set backupdir=~/.vim/backup//
"set directory=~/.vim/swap//
"set backup
"set swapfile
" Better indentation

" Yank highlight
"augroup YankHighlight
 " autocmd!
 " autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup='Yanked', timeout=300})
"augroup END

" PLUGINS 
"
" 1. VIM WIKI
"# vim vimwiki settings
set nocompatible
filetype plugin on
syntax on


let g:vimwiki_list = [{'path': '~/dev/wiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]
let g:vimwiki_global_ext = 0




let g:netrw_keepdir = 0
let g:netrw_winsize = 20
let g:netrw_banner = 0
"let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
"let g:netrw_hide = 1

let g:netrw_localcopydircmd = 'cp -r'

augroup netrw_mark_highlight
  autocmd!
  autocmd ColorScheme * hi! link netrwMarkFile Search
augroup END

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

" Function to define buffer-local keymaps for Netrw
function! NetrwMapping()
  " Navigation
  nmap <buffer> H u            " H: Go back in history (like pressing 'u' in Netrw)
  nmap <buffer> h -^           " h: Go up one directory
  nmap <buffer> l <CR>         " l: Open directory or file

  nmap <buffer> . gh           " .: Toggle dotfiles
  nmap <buffer> P <C-w>z       " P: Close the preview window

  nmap <buffer> L <CR>:Lexplore<CR>  " L: Open file and close Netrw
  nmap <buffer> <Leader>dd :Lexplore<CR> " <Leader>dd: Close Netrw

  " Marks
  nmap <buffer> <TAB> mf        " TAB: Mark file/directory
  nmap <buffer> <S-TAB> mF      " Shift+TAB: Unmark all in buffer
  nmap <buffer> <Leader><TAB> mu " Leader+TAB: Clear all marks

  " File management prefix 'f'
  nmap <buffer> ff %:w<CR>:buffer #<CR> " ff: Create new file and return to Netrw
  nmap <buffer> fe R            " fe: Rename file
  nmap <buffer> fc mc           " fc: Copy marked files
  nmap <buffer> fC mtmc         " fC: Copy marked files to target directory
  nmap <buffer> fx mm           " fx: Move marked files
  nmap <buffer> fX mtmm         " fX: Move marked files to target
  nmap <buffer> f; mx           " f;: Run external command on marked files

  " Bookmarks
  nmap <buffer> bb mb           " bb: Create bookmark
  nmap <buffer> bd mB           " bd: Remove most recent bookmark
  nmap <buffer> bl gb           " bl: Jump to most recent bookmark
endfunction

" Call the function automatically whenever a Netrw buffer is opened
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END


"# Status Line
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




"Highlight ????

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

