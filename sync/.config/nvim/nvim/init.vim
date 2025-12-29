"source ~/.vimrc


" make vim more vscode like with keyboard shortcuts
nnoremap <C-Down> :m .+1<CR>==
" Move current line up with Ctrl + Up
nnoremap <C-Up> :m .-2<CR>==
" Move current line down with Shift+Down (normal mode)
nnoremap <S-Down> :m .+1<CR>==
" Move current line up with Shift+Up (normal mode)
nnoremap <S-Up> :m .-2<CR>==



lua require('init')
