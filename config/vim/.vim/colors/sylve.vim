" Vim color file
" Maintainer:   Sylvain Villard
" Last Change:  
" URL:		

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

" your pick:
set background=light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="sylve"

"hi Normal

" OR

" highlight clear Normal
" set background&
" highlight clear
" if &background == "light"
"   highlight Error ...
"   ...
" else
"   highlight Error ...
"   ...
" endif

" A good way to see what your colorscheme does is to follow this procedure:
" :w 
" :so % 
"
" Then to see what the current setting is use the highlight command.  
" For example,
" 	:hi Cursor
" gives
"	Cursor         xxx guifg=bg guibg=fg 
 	
" Uncomment and complete the commands you want to change from the default.

hi Cursor          guibg=#004a6d guifg=#ffffff
"hi CursorIM	
"hi Directory	
"hi DiffAdd		
"hi DiffChange	
"hi DiffDelete	
"hi DiffText	
"hi ErrorMsg	
"hi VertSplit	
"hi Folded		
"hi FoldColumn	
hi IncSearch       guibg=#ffffff guifg=#004a6d
hi LineNr          guibg=#c7c7c7 guifg=#660000	
"hi ModeMsg		
"hi MoreMsg		
"hi NonText		
"hi Question	
hi Search          guibg=#ffff00 guifg=fg
"hi SpecialKey	
hi StatusLine      guibg=#979797 guifg=#660000 gui=bold
hi StatusLineNC    guibg=#660000 guifg=#b7b7b7
"hi Title		
hi Visual          guibg=#b0b0b0
"hi VisualNOS	
"hi WarningMsg	
"hi WildMenu	
hi Menu            guibg=#dddddd guifg=#660000
"hi Scrollbar	
"hi Tooltip
hi PMenu            guibg=#c7c7c7 guifg=#660000

" syntax highlighting groups
hi Normal          guibg=#d7d7d7
hi String          guifg=#704000
hi NonText         guifg=#000000 gui=bold
hi Function        guifg=#660000 gui=bold
hi Comment         guifg=#3c5c5c
hi Constant        guifg=#704000
hi Identifier      guifg=#242424
hi Statement       guifg=#001166 gui=bold
hi Keyword         guifg=#704000 gui=bold
hi Operator        guifg=#001166 gui=bold
hi PreProc         guifg=#005500 gui=bold
hi Type            guifg=#500050 gui=bold
hi Special         guifg=#704000 gui=bold
"hi Underlined	
"hi Ignore		
"hi Error		
"hi Todo		

