return {
  {
    "nvim-telescope/telescope.nvim",
    -- change some options
    opts = {
      pickers = {
        find_files = {
          hidden = true,
        },
        -- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
    },
  },
}
