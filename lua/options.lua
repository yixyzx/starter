require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
-- "rcarriga/nvim-notify": add messages
vim.opt.termguicolors = true

-- 中文乱码 --
-- 读取文件时尝试识别的编码格式列表
vim.opt.fileencodings = "utf-8,ucs-bom,gb18030,gbk,gb2312,cp936"
-- nvim内部使用的编码格式
vim.opt.encoding = "utf-8"
-- 将wrap选项设置为false，等同于在Vim中执行:set nowrap
vim.opt.wrap = false
