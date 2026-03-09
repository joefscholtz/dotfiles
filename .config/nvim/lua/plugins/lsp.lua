return {
  {
    "mason-org/mason.nvim",
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
      format = { timeout_ms = 10000 },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["python"] = { "black" },
      },
    },
  },
}
