
-- copy在command line中输入':command'后的结果到寄存器中,文件中...。
-- https://stackoverflow.com/questions/2573021/vim-how-to-redirect-ex-command-output-into-current-buffer-or-file/2573054#2573054
-- Called with a command and a redirection target
--   (see `:help redir` for info on redirection targets)
-- Note that since this is executed in function context,
--   in order to target a global variable for redirection you must prefix it with `g:`.
-- EG call Redir('ls', '=>g:buffer_list')
function Redir(command, to)
  -- require("notify")("Redir function")
  vim.cmd('redir ' .. to)
  vim.cmd(command)
  vim.cmd('redir END')
end

-- The last non-space substring is passed as the redirection target.
-- EG
--   :R ls @">
--   " stores the buffer list in the 'unnamed buffer'
-- Redirections to variables or files will work,
--   but there must not be a space between the redirection operator and the variable name.
-- Also note that in order to redirect to a global variable you have to preface it with `g:`.
--   EG
--     :R ls =>g:buffer_list
--     :R ls >buffer_list.txt
vim.api.nvim_create_user_command(
  "R",
  function(opts)
    -- require("notify")(opts.args)
    local args = {}
    for arg in string.gmatch(opts.args, "[^ ]+") do
      table.insert(args, arg)
    end
    local command = args[1]
    local to = table.concat(args, " ", 2)
    Redir(command, to)
  end,
  { nargs = '+'   }
)
