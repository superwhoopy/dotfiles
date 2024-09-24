" Vim support file to detect file types

augroup filetypedetect
  au! BufRead,BufNewFile *.gcov     setfiletype gcov
  au! BufRead,BufNewFile *.md       setfiletype cpp
  au! BufRead,BufNewFile git-ci.tmp setfiletype gitcommit
  au! BufRead,BufNewFile *.cmm      setfiletype practice
augroup END
