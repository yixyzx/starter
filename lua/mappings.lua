require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- YiX add start
-- 'Alt+n'切换buffer的方法不再是使用，改用'leader+n'，它使用插件'https://github.com/ap/vim-buftabline'
-- 'Alt+n' switch to n tab: 'https://nvchad.com/docs/api'
-- todo: buffer上显示'数字'，这样更方便看清楚哪个buffer对应哪个数字，使用'Alt+n'切换更方便.
-- for i = 1, 9, 1 do
--   vim.keymap.set("n", string.format("<A-%s>", i), function()
--     vim.api.nvim_set_current_buf(vim.t.bufs[i])
--   end)
-- end

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
map("i", "dtx", "<C-r>=strftime('%a, %h %d, %G')<cr>", { desc = "Insert the current date and time" })
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
  -- local path = vim.fn.expand("%:p")
  local path = vim.fn.expand("%")
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
-- tags/ctags
-- 使用Ctrl + ]查找某个标签时，第一次列出了所有匹配项,选择一个后，
-- 但在第二次查找时却直接跳转到之前选择过的项而不是列出所有的匹配项，
-- 或者使用Ctrl + ]查找标签时总是直接跳转到第一个匹配的标签，
-- 但这可能并不是你想要的，这时候使用:ts命令就可以列出所有匹配项供自己选择，
-- 或者在配置文件中添加如下配置：map <c-]> g<c-]>。
map("n", "<c-]>", "g<c-]>" )

-- "aerial": A code outline window for skimming and quick navigation
-- map("n", "<leader>a", "<cmd>AerialToggle!<CR>", { buffer = bufnr })
map("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- call GoToNextIndent( , ) in lua/function_yix.lua
-- n: 表示向下查找，m: 向上(p键被占用，改为m)
-- =: 相同缩进, 1: 更长缩进 -1: 更短缩进
vim.api.nvim_set_keymap('n', 'n=', ':lua GoToNextIndent(1, 0)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'm=', ':lua GoToNextIndent(-1, 0)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'n+', ':lua GoToNextIndent(1, 1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'm+', ':lua GoToNextIndent(-1, 1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'n-', ':lua GoToNextIndent(1, -1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'm-', ':lua GoToNextIndent(-1, -1)<CR>', { noremap = true, silent = true })

-- .c <-> .h
-- 可能会出现的2个重复文件，它们是同一个目录下的同一个.h文件：原因是Neovim 或 telescope 内部可能存在缓存机制
-- 可用清除缓存机制的方法，但是会降低搜索速度，所以不修正 (->Close)
vim.api.nvim_set_keymap('n', '<leader>hc', '<cmd>lua Jump_from_h_to_c()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ch', '<cmd>lua Jump_from_c_to_h()<CR>', { noremap = true, silent = true })
