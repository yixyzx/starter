-- require("notify")("YiX plugins")
-- A plugin include multiple arguments which name 'Plugin Spec': 'https://lazy.folke.io/spec'
local plugins = {
    {
        "rcarriga/nvim-notify",
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = false,
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require "configs.nvim-treesitter-textobjects"
        end,
    },
    {
        "chrisgrieser/nvim-various-textobjs",
        event = "VeryLazy",
        opts = {
            keymaps = {
                useDefaults = true
            }
        },
    },
    {
        -- "aerial": A code outline window for skimming and quick navigation
        -- "aerial" replace for 'taglist' or 'tagbar'
        "stevearc/aerial.nvim",
        -- Attention: if miss 'lazy = false,', then "AerialToggle" cmd will not work!
        -- lazy = false,
        -- Alternative: 'https://lazy.folke.io/spec/lazy_loading'
        -- Additionally, you can also lazy-load on events, commands, file types and key mappings.
        cmd = { "AerialToggle", "AerialOpen" },
        -- opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            -- find config file in 'lua/configs/aerial.lua'
            require "configs.aerial"
        end,
    },
    {
        -- https://github.com/vim-scripts/a.vim
        -- Alternate Files quickly (.c --> .h etc) 
        -- :AS splits and switches
        -- :AV vertical splits and switches     -- :A switches to the header file corresponding to the current file being edited (or vise versa)
        "vim-scripts/a.vim",
        lazy = false,
    },
    {
        -- https://github.com/ap/vim-buftabline
        -- 完全是vim设计的插件，也可以在NVim中使用, 而且可以简单加载和使用
        'ap/vim-buftabline',
        lazy = false, -- 如果需要立即加载，可以设置为 false
        config = function()
            -- 这里可以添加插件的配置代码
            -- 例如设置显示选项
            vim.g.buftabline_show = 2
            vim.g.buftabline_numbers = 2
            -- 使用循环添加快捷键映射
            for i = 1, 9 do
                -- <C-2>: 错误！Ctrl键已经被占用，和"tag"相关
                vim.keymap.set('n', '<leader>' .. i, '<Plug>BufTabLine.Go(' .. i .. ')', { noremap = true, silent = true })
            end
            -- 为 leader + 0 映射到第 10 个缓冲区
            vim.api.nvim_set_keymap('n', '<leader>0', '<Plug>BufTabLine.Go(10)', { noremap = true, silent = true })
        end
    },
}

return plugins
