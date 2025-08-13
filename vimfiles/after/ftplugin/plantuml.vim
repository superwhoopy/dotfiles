if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

" disable spelling
setlocal nospell

augroup ftplantuml
    autocmd!
    " build on save
    au BufWritePost *.puml mak
augroup END

" Creole surround rules
let b:surround_{char2nr("b")} = "**\r**"
let b:surround_{char2nr("i")} = "//\r//"
let b:surround_{char2nr("m")} = "\"\"\r\"\""
