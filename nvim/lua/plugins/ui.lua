return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("tokyonight").setup()
      vim.cmd("colorscheme tokyonight-moon")
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      -- From https://github.com/LazyVim/LazyVim/blob/5115b585e7df4cedb519734ffc380b7e48a366f1/lua/lazyvim/util/mini.lua
      -- From https://github.com/LazyVim/LazyVim/blob/d35a3914bfc0c7c1000184585217d58a81f5da1a/lua/lazyvim/plugins/ui.lua#L310
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" }) -- no background for dropbar
    end,
  },

  -- {
  --   "mikavilpas/yazi.nvim",
  --   lazy = true, -- use `event = "VeryLazy"` for netrw replacement
  --   keys = {
  --     -- NOTE: my mapping <leader>lf is soo good but in the LSP cluster
  --     {
  --       "<leader>lf",
  --       "<cmd>Yazi<cr>",
  --       desc = "Open Yazi (file manager)",
  --     },
  --   },
  --   opts = {
  --     open_for_directories = true,
  --   },
  -- },
}
