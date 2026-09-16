-- シンタックスハイライト/インデント（旧 yajs.vim, rust.vim の syntax 部分の代替）
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- 従来 API（configs.setup）を使うため master に固定
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc",
        "python", "rust", "go",
        "javascript", "typescript",
        "bash", "toml", "json", "yaml", "markdown",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
