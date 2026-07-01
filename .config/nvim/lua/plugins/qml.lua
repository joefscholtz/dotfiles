return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "qmlls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        qmlls = {
          root_markers = {
            ".git",
            "qmldir",
            "*.qmlproject",
            ".qmlproject",
          },
          cmd = {
            "qmlls6",
          },
          filetypes = { "qml", "qmljs" },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "qmljs" })
      end
    end,
  },
}
