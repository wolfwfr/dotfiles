return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
        always_show = {
          ".gitignore",
          ".env",
        },
      },
    },
  },
}
