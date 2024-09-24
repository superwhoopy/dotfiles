" All _t-suffixed expressions are types
syn match   cType       "\<[tsef]_[_a-zA-Z][_0-9a-zA-Z]*\>"
syn keyword cTodo       contained TODO FIXME XXX \todo \remark
set fdm=syntax
" match ErrorMsg '\%>80v.\+'

syn region  cppIfdef  start="#ifdef " end="#endif" transparent fold
syn region  cppIf     start="#if " end="#endif" transparent fold

