-- カラースキーム（旧 vim-hybrid の代替に tokyonight）
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- 他プラグインより先に読み込む
    config = function()
      require("tokyonight").setup({ style = "night" })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
