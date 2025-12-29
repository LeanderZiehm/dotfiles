" If you want highlighting use neovim
" todo: multi row commenting (need to figure out how do do functions with
" multi arguments
"# Settings 
syntax on
filetype indent on
set nocompatible

" enable mouse
set mouse=a


let mapleader = " "
" make vim more vscode like with keyboard shortcuts
nnoremap <C-Down> :m .+1<CR>==
vnoremap <C-Down> :m .+1<CR>==
" Move current line up with Ctrl + Up
nnoremap <C-Up> :m .-2<CR>==
vnoremap <C-Up> :m .-2<CR>==
" Move current line down with Shift+Down (normal mode)
nnoremap <S-Down> :m .+1<CR>==
vnoremap <S-Down> :m .+1<CR>==
" Move current line up with Shift+Up (normal mode)
nnoremap <S-Up> :m .-2<CR>==
vnoremap <S-Up> :m .-2<CR>==



"# Search
" Wildmenu & recursive search
set wildmenu
set wildmode=longest:full,full
set path=
"set path+=**

" Case-insensitive unless uppercase used
set ignorecase
set smartcase

" Incremental search
set incsearch
set hlsearch

nnoremap ,p "0p
nnoremap <Space> o<Esc>


set scrolloff=10

" Clipboard
set clipboard=unnamedplus
set is 
set hls


" VISUAL SETTINGS

colorscheme unokai " wildcharm
set number
"set relativenumber
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
"set showmatch
set cursorline
"set ruler
"set colorcolumn=80


"# Persistence
set viminfo='100,<50,s10,h

" Automatically jump to the last cursor position when reopening a file
if has("autocmd")
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif

" Persistent undo setup
let s:undodir = expand('~/.vim/undo')

" Make sure undo dir exists
if !isdirectory(s:undodir)
    call mkdir(s:undodir, 'p')
endif

" Enable persistent undo
set undofile
set undodir=s:undodir






nnoremap <leader>h :tab help<space>
autocmd FileType help nnoremap <buffer> q :tabclose<CR>



" autoreload vimrc if changed
"autocmd BufEnter $MYVIMRC nnoremap <buffer> <leader>r :w<CR>:source $MYVIMRC<CR>
autocmd BufEnter $MYVIMRC nnoremap <leader>r :w<CR>:source $MYVIMRC<CR>:echo "vimrc reloaded"<CR>
"autocmd BufWritePost $MYVIMRC source $MYVIMRC



"# Search and Explore

:set shortmess-=S


nnoremap <Leader>b :ls<CR>:buffer<Space>
"nnoremap <Leader>f :find <C-d>

" TODO make find work well in a certain directory
"nnoremap <Leader>ff :find ~/dev/wiki/**<CR>


"nnoremap <Leader>ff :lcd %:p:h<Bar>echo "Root set to ".getcwd()<Bar>find "
"nnoremap <Leader>fF :find<space>

"nnoremap <C-p> :find<Space>
"blue  darkblue  default  delek  desert  elflord  evening  habamax  industry
"koehler  lunaperche  morning  murphy  pablo  peachpuff  quiet  retrobox  ron
"shine slate  sorbet  torte  unokai  wildcharm  zaibatsu  zellner     



nnoremap <leader>ss :call CenteredCmdlineSearch()<CR>

function! CenteredCmdlineSearch()
  botright new
  resize 3
  execute "normal! q/"
endfunction







" Key mappings

" VSCODE Like 
nnoremap <C-p> :browse find<Space>
nnoremap <C-S-P> :vimgrep /<C-r>=expand("<cword>")<CR>/ **/*<CR>:copen<CR>


":set path+=~/dev/**
":find filename.txt




" Helper: show a popup with matches and allow selection
"function! s:PopupSelect(matches) abort
    "if empty(a:matches)
        "echo "No matches found"
        "return ''
    "endif
    " Create popup window
    "let id = popup_create(a:matches, #{
                \ minwidth: 50,
                \ minheight: 10,
                \ border: [],
                \ cursorline: 1,
                \ scroll: 1,
                \ mapping: 1,
                \ title: 'Select a file'
                \ })
    
    " Wait for user to select
    "let choice = input("Enter number to open file (empty to cancel): ")
    "call popup_close(id)
"
    "if choice =~ '^\d\+$' && choice >= 1 && choice <= len(a:matches)
        "return a:matches[choice - 1]
    "endif
    "return ''
"endfunction
"
" Helper: search files recursively in a given path
"function! s:SearchFiles(path) abort
    "let files = split(globpath(a:path, '**/*', 0, 1), "\n")
    "return files
