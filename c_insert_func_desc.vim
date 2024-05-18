" ~/.vim/plugin/c_insert_func_desc.vim

" Function to insert function description
function! CInsertFuncDesc()
  " Get the current line containing the function prototype
  let l:prototype = getline('.')

  " Extract the function name and parameters using a regular expression
  if match(l:prototype, '\v^\s*\w+\s+\w+\(.*\)') >= 0
    let l:matchlist = matchlist(l:prototype, '\v^\s*(\w+)\s+(\w+)\((.*)\)')

    " Get the return type, function name, and parameter list
    let l:return_type = l:matchlist[1]
    let l:func_name = l:matchlist[2]
    let l:param_list = l:matchlist[3]

    " Split the parameter list into individual parameters
    let l:params = split(l:param_list, '\s*,\s*')

    " Generate the parameter descriptions
    let l:param_descriptions = []
    for param in l:params
      call add(l:param_descriptions, ' *    ' . param . ' - Description of ' . param)
    endfor

    " Define the description template
    let l:description = [
    \ '/**',
    \ ' * Function: ' . l:func_name,
    \ ' *',
    \ ' * Description:',
    \ ' *',
    \ ' * Parameters:'
    \ ] + l:param_descriptions + [
    \ ' *',
    \ ' * Returns:',
    \ ' *    Description of return value',
    \ ' */'
    \ ]

    " Insert the description template above the current line
    call append(line('.') - 1, l:description)
  else
    echom "No function prototype found on the current line."
  endif
endfunction

" Create a command to call the function
command! CInsertFuncDesc call CInsertFuncDesc()

