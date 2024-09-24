" Description: Custom utility functions meant to be called from vimrc file

"" Switch the diffmode for the current buffer (diffthis/diffoff)
function! utils#DiffSwitch() abort
    if &diff
        echom 'Disable diff mode'
        execute('diffoff')
        set nocursorbind
    else
        echom 'Enable diff mode'
        execute('diffthis')
    endif
endfunction

"" Build the tags
function! utils#MkTags() abort
  let l:scripts = [ './build/mktags.sh', 'env/mktags.sh' ]
  for l:scriptfile in l:scripts
    if filereadable(l:scriptfile)
      let message = 'Running file ' . l:scriptfile
      echo message
      execute 'silent !bash ' . l:scriptfile
      silent !clear
      return
    endif
  endfor
  echo 'No tags building script file, running default'
  exec '!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++,c .'
endfunction

" Toggle auto-format mode
function! utils#ToggleAutoFormat() abort
    if &formatoptions =~# 'a'
      set formatoptions-=a
      echom 'Auto-Format disabled'
    else
      set formatoptions+=a
      echom 'Auto-Format enabled'
    endif
endfunction

"" Print buffer content in PDF file
function! utils#ToPDF() abort
    execute('ha > %.ps')
    execute('!ps2pdf %.ps')
    execute('!rm -f %.ps')
    echo 'Exported to PDF'
endfunction

"" Return human-readable current time
function! utils#HumanReadableDate() abort
    return strftime('%Y-%m-%d (%a)')
endfunction


"" Fill rest of line with characters
function! utils#FillLine() abort
    call inputsave()
    let l:str = input("Fill the line with char: ")
    call inputrestore()
    " set tw to the desired total length
    let l:tw = &textwidth
    if l:tw == 0 | let l:tw = 80 | endif
    " strip trailing spaces first
    execute('.s/[[:space:]]*$//')
    " calculate total number of 'str's to insert
    let l:reps = (l:tw - col('$')) / len(l:str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    if l:reps > 0
        execute('s/$/\=(" ".repeat(l:str, l:reps))/')
    endif
endfunction

" Align text to right
function! utils#AlignRightFrom(line, pos, textwidth) abort
    if a:textwidth == 0
        return
    endif
    let l:spaces_to_insert = a:textwidth - len(a:line)
    if l:spaces_to_insert >= 0
        execute 'normal! i' . repeat(' ', l:spaces_to_insert)
    else
        " TODO: see if we can remove spaces under the cursor?
    endif
endfunction

function! utils#DeleteAllBuffersButCurrent() abort
    let l:this_buffer = bufnr()
    let l:bufs_deleted = 0
    bufdo if bufnr() !=# l:this_buffer | bdelete | let l:bufs_deleted += 1 | endif
    echom "Cleared " . l:bufs_deleted . " buffers."
endfunction
