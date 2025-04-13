scriptencoding utf-8

let g:prompts = {}
let g:active_chat_buffer = -1
let g:default_model = 'gpt-4o'
let g:available_models = []

command! -nargs=0 CopilotChatOpen call copilot_chat#open_chat()
command! -nargs=1 CopilotChat call copilot_chat#start_chat(<q-args>)
command! -nargs=0 CopilotSubmit call copilot_chat#submit_message()
command! -nargs=0 CopilotConfig call copilot_chat#config#view()
command! -nargs=0 CopilotModels call copilot_chat#config#view_models()
command! -nargs=0 SelectModel call copilot_chat#config#select_model()

nnoremap <leader>cc :CopilotChatOpen<CR>
vnoremap <silent> <leader>a :<C-u>call copilot_chat#buffer#add_selection()<CR>

" vim:set ft=vim sw=2 sts=2 et:
