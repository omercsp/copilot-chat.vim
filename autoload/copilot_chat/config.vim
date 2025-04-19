let s:chat_config_file = g:copilot_chat_data_dir . '/config.json'
let s:config_data = ''

" Generic configuration functions
" -------------------------------
function! copilot_chat#config#create_data_dir() abort
  if !isdirectory(g:copilot_chat_data_dir)
    call mkdir(g:copilot_chat_data_dir, 'p')
  endif
endfunction

function! copilot_chat#config#read_configuration() abort
  if filereadable(s:chat_config_file)
    let l:raw_data = join(readfile(s:chat_config_file), '\n')
  else
    let l:raw_data = '{}'
  endif
  let s:config_data = json_decode(l:raw_data)
endfunction

function! copilot_chat#config#save_config_file() abort
  call copilot_chat#config#create_data_dir()
  call writefile([json_encode(s:config_data)], s:chat_config_file)
endfunction

function! copilot_chat#config#get(key, default='') abort
  return get(s:config_data, a:key, a:default)
endfunction

function! copilot_chat#config#set_value(key, value) abort
  let s:config_data[a:key] = a:value
  call copilot_chat#config#save_config_file()
endfunction

function! copilot_chat#config#view() abort
  execute 'vsplit ' . s:chat_config_file
endfunction

" Model selection
" ---------------
function! copilot_chat#config#view_models() abort
  vsplit
  call copilot_chat#set_scratch_buffer()
  call appendbufline(bufnr('%'), 0, 'Available Models:')
  call appendbufline(bufnr('%'), '$', g:available_models)
  execute 'syntax match ActiveModel /^' . g:default_model . '$/'
  execute 'highlight ActiveModel guifg=#33FF33 ctermfg=46'
  nnoremap <buffer> <CR> :SelectModel<CR>
endfunction

function! copilot_chat#config#select_model() abort
  call copilot_chat#config#set_value('model', getline('.'))
endfunction

" vim:set ft=vim sw=2 sts=2 et:
