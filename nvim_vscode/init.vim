
" install vim-plug
"
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" vim-easymotion
Plug 'asvetliakov/vim-easymotion'
nmap <Space>s <Plug>(easymotion-s2)
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <Space>j <Plug>(easymotion-j)
map <Space>k <Plug>(easymotion-k)

"EdgeMotion
Plug 'haya14busa/vim-edgemotion'
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

" clever-f.vim
Plug 'rhysd/clever-f.vim'

" surround.vim
Plug 'tpope/vim-surround'

call plug#end()

"キーバインド
"ESC -> JJ
inoremap <silent> jj <ESC>
"cursol move in insertmode
inoremap <C-h> <left>
inoremap <C-l> <right>
"cursol move
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
nnoremap gj j
nnoremap gk k
