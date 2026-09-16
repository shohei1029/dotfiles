-- lazy.nvim ブートストラップ
-- プラグイン本体は stdpath("data")/lazy 以下（リポジトリ外）に入るため
-- dotfiles リポジトリが汚れることはない。
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- lua/plugins 以下の spec を自動 import
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- luarocks を必要とするプラグインは無いので rocks サポートごと無効化
  -- （:checkhealth の luarocks/hererocks 警告を抑止）
  rocks = { enabled = false },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = false },
  change_detection = { notify = false },
})
