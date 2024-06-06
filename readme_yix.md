# read me

# [NvChad Main Config Structure](https://nvchad.com/docs/config/walkthrough/)
1. NvChad/starter - This is a minimal config which shows how to use the nvchad repo(https://github.com/NvChad/NvChad) as a plugin.
2. 'NvChad/NvChad' is located at '~/.local/share/nvim/nvchad/'
3. Another method way to use'NvChad/NvChad' is "git clone https://github.com/NvChad/NvChad"  
4. 'Chadrc.lua' is user's conifg. It have the same Structure of 'NvChad/nvconfig.lua'
    and will Overide 'NvChad/nvconfig.lua'

# plugins
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

# Use tabs when working on different projects. Like one tab for server codes and one tab for client codes.
1. ':tabnew'->':tabcd' => number will show up on the right-top corner. => switch with ':tabnext' and ':tabprev'
