<div align="center">

# Copilot Chat for Vim
Copilot Chat functionality without having to leave vim.

Nvim folks will be able to use [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) for a similar experience.

![copilotChat](https://github.com/user-attachments/assets/0cd1119d-89c8-4633-972e-641718e6b24b)

</div>

## Requirements

- [Vim][] (9.0.0185 or newer).

- [NerdFonts][]. (optional for pretty icons)

## Commands
| Command | Description |
| ------- | ----------- |
| `:CopilotChat` | Opens a new copilot window (default vsplit right) |
| `:CopilotConfig` | Open `config.json` for default settings when opening a new CopilotChat window |
| `:CopilotModels` | View available modes / select active model |

## Key Mappings
| Location | Insert | Normal | Visual | Action |
| ---- | ---- | ---- | ---- | ---- |
| `global` | - | `<Leader>cc` | - | Opens a new chat window `:CopilotChat` |
| `<buffer>` | - | `<CR>` | - | Submit current prompt |
| `:CopilotModels` `<buffer>` | - | `<CR>` | - | Select the model on the current line for future chat use |
| `global` | - | - | `<Leader>a` | Add the current selection to the active chat window inside a code block |

## Installation

Using vim-plug, Vundle, or any other plugin manager. 

## Setup
1. Run `:CopilotChat` to open a chat window. You will be prompted to setup your device on first use.
2. Write your prompt under the line separator and press `<Enter>` in normal mode / `:SubmitChatMessage`
3. You should see a `Waiting for response..` in the buffer to indicate work is being done in the background
4. 🎉!

## Features

### Prompt Templates
Copilot Chat supports custom prompt templates that can be quickly accessed during chat sessions. Templates allow you to save frequently used prompts and invoke them with a simple syntax.

#### Using Prompts
- In the chat window, start a line with `> PROMPT_NAME` 
- The `PROMPT_NAME` will be automatically replaced with the template content before sending to Copilot
- Example: `> explain` would expand to the full explanation template

#### Managing Prompts
1. Open the config with `:CopilotConfig`
2. Add prompts to the `prompts` object in `config.json`:
```json
{
  "model": "gpt-4",
  "prompts": {
    "explain": "Explain how this code works in detail:",
    "refactor": "Suggest improvements and refactoring for this code:",
    "docs": "Generate documentation for this code:"
  }
}
```

#### Example Usage
```
> explain
function validateUser() {
  // code to validate
}
```
This will send the full template text + your code to Copilot.


[Neovim]: https://github.com/neovim/neovim/releases/latest
[Vim]: https://github.com/vim/vim
[NerdFonts]: https://www.nerdfonts.com