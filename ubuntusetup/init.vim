" My settings
set tabstop=4
set expandtab
set shiftwidth=4
set cindent
colorscheme elflord

set relativenumber

" Pathogen Settings
execute pathogen#infect()

" Disable middle click paste
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

" Set no bells
set noeb vb t_vb=
au GUIEnter * set vb t_vb=

" Set line numbers
set nu
set mouse=a		" Enable mouse usage (all)

nnoremap <Leader>f :Ack!<Space>
nnoremap <Leader>F :Ack! -n<Space>

autocmd! BufWritePost * Neomake
let g:neomake_tex_enabled_makers = []

let g:neomake_python_flake8_maker = {
            \ 'args': ['--ignore=F401,F841,W2,W3,E2,E3,E401,E501, E121, E122, E123, E124, E125, E126, E127, E128, E129, E131, E133'],
            \ 'errorformat':
            \ '%E%f:%l: could not compile,%-Z%p^,' .
            \ '%A%f:%l:%c: %t%n %m,' .
            \ '%A%f:%l: %t%n %m,' .
            \ '%-G%.%#',
            \}
let g:neomake_python_enabled_makers = ['flake8']

let g:ycm_autoclose_preview_window_after_completion = 1 " autoclose YCM preview window
let g:ycm_show_diagnostics_ui = 0
let g:ycm_python_binary_path = '/usr/bin/python3'

let g:python_host_prog = '/usr/bin/python3'

" Vim airline 
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

set laststatus=2
set noshowmode
map <C-BS> <C-W>
imap <C-BS> <C-W>
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>


command Fp echo @%
map <C-f> :NERDTreeToggle<CR>

vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Vim LaTeX PDF Preview
let g:livepreview_previewer = 'evince'

set hlsearch
nnoremap <C-N> :noh <CR>
nnoremap <Leader>b :Hbash <CR>

" Neovim stuff
if has('nvim')
    :tnoremap <Esc> <C-\><C-n>
    :tnoremap <a> <i>
    :tnoremap <A> <i>
    :tnoremap <o> <i>
    command Hbash bot split term://bash | resize 8
    command Bash terminal bash
endif
