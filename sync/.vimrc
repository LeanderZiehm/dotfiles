" Disable Vi compatibility
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
highlight Yanked guibg=Yellow guifg=NONE
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="Yanked", timeout=300}
augroup END

" Key mappings
nnoremap <C-p> :find<Space>
nnoremap <C-S-P> :vimgrep /<C-r>=expand("<cword>")<CR>/ **/*<CR>:copen<CR>
syntax on
filetype plugin indent on
colorscheme wildcharm

"blue  darkblue  default  delek  desert  elflord  evening  habamax  industry
"koehler  lunaperche  morning  murphy  pablo  peachpuff  quiet  retrobox  ron
"shine slate  sorbet  torte  unokai  wildcharm  zaibatsu  zellner     


 