"endfunction

" Main search function with interactive popup
"function! s:FileSearch(path) abort
    "let files = s:SearchFiles(a:path)
    "if empty(files)
        "echo "No files found"
        "return
    "endif
    " Optional: filter by user input
    "let term = input("Search term (leave empty for all): ")
    "if !empty(term)
        "let files = filter(copy(files), {_, v -> v =~ term})
    "endif
    "let selected = s:PopupSelect(files)
    "if !empty(selected)
        "execute "edit " . fnameescape(selected)
    "endif
"endfunction

" =============================
" Leader mappings for different scopes
" =============================
" fd -> ~/dev
"nnoremap <leader>fd :call <sid>FileSearch(expand('~/dev'))<CR>
" fc -> ~/.conf
"nnoremap <leader>fc :call <sid>FileSearch(expand('~/.conf'))<CR>
 "ff -> current file directory and subdirs
"nnoremap <leader>ff :call <sid>FileSearch(expand('%:p:h'))<CR>
" fF -> home with all subdirs
"nnoremap <leader>fF :call <sid>FileSearch(expand('~'))<CR>





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

" Yank highlight in vimrc in vim but its not working 
" Define highlight
"highlight Yanked ctermbg=yellow ctermfg=black guibg=yellow guifg=black

" Function to highlight yanked text
"function! HighlightYank()
  "if v:event.operator ==# 'y'
     "Highlight the yanked region
    "let l:matchid = matchadd('Yanked', '\%'.line("'<").'l.*')
     "Remove the highlight after 300ms
    "call timer_start(300, { -> matchdelete(l:matchid) })
  "endif
"endfunction
"
" Autocmd
"augroup YankHighlight
  "autocmd!
  "autocmd TextYankPost * call HighlightYank()
"augroup END




"# Save
"nnoremap <leader>s :w<CR>
"nnoremap <C-s> :w<CR>

" auto save 
"autocmd TextChanged,TextChangedI <buffer> silent write
"autocmd CursorHoldI,CursorHold * silent! update


"set scrolloff = 10
" highlight CursorColumn ctermbg=darkgrey ctermfg=black
" map <leader>c :set cursorline! cursorcolumn!<CR>



" highlight MyName guifg=Red ctermfg=Red



" ===========================
" HIGHLIGHTS
" ===========================
"  Question  TODO   Todo  
" Use a function for all custom highlights
"function! MyHighlights() abort
    " Highlight current line
    " hi CursorLine cterm=none ctermbg=236 guibg=Grey20

    " Highlight the first line
    " hi FirstLine ctermbg=236 guibg=Grey20
    " call matchadd('FirstLine', '\%1l.*')
" 
    " Highlight even lines
    " hi EvenLines ctermbg=236 guibg=Grey20
    " let l:num = 2
    " while l:num <= line('$')
        " call matchadd('EvenLines', '\%' . l:num . 'l.*')
        " let l:num += 2
    " endwhile

    " Highlight lines starting with #
    " hi CommentLine ctermbg=236 guibg=Grey20
    " syntax match CommentLine /^#.*/ 
    " highlight link CommentLine Comment

    " Highlight lines containing TODO
    " hi TodoLine cterm=bold ctermbg=236 guibg=Yellow
    " syntax match TodoLine /TODO/

    " Highlight lines containing Question
    " hi MyQuestions guifg=red guibg=green
    " syntax match MyQuestions /Question/
" endfunction

" ===========================
" APPLY HIGHLIGHTS SAFELY
" ===========================
" augroup MyColors
    " autocmd!
    " Apply highlights whenever a colorscheme is loaded
    " autocmd ColorScheme * call MyHighlights()
" augroup END

