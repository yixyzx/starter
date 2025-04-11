
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

-- 加载 telescope.nvim
local builtin = require('telescope.builtin')
-- 定义兼容的 unpack 函数
local unpack = unpack or table.unpack

-- 从 .h 文件跳转到 .c 文件
-- function Jump_from_h_to_c()
--     local current_file = vim.api.nvim_buf_get_name(0)
--     if vim.endswith(current_file, '.h') then
--         local base_name = vim.fn.fnamemodify(current_file, ":t:r")
--         local dir = vim.fn.fnamemodify(current_file, ":h")
--         builtin.find_files({
--             search_dirs = { dir },
--             prompt_title = "查找对应的 .c 文件",
--             search = base_name .. '.c'
--         })
--     else
--         print("当前文件不是 .h 文件")
--     end
-- end

-- .c <-> .h
-- 可能会出现的2个重复文件，它们是同一个目录下的同一个.h文件：原因是Neovim 或 telescope 内部可能存在缓存机制
-- 可用清除缓存机制的方法，但是会降低搜索速度，所以不修正 (->Close)
-- 从 .h 文件跳转到 .c 文件
function Jump_from_h_to_c()
    local current_file = vim.api.nvim_buf_get_name(0)
    if vim.endswith(current_file, '.h') then
        local base_name = vim.fn.fnamemodify(current_file, ":t:r")
        local current_dir = vim.fn.fnamemodify(current_file, ":h")
        local parent_dir = vim.fn.fnamemodify(current_dir, ":h")

        -- 定义可能包含源文件的目录
        local search_dirs = {
            current_dir,
            parent_dir .. '/src',
            parent_dir .. '/source'
        }

        -- 过滤掉不存在的目录
        local valid_search_dirs = {}
        for _, dir in ipairs(search_dirs) do
            if vim.fn.isdirectory(dir) == 1 then
                table.insert(valid_search_dirs, dir)
            end
        end

        if #valid_search_dirs > 0 then
            -- 构建查找命令，使用 find 命令进行精确查找
            local find_command = {
                'find',
                unpack(valid_search_dirs),
                '-name', base_name .. '.c'
            }

            builtin.find_files({
                search_dirs = valid_search_dirs,
                prompt_title = "查找对应的 .c 文件",
                hidden = false, -- 不查找隐藏文件
                -- no_ignore = false, -- 遵循 .gitignore 等忽略规则
                follow = true, -- 跟随符号链接
                find_command = find_command
            })
        else
            print("未找到有效的搜索目录")
        end
    else
        print("当前文件不是 .h 文件")
    end
end


-- 从 .c 文件跳转到 .h 文件
function Jump_from_c_to_h()
    local current_file = vim.api.nvim_buf_get_name(0)
    if vim.endswith(current_file, '.c') then
        local base_name = vim.fn.fnamemodify(current_file, ":t:r")
        local current_dir = vim.fn.fnamemodify(current_file, ":h")
        local parent_dir = vim.fn.fnamemodify(current_dir, ":h")

        -- 定义可能包含头文件的目录
        local search_dirs = {
            current_dir,
            parent_dir .. '/inc',
            parent_dir .. '/include'
        }

        -- require("notify")(search_dirs)
        -- 过滤掉不存在的目录
        local valid_search_dirs = {}
        for _, dir in ipairs(search_dirs) do
            if vim.fn.isdirectory(dir) == 1 then
                table.insert(valid_search_dirs, dir)
            end
        end
        -- require("notify")(valid_search_dirs)

        if #valid_search_dirs > 0 then
            -- 构建查找命令，使用 find 命令进行精确查找
            local find_command = {
                'find',
                unpack(valid_search_dirs),
                '-name', base_name .. '.h'
            }

            builtin.find_files({
                search_dirs = valid_search_dirs,
                prompt_title = "查找对应的 .h 文件",
                hidden = false, -- 不查找隐藏文件
                -- no_ignore = false, -- 遵循 .gitignore 等忽略规则
                follow = true, -- 跟随符号链接
                find_command = find_command
            })
        else
            print("未找到有效的搜索目录")
        end
    else
        print("当前文件不是 .c 文件")
    end
end
