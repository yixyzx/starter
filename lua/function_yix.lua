
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



-- 缩进(indentation)
-- @inc: 用于决定查找方向（1 表示向下，-1 表示向上）  
-- @indent_change: 用于决定缩进级别的变化，现在其单位是tab(0 表示相同缩进，1 表示高一个缩进，-1 表示低一个缩进)
-- 将第0列到缩进位置看作一个红色长条，1表示红色长条更长，-1则短。
-- ':lua GoToNextIndent(-1)' nvim command line中可调试
-- ':lua print(vim.opt.tabstop:get())' 打印tab键占用blink数目
-- 先要用'gg=G'做好代码缩进整理，否则可能会错，比如lua以2blink=1tab,如果copy过来的代码是4blink对齐，就错.
function GoToNextIndent(inc, indent_change)
  -- 获取当前光标位置
  local currentPos = vim.api.nvim_win_get_cursor(0)
  local currentLine = currentPos[1]
  local matchIndent = false
  local currentIndent = vim.fn.indent('.')
  -- 获取 tabstop 的值
  local tabstop = vim.opt.tabstop:get()
  -- 打印调试信息
  -- print("Starting GoToNextIndent with inc: ".. inc.. " and indent_change: ".. indent_change)
  -- print("Current line: ".. currentLine.. " with indent: ".. currentIndent)
  -- print("tabstop is: ".. tabstop)

  -- 寻找具有所需缩进级别的行，且不超出缓冲区范围
  while not matchIndent and currentLine ~= vim.api.nvim_buf_line_count(0) + 1 and currentLine ~= -1 do
    currentLine = currentLine + inc
    local lineIndent = vim.fn.indent(currentLine)
    -- 检查行是否非空且满足缩进条件
    if string.len(vim.fn.getline(currentLine)) > 0 then
      if indent_change == 0 then
        matchIndent = lineIndent == currentIndent
      elseif indent_change == 1 then
        matchIndent = lineIndent == currentIndent + tabstop
      elseif indent_change == -1 then
        matchIndent = lineIndent == currentIndent - tabstop
      end
    end
    -- print("Checking line ".. currentLine.. " with indent: ".. lineIndent)
  end

  -- 如果找到，将光标移动到该行
  if matchIndent then
    currentPos[1] = currentLine
    vim.api.nvim_win_set_cursor(0, currentPos)
    -- print("Found matching line at: ".. currentLine)
  else
    -- print("No matching line found.")
  end
end
