return {
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup({
        render = function(props)
          local filename = vim.fn.expand("%:p:.")
          if filename == "neo-tree filesystem [1]" then
            filename = ""
          else
            filename = " " .. filename .. " "
          end
          return {
            -- see :help filename-modifiers
            -- and
            -- :help expand
            -- % = current file
            -- :p = expand to full path
            -- :. = make relative to current working directory

            filename,
            guibg = "#282727",
          }
        end,
      })
    end,
  },
}
