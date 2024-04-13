return {
  {
    "rmagatti/auto-session",
    opts = {
      log_level = "error",
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_use_git_branch = true,
      auto_session_suppress_dirs = { "~/" },

      -- ensures that neotree opens by default upon restore
      pre_save_cmds = { "Neotree close" },
      post_restore_cmds = { "Neotree filesystem show" },
    },
  },
}
