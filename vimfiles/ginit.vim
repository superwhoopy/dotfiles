" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" You can also specify a different font, overriding the default font
"if has('gui_gtk2')
"  set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
"else
"  set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
"endif

if has('win32')
    let s:fontname = "CaskaydiaCove\\ Nerd\\ Font\\ Mono"
    let s:fontsize = 8
else " Unix
    let s:fontname = "UbuntuMono\\ Nerd\\ Font"
    let s:fontsize = 14
endif

function! s:setFont()
    if exists(':GuiFont')
        let s:fontcmd = 'GuiFont! '
    else
        let s:fontcmd = 'set guifont='
    endif
    execute(s:fontcmd . s:fontname . ":h" . s:fontsize)
endfunction

function! AdjustFontSize(amount)
    let s:fontsize = s:fontsize + a:amount
    call s:setFont()
endfunction


call s:setFont()

set guioptions-=T                  " ne pas afficher la toolbar
set guioptions-=m                  " ne pas afficher la menubar
set guioptions-=r                  " do not show vertical bars
set guioptions-=R
set guioptions-=l
set guioptions-=L
set lines=60 columns=90   " taille de la fenêtre au démarrage

set mouse=a " enable mouse support

" render ligatures - disabled because too damn slow on Windows :(
" GuiRenderLigatures 1

" adjust font size
nnoremap <C-=> :call AdjustFontSize(1)<CR><C-W>=
nnoremap <C--> :call AdjustFontSize(-1)<CR><C-W>=

" toggle fullscreen
let s:fullscreen = 0
function! ToggleFullScreen()
    let s:fullscreen = ! s:fullscreen
    if exists("g:neovide")
        let g:neovide_fullscreen = s:fullscreen
    else
        call GuiWindowFullScreen(s:fullscreen)
    endif
endfunction

nnoremap <F11> :call ToggleFullScreen()<CR>

" Fvim stuff
if exists('g:fvim_loaded')
    " no, nothing
endif

if exists('g:neovide')
    let g:neovide_cursor_animation_length = 0.1
endif

