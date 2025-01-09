# read me

# [NvChad Main Config Structure](https://nvchad.com/docs/config/walkthrough/)
1. NvChad/starter - This is a minimal config which shows how to use the nvchad repo(https://github.com/NvChad/NvChad) as a plugin.
2. 'NvChad/NvChad' is located at '~/.local/share/nvim/nvchad/'
3. Another method way to use'NvChad/NvChad' is "git clone https://github.com/NvChad/NvChad"  
4. 'Chadrc.lua' is user's conifg. It have the same Structure of 'NvChad/nvconfig.lua'
    and will Overide 'NvChad/nvconfig.lua'

# plugins
0. lazy.nvim manage plugins.
  - plugin may write in 'plugins/init.lua' or 'plugins/plugins_yix.lua' beacuse lazy will automatically
    load all files under plugins. 
    It will error when you write a 'error statement' in config. You can check it if it works.
    'https://lazy.folke.io/usage/structuring': Any lua file
        in ~/.config/nvim/lua/plugins/*.lua will be automatically merged in the main plugin spec.
  - A plugin usually include 2: install and setup, for example 'stevearc/aerial.nvim'. 
  - install: Write 'author/plugin' in plugins/init.lua(or plugins_yix.lua), 
        lazy will install automatically. vim command ':Lazy' to check.
  - setup is config which use 'require("plugin").setup({...})' . 
    setup is placed in plugins/init.lua(or plugins_yix.lua) with install together.
    config file located on configs/a_plugin_config.lua.
  ```lua
        config = function()
          -- find config file in 'lua/configs/aerial.lua'
          require "configs.aerial"
        end,
```
  - key map is placed in 'lua/mappings.lua'
  - lazy will delay load a plugin by default. 
    This might look like an error, but it's actually correct. It's just that it hasn't been loaded yet.  
    You trigger it with 'command, event, file type'. or 'lazy = false,',
    ref to  'https://lazy.folke.io/spec/lazy_loading'.
  
1. add my all plugins to lua/plugins/plugins_yix.lua in order to avoid pollution.
2. use plugin "rcarriga/nvim-notify" to add messages
  - 'require("notify")("My super important message")'
  - ":Notifications": show all messages.
  - 'echo()/vim.api.nvim_echo()/print()' -> ':messages': DO NOT work!
3. use "nvim-treesitter/nvim-treesitter-textobjects" to add textobject.
  - "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  - refer to "https://www.josean.com/posts/nvim-treesitter-and-textobjects",
    "https://martinlwx.github.io/en/learn-to-use-text-objects-in-vim/"
  - "vai", "vam" "]m", "]f"
  - "nvim-treesitter"
  - require("nvim-treesitter.configs").setup({ textobject={...} }) do not pollute NvChad's inbuilt 'nvim-treesitter' config!!!
4. use plugin "stevearc/aerial.nvim" for code outline instead of 'tagbar' or 'taglist' 

# Use tabs when working on different projects. Like one tab for server codes and one tab for client codes.
1. ':tabnew'->':tcd' => number will show up on the right-top corner. => switch with ':tabnext' and ':tabprev'
# Use Ctrl-^ to instantly jump between the current buffer and the last accessed one.
