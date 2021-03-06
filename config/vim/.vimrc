" The following line is useful to navigate through this .vimrc using fold
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell noexpandtab:

" General {
	" Use Vim settings, rather than Vi settings (much better!).  This must be
	" first, because it changes other options as a side effect.
	set nocompatible

	" allow backspacing over everything in insert mode
	set backspace=indent,eol,start

	if has("vms")
	  set nobackup		" do not keep a backup file, use versions instead
	else
	  set backup		" keep a backup file
	endif
	set history=50		" keep 50 lines of command line history
	set ruler		" show the cursor position all the time
	set showcmd		" display incomplete commands
	set incsearch		" do incremental searching

	" Don't use Ex mode, use Q for formatting
	map Q gq

	" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
	" so that you can undo CTRL-U after inserting a line break.
	inoremap <C-U> <C-G>u<C-U>

	" In many terminal emulators the mouse works just fine, thus enable it.
	if has('mouse')
	  set mouse=a
	endif

	" Switch syntax highlighting on, when the terminal has colors
	" Also switch on highlighting the last used search pattern.
	if &t_Co > 2 || has("gui_running")
	  syntax on
	  set hlsearch
	endif

	" Only do this part when compiled with support for autocommands.
	if has("autocmd")

	  " Enable file type detection.
	  " Use the default filetype settings, so that mail gets 'tw' set to 72,
	  " 'cindent' is on in C files, etc.
	  " Also load indent files, to automatically do language-dependent indenting.
	  filetype plugin indent on

	  " Put these in an autocmd group, so that we can delete them easily.
	  augroup vimrcEx
	  au!

	  " For all text files set 'textwidth' to 78 characters.
	  autocmd FileType text setlocal textwidth=78

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

	else

	  set autoindent		" always set autoindenting on

	endif " has("autocmd")

	" Convenient command to see the difference between the current buffer and the
	" file it was loaded from, thus the changes you made.
	" Only define it when not defined already.
	if !exists(":DiffOrig")
	  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
			  \ | wincmd p | diffthis
	endif
" }

" Valuable {
	" Line number
	set number

	set wildmode=list:longest
	syn on
	" Limit text width
	set textwidth=78

	" Activate :Man <name>
	runtime ftplugin/man.vim
" }

" Formatting {
	set tabstop=4
	" Number of column shifted with >> and <<
	set shiftwidth=4
	" To have backspace delete spaces likes tabs
	set softtabstop=4
	" Replace tab character with space characters
	set expandtab
" }

" Folding {
	" Fold text
	"set foldmethod=indent
	set foldmethod=marker
	set foldmarker={,}
	set nofoldenable
	"nnoremap <space> za

	" Better folding color
	highlight Folded cterm=bold ctermfg=0 ctermbg=8
"}

