set tabstop=4
set shiftwidth=4
set expandtab
set incsearch
set hlsearch
set ignorecase
set smartcase
set number
set autoindent
set smartindent
set list
map k gk
map j gj

execute pathogen#infect()

" Use space as the easymotion prefix key
exe "map <Space> <Plug>(easymotion-prefix)"
