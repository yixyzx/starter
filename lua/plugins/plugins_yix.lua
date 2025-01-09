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
}

return plugins
