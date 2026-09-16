-- ステータスライン（旧 vim-airline の代替）
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,
      },
      -- 旧 airline#extensions#tabline 相当（開いているバッファをタブライン表示）
      tabline = {
        lualine_a = {
          { "buffers", mode = 2, show_filename_only = true },
        },
      },
    },
  },
}
