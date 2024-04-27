return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "python-lsp-server",
        "mypy",
        "black",
        "ruff",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = { timeout_ms = 10000 }
    }
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.black)
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["python"] = { "black" },
      },
    },
  }
}