" If a colorscheme is already loaded, apply highlights immediately
" if exists("colors_name")
    " doautocmd ColorScheme
" endif

" Comments
function! ToggleCommentLine(range)
  let l:cs = &commentstring
  if empty(l:cs)
    return
  endif

  let l:prefix = substitute(l:cs, '%s', '', '')
  let l:prefix = substitute(l:prefix, '\s*$', '', '')

  " Determine the range of lines
  let l:start = a:firstline
  let l:end = a:lastline

  for l:num in range(l:start, l:end)
    let l:line = getline(l:num)
    if l:line =~ '^\s*' . escape(l:prefix, '/*$.')
      " Uncomment
      call setline(l:num, substitute(l:line, '^\(\s*\)' . escape(l:prefix, '/*$.'), '\1', ''))
    else
      " Comment
      call setline(l:num, substitute(l:line, '^\(\s*\)', '\1' . l:prefix . '', ''))
    endif
  endfor
  normal! j
endfunction

" Map normal mode
nnoremap # :call ToggleCommentLine(line('.'))<CR>

" Map visual mode (doesnt work yet. TODO needs fixing)
vnoremap # :<C-U>call ToggleCommentLine('<,'>)<CR>











" PLUGINS 


" Minimal Vim plugin manager using git

"function! InstallPlugin(repo_url)
     "Extract plugin name from URL
    "let l:parts = split(a:repo_url, '/')
    "let l:name = substitute(l:parts[-1], '\.git$', '', '')

    " Set installation directory
    "let l:dir = expand('~/.vim/pack/plugins/start/' . l:name)

    " Check if plugin already exists
    "if !isdirectory(l:dir)
        "echo 'Installing ' . l:name . '...'
        " Use system git clone
        "call system(['git', 'clone', a:repo_url, l:dir])
        "echo l:name . ' installed!'
    "else
        "echo l:name . ' already installed.'
    "endif
"endfunction


"function! InstallPlugin(repo_url, post_install)
    "let l:parts = split(a:repo_url, '/')
    "let l:name = substitute(l:parts[-1], '\.git$', '', '')
    "let l:dir = expand('~/.vim/pack/plugins/start/' . l:name)
"
    "if !isdirectory(l:dir)
        "echo 'Installing ' . l:name . '...'
        "call system(['git', 'clone', a:repo_url, l:dir])
        "echo l:name . ' installed!'
        "if a:post_install != ''
            "execute a:post_install
        "endif
    "else
        "echo l:name . ' already installed.'
    "endif
"endfunction

" Example usage
"call InstallPlugin('https://github.com/junegunn/fzf.git', 'call fzf#install()')

" List your plugins here
"call InstallPlugin('https://github.com/vimwiki/vimwiki.git')
"call InstallPlugin('https://github.com/junegunn/fzf.git')
"call InstallPlugin('https://github.com/junegunn/fzf.vim.git')


"hello
"
"call plug#begin()

" List your plugins here
"Plug 'tpope/vim-sensible'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
"Plug 'vimwiki/vimwiki'

"call plug#end()

" 1. VIM WIKI
"# vim vimwiki settings
set nocompatible
filetype plugin on
syntax on


