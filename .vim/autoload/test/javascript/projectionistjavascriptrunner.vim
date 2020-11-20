" Returns true if the given file belongs to your test runner
function! test#javascript#projectionistjavascriptrunner#test_file(file)
    if b:projectionist_javascript_runner == "jest"
        return test#javascript#jest#test_file(a:file)
    elseif b:projectionist_javascript_runner == "cypress"
        return test#javascript#cypress#test_file(a:file)
    else
        return false
    endif
endfunction

" Returns test runner's arguments which will run the current file and/or line
function! test#javascript#projectionistjavascriptrunner#build_position(type, position)
    if b:projectionist_javascript_runner == "jest"
        return test#javascript#jest#build_position(a:type, a:position)
    elseif b:projectionist_javascript_runner == "cypress"
        return test#javascript#cypress#build_position(a:type, a:position)
    else
        echo "Unexpected call to test#javascript#projectionistjavascriptrunner#build_position"
    endif
endfunction

" Returns processed args (if you need to do any processing)
function! test#javascript#projectionistjavascriptrunner#build_args(args)
    if b:projectionist_javascript_runner == "jest"
        return test#javascript#jest#build_args(a:args)
    elseif b:projectionist_javascript_runner == "cypress"
        return test#javascript#cypress#build_args(a:args)
    else
        echo "Unexpected call to test#javascript#projectionistjavascriptrunner#build_args"
    endif
endfunction

" Returns the executable of your test runner
function! test#javascript#projectionistjavascriptrunner#executable()
    if b:projectionist_javascript_runner == "jest"
        return test#javascript#jest#executable()
    elseif b:projectionist_javascript_runner == "cypress"
        return test#javascript#cypress#executable()
    else
        echo "Unexpected call to test#javascript#projectionistjavascriptrunner#executable"
    endif
endfunction
