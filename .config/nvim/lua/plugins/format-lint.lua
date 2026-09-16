-- フォーマット/リント（旧 ale の fixer/linter・yapf・rustfmt・goimports の代替）
return {
  -- フォーマッタ（conform.nvim）
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<C-y>", -- 旧 yapf の <C-Y> を踏襲した手動フォーマット
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "i" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        python = { "yapf" },
        rust = { "rustfmt" },
        go = { "goimports" },
      },
      -- go は旧 ale_fix_on_save 相当で保存時フォーマット
      format_on_save = function(bufnr)
        if vim.bo[bufnr].filetype == "go" then
          return { timeout_ms = 2000, lsp_format = "fallback" }
        end
      end,
    },
  },
  -- リンタ（nvim-lint）。旧 ale の python: pylint 相当
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "pylint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
