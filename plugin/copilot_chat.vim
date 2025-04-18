scriptencoding utf-8

let g:prompts = {}
let g:active_chat_buffer = -1
let g:default_model = 'gpt-4o'
let g:available_models = []

command! -nargs=0 CopilotChatOpen call copilot_chat#open_chat()
command! -nargs=1 CopilotChat call copilot_chat#start_chat(<q-args>)
command! -nargs=0 CopilotGotoChat call copilot_chat#buffer#goto_active_chat()
command! -nargs=0 CopilotSubmit call copilot_chat#submit_message()
command! -nargs=0 CopilotConfig call copilot_chat#config#view()
command! -nargs=0 CopilotModels call copilot_chat#config#view_models()
command! -nargs=0 SelectModel call copilot_chat#config#select_model()
command! -nargs=? CopilotChatSave call copilot_chat#history#save(<q-args>)
command! -nargs=? CopilotChatLoad call copilot_chat#history#load(<q-args>)
command! -nargs=0 CopilotChatList call copilot_chat#history#list()
command! -nargs=0 CopilotChatReset call copilot_chat#reset_chat()
command! -nargs=? CopilotChatSetActive call copilot_chat#buffer#set_active(<q-args>)

augroup CopilotChat
  autocmd!
  autocmd FileType copilot_chat autocmd BufDelete <buffer> call copilot_chat#buffer#on_delete(expand('<abuf>'))
augroup END

if !exists('g:copilot_chat_disable_mappings')
  let g:copilot_chat_disable_mappings = 0
endif

if g:copilot_chat_disable_mappings == 1
  finish
endif

nnoremap <leader>cc :CopilotChatOpen<CR>
vnoremap <silent> <leader>a :<C-u>call copilot_chat#buffer#add_selection()<CR>

" vim:set ft=vim sw=2 sts=2 et:
