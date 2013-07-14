" Copyright 2011 The Go Authors. All rights reserved.
" Use of this source code is governed by a BSD-style
" license that can be found in the LICENSE file.
"
" imports.vim: Vim command to format Go files with goimports.
"
" This filetype plugin add a new commands for go buffers:
"
"   :Imports
"
"       Filter the current Go buffer through goimports.
"       It tries to preserve cursor position and avoids
"       replacing the buffer with stderr output.
"
if exists("b:did_ftplugin_go_imports")
    finish
endif

command! -buffer Imports call s:GoFormat()

function! s:GoFormat()
    let view = winsaveview()
    silent %!goimports
    if v:shell_error
        let errors = []
        for line in getline(1, line('$'))
            let tokens = matchlist(line, '^\(.\{-}\):\(\d\+\):\(\d\+\)\s*\(.*\)')
            if !empty(tokens)
                call add(errors, {"filename": @%,
                                 \"lnum":     tokens[2],
                                 \"col":      tokens[3],
                                 \"text":     tokens[4]})
            endif
        endfor
        if empty(errors)
            % | " Couldn't detect goimports error format, output errors
        endif
        undo
        if !empty(errors)
            call setloclist(0, errors, 'r')
        endif
        echohl Error | echomsg "Goimports returned error" | echohl None
    endif
    call winrestview(view)
endfunction

let b:did_ftplugin_go_imports = 1

" vim:ts=4:sw=4:et
