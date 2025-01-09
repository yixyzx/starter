-- YiX: MUST NOT, CAN NOT add 'require "other_plugins"' here.
-- if 'require "other_plugins"' and 'unpack(other_plugins)', error: other_plugins is nil(null)
-- 'https://lazy.folke.io/usage/structuring'
-- Any lua file in ~/.config/nvim/lua/plugins/*.lua will be automatically merged in the main plugin spec.
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
  			"lua-language-server", "stylua",
  			"html-lsp", "css-lsp" , "prettier",
        "clangd",
        "pyright",
  		},
  	},
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css",
        "c", "cpp", "python", "php",
      },
    },
  },
}
