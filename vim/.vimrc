" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

" Runtime Path {
  runtime bundle/pathogen/autoload/pathogen.vim
  call pathogen#infect()
  call pathogen#helptags()

  " add golang configs to runtimepath
  if isdirectory($GOROOT . "/misc/vim" )
    call pathogen#surround( $GOROOT . "/misc/vim" )
  endif
  if isdirectory($GOPATH . "/src/github.com/golang/lint/misc/vim")
    call pathogen#surround($GOPATH . "/src/github.com/golang/lint/misc/vim")
  endif
" }

" General {
  set nocompatible " get out of vi-compatibility mode
  set backspace=indent,eol,start " backspace over everything in insert mode
  set history=9999 " keep plenty of history
  set undodir^=~/.vim/undo
  set hidden "allow changing buffers without saving
  set wildmenu wildmode=list:longest,full
  set modelines=5
  filetype plugin indent on " load filetype plugin/indent settings
" }

" Vim UI {
  set ruler                      " always show the cursor position
  set showcmd                    " display incomplete commands
  set incsearch                  " do incremental searching
  set ignorecase smartcase       " smart case matching

  set tabstop=2 shiftwidth=2 expandtab  " 2 space indents
  set listchars=tab:>-,trail:-,extends:>,precedes:<
  set number                     " show line numbers

  " Scrolling
  set scrolloff=3
  set sidescroll=1
  set sidescrolloff=10
" }

" Colors {
  try
    set background=dark
    colorscheme solarized
    syntax on
    set hlsearch
  catch /E185:/
    colorscheme default
  endtry

  " Customize solarized color
  if exists('g:colors_name') && g:colors_name == 'solarized'
    let g:solarized_termtrans = 0
    colorscheme solarized
  endif
" }

" Mappings {
  let mapleader = ";"

  " Don't use Ex mode, use Q for formatting
  map Q gq

  " Use sane regexes.
  nnoremap / /\v
  vnoremap / /\v

  noremap j gj
  noremap k gk

  " Join lines and restore cursor location (J)
  nnoremap J mjJ`j

  " Buffer navigation (,,) (,]) (,[) (,ls)
  nmap <leader>; <C-^>
  " :map <leader>] :bnext<CR>
  " :map <leader>[ :bprev<CR>
  nmap <leader>ls :buffers<CR>

  inoremap jk <ESC>

  nmap <silent> <leader>p :set invpaste paste?<CR>
  nmap <silent> <leader>r :redraw!<CR>:redrawstatus!<CR>

  nmap <silent> <leader>ff :NERDTreeTabsToggle<CR>
  nmap <silent> <leader>fs :NERDTreeFind<CR>
  nmap <silent> <leader>tt :TagbarToggle<CR>

  " tab navigation
  nmap <silent> <leader>tn :tabnew<CR>
  nmap <silent> <leader>tc :tabclose<CR>

  nmap <silent> <leader>sc :SyntasticCheck<CR>:Errors<CR>
  nmap <silent> <leader>st :SyntasticToggleMode<CR>

  nmap <silent> <leader>god :Godoc<CR>
  nmap <silent> <leader>gof mg:%!gofmt<CR>`g

  nnoremap <leader>u :GundoToggle<CR>

  " move around split windows with ctrl
  map <c-h> <c-w>h
  map <c-j> <c-w>j
  map <c-k> <c-w>k
  map <c-l> <c-w>l
" }

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

augroup END

" Functions {
  " Convenient command to see the difference between the current buffer and the
  " file it was loaded from, thus the changes you made.
  " Only define it when not defined already.
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
  endif
" }


" Plugins {
  " automatically show diff when running 'git commit'
  autocmd BufRead *.git/COMMIT_EDITMSG DiffGitCached | wincmd p

  source $VIMRUNTIME/macros/matchit.vim

  let g:localvimrc_ask = 0

  let g:statline_fugitive = 1
  let g:statline_filename_relative = 1

  " auto-close NERDtree if it's the only thing running
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

  let g:gundo_preview_bottom = 1
  let g:nerdtree_tabs_startup_cd = 1
  let NERDTreeShowHidden=1
  let NERDTreeIgnore=['\~$', '\.swp$', '\.pyc$']
  let NERDTreeMapOpenVSplit="v"
  let NERDTreeMapOpenSplit="s"
" }

" Google-specific settings {
  if filereadable($HOME . "/.vim/google.vim")
    source $HOME/.vim/google.vim
  endif
" }
