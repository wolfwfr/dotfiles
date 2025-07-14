-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>/", "<C-W>v", { desc = "Split Window Right", remap = true })

-- vim.keymap.set("n", "<c-P>", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })

vim.keymap.set("n", "<leader>nj", "<cmd>AutoNoteJournal<CR>", { desc = "new journal entry (journal)" })
vim.keymap.set("n", "<leader>nn", "<cmd>AutoNoteNote<CR>", { desc = "new note (notes)" })
vim.keymap.set("n", "<leader>nr", "<cmd>AutoNoteRoot<CR>", { desc = "new note (root)" })

vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<CR>")
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<CR>")

vim.keymap.set("n", "<leader>tl", "<Plug>PlenaryTestFile", { desc = "plenary test file (lua)" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<leader>gn", "<CMD>Neogit<CR>", { desc = "Neogit" })
vim.keymap.set("v", "<leader>ae", "<CMD>'<,'> ChatGPTRun explain_code<CR>", { desc = "chat-gpt explain" })

-- lua dev convenience
vim.keymap.set("n", "<leader>r", "<CMD>:w<CR><CMD>:source %<CR>", { desc = "write and execute current file" })

vim.keymap.set("n", "<leader>MO", "<CMD>VimatrixOpen<CR>", {})
vim.keymap.set("n", "<leader>MS", "<CMD>VimatrixScreenSaverStop<CR>", {})
vim.keymap.set("n", "<leader>MA", "<CMD>VimatrixScreenSaverRestart<CR>", {})
vim.keymap.set("n", "<leader>MT", "<CMD>VimatrixStop<CR>", {})

-- TODO: cleanup
local function unwrap_lines()
  local s_buf, s_row, _ = unpack(vim.fn.getpos("v"))
  local _, e_row, _ = unpack(vim.fn.getpos("."))

  local selection = vim.api.nvim_buf_get_lines(s_buf, s_row - 1, e_row, false)
  local result = {}
  local current_segment = {}

  for _, line in ipairs(selection) do
    if line ~= "" then
      current_segment[#current_segment + 1] = line
    else
      if #current_segment > 0 then
        result[#result + 1] = table.concat(current_segment, " ")
        current_segment = {}
      end
      result[#result + 1] = "" -- Preserve empty lines
    end
  end

  if #current_segment > 0 then
    result[#result + 1] = table.concat(current_segment, " ") -- Add last accumulated line
  end

  vim.api.nvim_buf_set_lines(s_buf, s_row - 1, e_row, false, result)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
end
-- Bind to visual mode.
vim.keymap.set("v", "<leader>r", unwrap_lines, { noremap = true, silent = true })
