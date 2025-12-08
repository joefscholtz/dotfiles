return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- VimTeX configuration goes here, e.g.
      -- vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_method = "zathura"
      -- From: https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt#L4671-L4713
      -- vim.o.foldmethod = "expr"
      -- vim.o.foldexpr = "vimtex#fold#level(v:lnum)"
      -- vim.o.foldtext = "vimtex#fold#text()"
      -- I like to see at least the content of the sections upon opening
      -- vim.o.foldlevel = 2
      -- vim.g.vimtex_compiler_latexmk = {
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-shell-escape", -- require in order for svg package to conver svg to pdf using Inkscape headless
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.highlight = opts.highlight or {}
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
      end
      if type(opts.highlight.disable) == "table" then
        vim.list_extend(opts.highlight.disable, { "latex" })
      else
        opts.highlight.disable = { "latex" }
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        texlab = {},
      },
    },
  },
}
