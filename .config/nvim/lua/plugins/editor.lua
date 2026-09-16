-- 編集補助
return {
  -- 括弧の自動補完（旧 lexima.vim の代替）
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  -- 自作プラグイン（バイオインフォ系）はそのまま維持
  {
    "shohei1029/bio.nvim",
  },
}
