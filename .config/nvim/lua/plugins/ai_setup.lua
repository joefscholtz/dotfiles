local function get_merged_conventions()
  local global_path = vim.fn.expand("~/.config/nvim/CONVENTIONS.md")
  local local_path = vim.fn.getcwd() .. "/CONVENTIONS.md"
  local content = "# SYSTEM INSTRUCTIONS\n"

  -- Read Global
  local f_global = io.open(global_path, "r")
  if f_global then
    content = content .. f_global:read("*all") .. "\n\n"
    f_global:close()
  end

  -- Read Local (if project-specific exists)
  local f_local = io.open(local_path, "r")
  if f_local then
    content = content .. "# PROJECT CONTEXT\n" .. f_local:read("*all")
    f_local:close()
  end

  return content
end

return {
  -- 1. Avante setup
  {
    "yetone/avante.nvim",
    opts = function(_, opts)
      opts.provider = "ollama"
      opts.vendors = {
        ollama = {
          __inherited_from = "openai",
          api_key_name = "",
          endpoint = "http://127.0.0.1:11434/v1",
          model = "deepseek-coder-v2:16b",
        },
      }
      -- NATIVE RULES CONFIG (2026 Stable Way)
      opts.rules = {
        -- Path to your global conventions
        global_dir = vim.fn.expand("~/.config/nvim/"),
        -- Name of the file it should look for (Global & Local)
        project_dir = ".", -- Current project root
      }
      -- This tells Avante to look for CONVENTIONS.md instead of avante.md
      opts.instructions_file = "CONVENTIONS.md"

      -- Force manual review to prevent the AI from acting before you approve
      opts.behaviour = { auto_apply_diff_after_generation = false }
    end,
  },

  -- 2. Aider setup
  {
    "GeorgesAlkhouri/nvim-aider",
    opts = function(_, opts)
      local global_path = vim.fn.expand("~/.config/nvim/CONVENTIONS.md")
      opts.args = {
        "--model",
        "ollama/deepseek-v3.2:16b",
        "--read",
        global_path, -- Always load global
        "--no-auto-commits",
      }
      -- If local conventions exist, add them too
      if vim.loop.fs_stat(vim.fn.getcwd() .. "/CONVENTIONS.md") then
        table.insert(opts.args, "--read")
        table.insert(opts.args, "CONVENTIONS.md")
      end
    end,
  },
}
