syn case ignore

syn match practiceOperator                  '[!%&()*+\-/<>^{|}~]'
syn match practiceOperator                  '\.\%(\\\n\)*\.\|!\%(\\\n\)*=\|<\%(\\\n\)*=\|=\%(\\\n\)*=\|>\%(\\\n\)*='
syn match practiceMacro                     '&\%(\\\n\)*\%(\w\%(\%(\\\n\)\|\w\)*\|(\%(\\\n\)*\w\%(\%(\\\n\)\|\w\)*)\)'
syn region practiceString                   start='"' skip='""\|\\\n' end='"' contains=practiceMacro
syn match practiceComment   '\%(;\|//\).*'

syn match practiceCommandPractice           '\%(ELSE\s\+IF\|\%(ELSE\|END\|ENDDO\|ENTER\|ENTRY\|GLOBAL\|GLOBALON\|GOSUB\|GOTO\|IF\|INKEY\|JUMPTO\|LOCAL\|ON\|PARAMS\|PRIVATE\|RETURN\|RUN\|\%(RePeaT\|RPT\)\|SCREEN\%(\.\%(\%(ALways\|AL\)\|OFF\|ON\|WAIT\)\|\%(\|\%(\.display\)\?\)\)\|STOP\|WAIT\|WHILE\)\)\%(\\\n\)*\ze\%($\|\s\|//\|;\)'
syn keyword practiceCommandPractice DO OPEN Var Write Go NEWGLOBAL assign CLOSE Break Delete Set Format Hex VALUE OS ENV PresentPracticeDirectory

hi def link practiceComment                 Comment
hi def link practiceMacro                   PreProc
hi def link practiceString                  String
hi def link practiceOperator                Operator
hi def link practiceCommandPractice         Statement
