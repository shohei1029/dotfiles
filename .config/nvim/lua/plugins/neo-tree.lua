-- ファイルツリー（旧 nerdtree の代替）。<C-n> は keymaps.lua でトグル定義
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,      -- 隠しファイルを表示（旧 NERDTreeShowHidden = 1）
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
}
