let s:colors_gui = ['#33FF33', '#4DFF33', '#66FF33', '#80FF33', '#99FF33', '#B3FF33', '#CCFF33', '#E6FF33', '#FFFF33']
let s:colors_cterm = [46, 118, 154, 190, 226, 227, 228, 229, 230]
let s:color_index = 0

function! copilot_chat#buffer#create() abort
  let l:position = copilot_chat#config#get('window_position', 'right')

  " Create split based on position
  if l:position ==# 'right'
    vsplit
  elseif l:position ==# 'left'
    leftabove vsplit
  elseif l:position ==# 'top'
    topleft split
  elseif l:position ==# 'bottom'
    botright split
  endif

  enew

  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal filetype=copilot_chat

  " Set buffer name
  let l:chat_count = get(s:, 'chat_count', 1)
  execute 'file CopilotChat-' . l:chat_count

  " Save buffer number for reference
  let s:current_chat_buffer = bufnr('%')
  call appendbufline(s:current_chat_buffer, 0, 'Welcome to Copilot Chat! Type your message below:')
  call copilot_chat#buffer#add_input_separator(s:current_chat_buffer)
  return s:current_chat_buffer
endfunction

function! copilot_chat#buffer#add_input_separator(buffer) abort
  let l:width = winwidth(0) - 2
  let l:separator = ' ' . repeat('━', l:width)
  call appendbufline(a:buffer, '$', l:separator)
  call appendbufline(a:buffer, '$', '')
endfunction

function! copilot_chat#buffer#waiting_for_response() abort
  call appendbufline(g:active_chat_buffer, '$', 'Waiting for response')
  let s:waiting_timer = timer_start(500, {-> copilot_chat#buffer#update_waiting_dots()}, {'repeat': -1})
endfunction

function! copilot_chat#buffer#update_waiting_dots() abort
  let l:current_text = getbufline(g:active_chat_buffer, '$')[0]
  if l:current_text =~? '^Waiting for response'
      let l:dots = len(matchstr(l:current_text, '\..*$'))
      let l:new_dots = (l:dots % 3) + 1
      call setbufline(g:active_chat_buffer, '$', 'Waiting for response' . repeat('.', l:new_dots))
    let s:color_index = (s:color_index + 1) % len(s:colors_gui)
    execute 'highlight CopilotWaiting guifg=' . s:colors_gui[s:color_index] . ' ctermfg=' . s:colors_cterm[s:color_index]
  endif
  return 1
endfunction

function! copilot_chat#buffer#add_selection() abort
  " Save the current register and selection type
  let l:save_reg = @"
  let l:save_regtype = getregtype('"')
  let l:filetype = &filetype

  " Get the visual selection
  normal! gv"xy

  " Get the content of the visual selection
  let l:selection = getreg('x')

  " Restore the original register and selection type
  call setreg('"', l:save_reg, l:save_regtype)
  call appendbufline(g:active_chat_buffer, '$', '```' . l:filetype)
  call appendbufline(g:active_chat_buffer, '$', split(l:selection, "\n"))
  call appendbufline(g:active_chat_buffer, '$', '```')
endfunction