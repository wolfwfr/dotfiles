return {
  {
    "rmagatti/auto-session",
    opts = {

      --
      auto_restore = true,
      auto_save = true,
      enabled = true,
      git_use_branch_name = true,
      log_level = "error",
      suppressed_dirs = { "~/" },

      -- ensures that neotree opens by default upon restore
      pre_save_cmds = { "Neotree close" },
      post_restore_cmds = { "Neotree filesystem show" },
      -- post_restore_cmds = {
      --   function()
      --     require("snacks.explorer").open({ enter = false })
      --   end,
      -- },
    },
  },
}
