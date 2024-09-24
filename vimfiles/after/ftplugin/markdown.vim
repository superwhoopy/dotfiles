set spell
set linebreak
lua << EOF
vim.o.formatlistpat = "^\\s*\\d\\+\\.\\s\\+\\|^\\s*[-*+>]\\s\\+\\|^\\[^\\ze[^\\]]\\+\\]:\\&^.\\{4\\}"
EOF

let g:markdown_fenced_languages = ['cpp', 'python', 'json', 'sh']

" custom surround: 'b' to bolden text
let g:surround_{char2nr("b")} = "**\r**"

