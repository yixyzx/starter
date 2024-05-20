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
-- YiX add start