let g:vimwiki_list = [{'path': '~/dev/wiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]
let g:vimwiki_global_ext = 0


" File Explorer
nnoremap <C-b> :Lex<Esc>
nnoremap <leader>e :Lex<Esc>
nnoremap <leader>n :Lex<Esc>
" nnoremap <leader>dd :Lexplore %:p:h<CR>



" Netrw basic settings
let g:netrw_keepdir = 0
let g:netrw_winsize = 20
let g:netrw_banner = 0
let g:netrw_localcopydircmd = 'cp -r'

":set modifiable  " some weird bug that doesnt let me create a new file or folder 
" Highlight for marked files (optional)
"augroup netrw_mark_highlight
    "autocmd!
    "autocmd ColorScheme * hi! link netrwMarkFile Search
"augroup END

" Function to define buffer-local keymaps for Netrw
function! NetrwMapping()
    " Navigation
    nmap <buffer> h -^           
    nmap <buffer> l <CR>         
    nmap <buffer> . gh           

    " File/Directory management
    nmap <buffer> af %:w<CR>:buffer #<CR>
    nmap <buffer> ad :call mkdir(input('New directory name: '), 'p')<CR>
    nmap <buffer> r R         

    nmap <buffer> q :Lex<Esc>
    nmap <buffer> <Esc> :Lex<Esc>

    "nmap <buffer> fx mm           " Move marked files
    "nmap <buffer> fX mtmm         " Move marked files to target
    "nmap <buffer> fD :call DeleteMarked()<CR> " Delete marked files/dirs

    " Marks (commented out)
    " nmap <buffer> <TAB> mf        " Mark file/directory
    " nmap <buffer> <S-TAB> mF      " Unmark all

    " External commands (commented out)
    " nmap <buffer> f; mx
endfunction

" Call the function automatically whenever a Netrw buffer is opened
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

" Delete function for marked files/dirs
"function! DeleteMarked()
    "echo "Deleting marked files..."
    "normal! m`            " Save cursor position
    " normal! mf          " Optional: mark current file if needed
    "let marks = netrw#DirListMarked()
    "for m in marks
        "if isdirectory(m)
            "call delete(m, 'rf') " Recursively delete directories
        "else
            "call delete(m)
        "endif
    "endfor
    "echo "Deleted marked files/dirs."
"endfunction






let g:search_count_status = '-'

function! UpdateSearchCount() abort
  if !v:hlsearch
    let g:search_count_status = ''
    return
  endif

  let l:sc = searchcount()
  if l:sc.total > 0
    let g:search_count_status = l:sc.current . '/' . l:sc.total
  else
    let g:search_count_status = ''
  endif
endfunction


augroup SearchCountStatus
  autocmd!
  autocmd CmdlineLeave /,? call UpdateSearchCount()
  autocmd CursorMoved,CursorMovedI * call UpdateSearchCount()
augroup END


"# Status Line
set laststatus=2 " always show status bar


set statusline=
set statusline+=%7*\[%n]                                  " buffernr
set statusline+=%1*\ %<%F\                                " File+path
set statusline+=%2*\ %y\                                  " FileType
set statusline+=%8*\ %=\                                 " Right align
set statusline+=%3*\-%{g:search_count_status}-\ 
set statusline+=%8*\ %=\                                 " Right align
set statusline+=%8*\ %l/%L\                               " Rownumber/total


"set statusline=
"set statusline+=%7*\[%n]                                  "buffernr
"set statusline+=%1*\ %<%F\                                "File+path
"set statusline+=%2*\ %y\                                  "FileType
"set statusline+=%3*\ %{g:search_count_status}\ 
"set statusline+=%8*\ %=\ %l/%L\             "Rownumber/total





"set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
"set statusline+=%9*\ col:%03c\                            "Colnr
"set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

"set statusline+=%=\ autosave_enabled

" set statusline=
" set statusline=%f\ %y\ %m\ %r\ [%{&ff}]\ [%l,%c]
" set statusline +=%1*\ %n\ %*            "buffer number
" set statusline +=%5*%{&ff}%*            "file format
" set statusline +=%3*%y%*                "file type
" set statusline +=%4*\ %<%F%*            "full path
" set statusline +=%2*%m%*                "modified flag
" set statusline +=%1*%=%5l%*             "current line
" set statusline +=%2*/%L%*               "total lines
" set statusline +=%1*%4v\ %*             "virtual column number
" set statusline +=%2*0x%04B\ %*          "character under cursor


"Highlight ????

"function! HighlightSearch()
  "if &hls
    "return 'H'
  "else
    "return ''
  "endif
"endfunction
"Colors (adapted from ligh2011.vim):

"hi User1 guifg=#ffdad8  guibg=#880c0e
"hi User2 guifg=#000000  guibg=#F4905C
"hi User3 guifg=#292b00  guibg=#f4f597
"hi User4 guifg=#112605  guibg=#aefe7B
"hi User5 guifg=#051d00  guibg=#7dcc7d
"hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
"hi User8 guifg=#ffffff  guibg=#5b7fbb
"hi User9 guifg=#ffffff  guibg=#810085
"hi User0 guifg=#ffffff  guibg=#094afe
