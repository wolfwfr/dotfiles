return {
  {
    "christoomey/vim-tmux-navigator",
    -- lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    -- source: https://github.com/NickvanDyke/opencode.nvim/issues/49
    -- init = function()
    --   -- Reusable function to register keymaps in different contexts
    --   local function set_keymaps()
    --     vim.keymap.set({ "n", "t", "v" }, "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
    --     vim.keymap.set({ "n", "t", "v" }, "<C-j>", "<cmd>TmuxNavigateDown<cr>")
    --     vim.keymap.set({ "n", "t", "v" }, "<C-k>", "<cmd>TmuxNavigateUp<cr>")
    --     vim.keymap.set({ "n", "t", "v" }, "<C-l>", "<cmd>TmuxNavigateRight<cr>")
    --     vim.keymap.set({ "n", "t", "v" }, "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")
    --   end
    --
    --   -- Register once globally
    --   set_keymaps()
    --
    --   -- Re-register for terminal buffers to prevent literal command injection
    --   vim.api.nvim_create_autocmd("TermOpen", {
    --     callback = set_keymaps,
    --   })
    -- end,
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
