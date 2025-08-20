return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
    },
    config = function()
      require("diffview").setup({
        -- optional config
        enhanced_diff_hl = true,
      })
    end,
  },
}
