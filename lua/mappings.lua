require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- YiX add start
-- 'Alt+n' switch n tab: 'https://nvchad.com/docs/api'
-- todo: buffer上显示'数字'，这样更方便看清楚哪个buffer对应哪个数字，使用'Alt+n'切换更方便.
for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

-- Quickly open a markdown buffer for scribble
-- come from 'https://github.com/amix/vimrc'
map("n", "<leader>q", ":e ~/buffer.md<cr>", { desc = "Scribble to quickly open a markdown buffer for scribble" })

-- Insert the current date and time (useful for timestamps):
-- General abbreviations:  'https://github.com/amix/vimrc'
-- iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
-- [The Only Vim Insert-Mode Cheatsheet You Ever Needed](https://dev.to/iggredible/the-only-vim-insert-mode-cheatsheet-you-ever-needed-nk9)
-- insert contents from any register with Ctrl-r plus register symbol,
-- and an expression register, =, to evaluate expressions: 'Ctrl-r =1+1'
-- Ctrl-r "    # insert the last yank/delete
-- Ctrl-r %    # insert file name
-- Ctrl-r /    # insert last search term
-- Ctrl-r :    # insert last command line
-- Ctrl-r =1+1 # insert an expression
-- https://renenyffenegger.ch/notes/development/vim/commands/put
-- .put puts text after the current line (. usually indicates the current line).
-- insert datetme in new line after the current line
map("n", "<leader>l", ":.put=strftime('%h %d, %G')<cr>", { desc = "Insert the current date and time" })
-- MUST type 'dtx' or 'dty' Quickly in insert mode, otherwise just input a string 'dtx'.
-- May 21, 2024
map("i", "dtx", "<C-r>=strftime('%h %d, %G')<cr>", { desc = "Insert the current date and time" })
-- Tue 21 May 2024 02:08:07 PM CST
map("i", "dty", "<C-r>=strftime('%c')<cr>", { desc = "Insert the current date and time" })


-- https://jdhao.github.io/2019/07/31/nvim_show_file_path/
-- https://vi.stackexchange.com/questions/104/how-can-i-see-the-full-path-of-the-current-file
-- ':echo expand("%:p")', or '1 + Ctrl + G', "%" is 
-- https://vimtricks.com/p/get-the-current-file-path
-- Relative path to file: %
-- Absolute path to file: %:p
-- Filename only: %:t
-- Directory name only: %:p:h
-- 'https://github.com/tnakaz/path-to-clipboard.nvim/blob/main/lua/path-to-clipboard/init.lua'
map("n", "<leader>p", function ()
  local path = vim.fn.expand("%:p")
  if path ~= "" then
    vim.fn.setreg('+', path)
    print("Copied: " .. path)
  end
end, { desc = "copy the the current file path to system register '+'" })
-- https://vi.stackexchange.com/questions/2129/fastest-way-to-switch-to-a-buffer-in-vim
-- Method #1: The :b command can also take a substring of the name of the file of the buffer which you want to travel to
-- ":b a" = ":b bar"
-- Method #2:
map("n", "<leader>b", ":ls<CR>:b<Space>", { desc = " list the available buffers and prepare :b" })
-- Yix add end
