-- require("notify")("YiX plugins")
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
}

return plugins
