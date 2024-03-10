return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    -- default_component_configs = {
    --   name = {
    --     use_git_status_colors = false,
    --   },
    -- },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        always_show = {
          ".gitignore",
          ".env",
        },
      },
    },
  },
}
