runtime coc_config.vim

" This custom runner delegates to the correct runner based on the current
" projection’s runner value. The code below sets the buffer-local
" b:projectionist_javascript_runner which gets used by the runner.
let test#custom_runners = {'JavaScript': ['ProjectionistJavaScriptRunner'] }

augroup interventions_projectionist
    autocmd!
    autocmd User ProjectionistActivate call s:activate()
augroup END

function! s:activate() abort
    for [root, value] in projectionist#query('runner')
        let b:projectionist_javascript_runner = value
        break
    endfor
endfunction