" Key Mapping {
	" Use <F5> to indent all the file
	noremap <F5> gg=G``zz

	" To use tags
	" Creates a ctags file
	noremap <F6> :!ctags -R .<CR>
	" Jump to the tag corresponding to what is under the cursor
	noremap <F7> <C-]>

	" Allow using ctrl up/down arrow to move a line up or down
	noremap <C-Up> :m-2 <CR>
	noremap <C-Down> :m+1 <CR>

	" Switch between .c and .h files or between .cpp and .hpp files {
		function! GetProjectFile(filename)
			return expand('%:p:h').'/'.a:filename
		endfunction

		function! GetFileWithExtension(fileroot, extensionList)
			for extension in a:extensionList
				let s:fname = expand(a:fileroot).'.'.extension
				let s:sname = GetProjectFile(s:fname)
				if filereadable(s:sname)
					return s:sname
				endif
			endfo
			" if no dual file has been found, the last one is return by
			" default
			return s:fname
		endfunction

		function! SwitchDualFile()
			if expand('%:e')=='c'
				exe 'e' GetFileWithExtension('%:t:r', ['h'])
			elseif expand('%:e')=='h'
				exe 'e' GetFileWithExtension('%:t:r', ['cpp', 'c'])
			elseif expand('%:e')=='cpp'
				exe 'e' GetFileWithExtension('%:t:r', ['hpp', 'h'])
			elseif expand('%:e')=='hpp'
				exe 'e' GetFileWithExtension('%:t:r', ['cpp'])
			elseif expand('%:e')=='tex'
				!zathura %:r.pdf &
			endif
		endfunction
		" Use <F8> to apply the switch
		nmap <silent>  <F8>  :call SwitchDualFile()<CR><CR>
	" }

	" Compilation Latex, C, C++, java or Lisp {
		function! MakeFile()
			if filereadable("Makefile")
				if expand('%:e')=='tex'
					:make %:r.pdf
				else
					:make %:r
				endif
			elseif expand('%:e')=='c'
				"!CLFAGS='-Wall -Wextra' make %:r
				!gcc -Wall -Wextra -g -O0 -o %:r %
			elseif expand('%:e')=='cpp'
				!g++ -Wall -Wextra -o %:r %
			elseif expand('%:e')=='java'
				!javac %
			elseif expand('%:e')=='tex'
				!pdflatex % && pdflatex % && rm -f *~ *.aux *.log
			elseif expand('%:e')=='lisp'
				" !if [ ! -p /tmp/sbcl_in ]; then mkfifo /tmp/sbcl_in && tail -f -n +0 sbcl_in | sbcl; fi
				Lisp
			elseif expand('%:e')=='mac'
				!maxima -b %
			endif
		endfunction
		" Use <F9> to apply
		map <F9> :call MakeFile() <CR>
	" }

	" Comments {
		" Format paragraphs while writing
		" set formatoptions+=a

		" Disable help shortcut in insert mode
		inoremap <F1> <CR>
		" Comment things in (gv recovers previous selection)
		vnoremap <F1> A*/<ESC>gvI/*<ESC>
		nnoremap <F1> I/*<ESC>A*/<ESC>

		" Clean comments
		function! CleanCom()
			:s+/\*\|\*/++ge
		endfunction
		noremap <silent> <C-L> :call CleanCom() <CR>:noh<CR>
	" }

	" Buffers {
		" Change buffer size easily
		nmap > :vertical res +1<CR>
		nmap < :vertical res -1<CR>
		nmap + :res +1<CR>
		nmap - :res -1<CR>

		" Use <F2> to switch to the desired buffer
		noremap <F2> :ls<CR>:b 
		" <F3> and <F4> to switch between buffers
		noremap <F3> :bp<CR>
		noremap <F4> :bn<CR>
	" }

	" Refactoring {
		" (Thanks to http://stackoverflow.com/a/597932)
		" For local replace in a single file
		nnoremap glr gd[{V%:s/<C-R>///gc<left><left><left>
		" For global replace in a single file
		nnoremap gr gD:%s/<C-R>///gc<left><left><left>

		" For global replace in every buffers
		nnoremap gR *:bufdo %s/<C-R>///gc \| update<left><left><left><left><left><left><left><left><left><left><left><left>
	" }}

" }

" Filetype specific {
	" By default .max files are thought as asm files, we tell vim that we want
	" them to be understood as maxima files
	au BufNewFile,BufRead *.mac setlocal filetype=maxima
	au BufNewFile,BufRead *.mac colorscheme darkblue

	" Put a nice colorscheme for scilab files
	au BufNewFile,BufRead *.sce colorscheme delek
" }

" Plugins {

	" pathogen {
		execute pathogen#infect()
	" }

	" taglist {
	" }

	" ctrlp {
		let g:ctrlp_extensions = ['line']
		let g:ctrlp_custom_ignore = {
				\ 'file': '\v(\.o|\.so|\.a|\~)$',
		\}
	" }

	" AutoComplPop {
		" Disable it by default 'cause it's really annoying
		let g:acp_enableAtStartup = 0
	" }

	" slimv {
		let g:slimv_swank_cmd = '! xterm -e sbcl --load /usr/share/emacs/site-lisp/slime/start-swank.lisp &'
		let g:lisp_rainbow=1
	" }

	" fugitive {
		" Display filename and branch in the status bar
		"set statusline=%f%50{fugitive#statusline()}
		set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
	" }

	" cscope {
		if has('cscope')
			set cscopetag cscopeverbose

			if has('quickfix')
				set cscopequickfix=s-,c-,d-,i-,t-,e-
			endif

			cnoreabbrev csa cs add
			cnoreabbrev csf cs find
			cnoreabbrev csk cs kill
			cnoreabbrev csr cs reset
			cnoreabbrev css cs show
			cnoreabbrev csh cs help

			nnoremap <silent> ,a  :!cscope -b -R<C-D><CR>:cs add cscope.out<CR>
			nnoremap <silent> ,c  :cs find c <cword><CR>
			nnoremap <silent> ,d  :cs find d <cword><CR>
			nnoremap <silent> ,e  :cs find e <cword><CR>
			nnoremap <silent> ,f  :cs find f <cfile><CR>
			nnoremap <silent> ,g  :cs find g <cword><CR>
			nnoremap <silent> ,i  :cs find i <cfile><CR>
			nnoremap <silent> ,s  :cs find s <cword><CR>
			nnoremap <silent> ,t  :cs find t <cword><CR>
		endif
	" }

	" snipMate {
		" Replaced by UltiSnips
	" }

	" UltiSnips {
		" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
		"let g:UltiSnipsExpandTrigger="<tab>"
		"let g:UltiSnipsJumpForwardTrigger="<c-j>"
		"let g:UltiSnipsJumpBackwardTrigger="<c-k>"

		" If you want :UltiSnipsEdit to split your window.
		let g:UltiSnipsEditSplit="vertical"

		" Snippets are defined a different directory
		"let g:UltiSnipsSnippetsDir="~/.vim/bundle/vim-snippets/UltiSnips"
	" }

" }

" Project specific {
	" A standalone function to get the project's root, or the parent directory
	" of the current file if a root can't be found (see help ctrlp)
	function! GetProjectRoot()
		let s:isVimProject = 0
		let cph = expand('%:p:h', 1).'/'
		if cph =~ '^.\+://' | retu | en
		for mkr in ['.vimprojects', '.git/', '.hg/', '.svn/', '.bzr/', '_darcs/']
			let wd = call('find'.(mkr =~ '/$' ? 'dir' : 'file'), [mkr, cph.';'])
			if wd != ''
				let s:isVimProject = 1
				let &acd = 0
				break
			endif
		endfo
		return fnameescape(wd == '' ? cph : substitute(wd, mkr.'$', './', ''))
	endfunction

	command! -nargs=0 Pcd exe 'cd' GetProjectRoot()
	command! -nargs=0 Showcd echo GetProjectRoot()

	" Allow per-project configuration file
	set exrc
	" Disable unsafe commands in project-specific .vimrc files
	set secure

	" Project .vimrc {
		" Load project config file when even if it is not in the working directory
		" Some protection are used to prevent loading ${HOME}/.vimrc twice
		function s:LoadProjectVimrc()
			let s:root = GetProjectRoot()
			if expand('%:t') != '.vimrc' && s:root != $HOME.'/' && expand('%:e') != '~'
				let s:f = s:root.'.vimrc'
				if filereadable(s:f) | exe 'source' s:f | en
			en
		endfunction

		autocmd BufNewFile,BufRead * call s:LoadProjectVimrc()
	" }

	" Cscope mapping adapted for a project {
		function! LoadCscopeDatabase()
			exe 'cd' GetProjectRoot()
			!cscope -b -R
			cs add cscope.out
			cd -
		endfunction

		function! ProjectRootExe(cmd)
			exe 'cd' GetProjectRoot()
			exe a:cmd
			cd -
		endfunction

		if has('cscope')
			nnoremap <silent> ,a  :call LoadCscopeDatabase()<CR>
			"nnoremap <silent> ,a  :call ProjectRootExe('!cscope -b -R')<CR>:call ProjectRootExe('cs add cscope.out')<CR>
			nnoremap <silent> ,c  :call ProjectRootExe('cs find c <cword>')<CR>
			nnoremap <silent> ,d  :call ProjectRootExe('cs find d <cword>')<CR>
			nnoremap <silent> ,e  :call ProjectRootExe('cs find e <cword>')<CR>
			nnoremap <silent> ,f  :call ProjectRootExe('cs find f <cfile>')<CR>
			nnoremap <silent> ,g  :call ProjectRootExe('cs find g <cword>')<CR>
			nnoremap <silent> ,i  :call ProjectRootExe('cs find i <cfile>')<CR>
			nnoremap <silent> ,s  :call ProjectRootExe('cs find s <cword>')<CR>
			nnoremap <silent> ,t  :call ProjectRootExe('cs find t <cword>')<CR>
		endif
	" }

	" Override GetProjectFile to find a file in the whole project directory {
		function! GetProjectFile(filename)
			let s:root = GetProjectRoot()
			if s:isVimProject
				return expand(s:root.'**/'.a:filename)
			else
				return expand('%:p:h').'/'.a:filename
			endif
		endfunction
	" }

" }
