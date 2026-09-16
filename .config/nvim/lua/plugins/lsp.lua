-- LSP（旧 ale の linter/補完サーバ・vim-racer の代替）
-- mason で言語サーバを管理し、nvim-lspconfig で設定する
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- cmp と連携する capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP がアタッチしたバッファ向けのキーマップ
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
          end
          map("gd", vim.lsp.buf.definition, "Goto Definition")
          map("gr", vim.lsp.buf.references, "References")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
        end,
      })

      -- 導入する言語サーバ（pyright: python, rust_analyzer: rust, gopls: go）
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "rust_analyzer", "gopls" },
      })

      -- capabilities を全サーバ共通のデフォルトに設定
      vim.lsp.config("*", { capabilities = capabilities })
    end,
  },
}
