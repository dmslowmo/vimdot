
" begin Vundle Settings
" -------------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" vim sugar for common UNIX shell commands
Plugin 'tpope/vim-eunuch'
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" code completion plugin
Plugin 'SirVer/ultisnips'
" ctrl-p for file search
Plugin 'kien/ctrlp.vim'
" ctrl-p extension for faster and better search
Plugin 'jlanzarotta/bufexplorer'
" JSON plugin
Plugin 'elzr/vim-json'
" syntax checker
Plugin 'scrooloose/syntastic'
" nerdtree file explorer
Plugin 'scrooloose/nerdtree'
" tab enhancement for nerdtree
Plugin 'jistr/vim-nerdtree-tabs.git'
" ctags tag file updater
Bundle 'craigemery/vim-autotag'
" plugin for javascript
Plugin 'pangloss/vim-javascript'
" plugin to display the tags of current file in a sidebar
Bundle 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" end Vundle Settings
" -------------------------------------------------------------------



" === ctags settings ===
" static tags
" set tags=/home/dmartana/workspace/lego/tags;/home/dmartana/workspace/Epoxy/web/epoxy/tags;/
" dynamic tags
autocmd BufWritePost *
	\if filereadable('tags') |
	\	call system('ctags -a '.expand('%')) |
	\endif

"	jump to the func/var definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>



" === vim-autotag settings ==
let g:autotagTagsFile="/home/dmartana/workspace/lego/tags"



" === cscope settings ===
nmap <C-@><C-@> :cs find s <C-R>=expand("<cword>")<CR><CR>
cs add $CSCOPE_DB
set csre
" function to load cscope db automatically
function! LoadCscope()
	let db = findfile("cscope.out", ".;")
	if (!empty(db))
		let path = strpart(db, 0, match(db, "/cscope.out$"))
		set nocscopeverbose " suppress 'duplicate connection' error
		exe "cs add " . db . " " . path
		set cscopeverbose
	endif
endfunction
" call LoadCscope()
au BufEnter * silent



" === ctrlp settings ===
let g:ctrlp_max_files = 0
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']

" === nerdtree settings ===
map <leader>r :NERDTreeFind<CR>
map <C-n> :NERDTreeToggle<CR>

" == tagbar settings ==
nmap <F8> :TagbarToggle<CR>

" Source the vimrc file after saving it
if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif

" === vim-javascript settings ===
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1


" -------------------------------------------------------------------
" Put your non-Plugin stuff after this line

set ts=4				" tab stop
set sw=4				" indenting is 4 spaces
set background=dark		" background color
set number				" line no
set autoread			" auto-refresh file being viewed
filetype plugin on
filetype plugin indent on
syntax on

" ---- show tabs and trailing spaces as special chars ----
set list
set listchars=tab:▶\ ,trail:■ " DO NOT REMOVE THE SQUARE! That square is what you want to display as trailing space!

set hlsearch			" highlight search term
set colorcolumn=121		" highlight the nth column, as line length limit
set mouse=n				" enable mouse click in vim concoles
set ttymouse=xterm2		" used together with mouse=n
set noexpandtab			" use tabs, not spaces
set showmatch			" cursor will briefly jump to the matching brace when one is inserted
set matchtime=3			" duration in tenths of a second for the cursor to move to matching brace
set smartindent			" does the right thing (mostly) in programs

" custom setting for different file types
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0

autocmd BufEnter * silent! lcd %:p:h     " automatically change the current dir to the dir of the opened file

" --- switch between c/cpp file and header file
nnoremap <Leader>]c :e %<.c<CR>
nnoremap <Leader>]C :e %<.cpp<CR>
nnoremap <Leader>]h :e %<.h<CR>
nnoremap <Leader>[c :tabnew %<.c<CR>
nnoremap <Leader>[C :tabnew %<.cpp<CR>
nnoremap <Leader>[h :tabnew %<.h<CR>

" --- moving tab location back or forward by 1 ---
map <S-F11> :tabm -1<CR>
map <S-F12> :tabm +1<CR>
" -------------------------------------------------------------------
