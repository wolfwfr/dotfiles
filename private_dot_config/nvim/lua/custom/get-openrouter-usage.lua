local function create_floating_window(content)
  -- Calculate dimensions
  local width = 60
  local height = 6
  local win_height = vim.api.nvim_get_option("lines")
  local win_width = vim.api.nvim_get_option("columns")
  local row = math.floor((win_height - height) / 2)
  local col = math.floor((win_width - width) / 2)

  -- Create buffer for the floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, content)

  -- Set up window options
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  }

  -- Create and configure the window
  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_win_set_option(win, "wrap", false)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")

  -- Add keymap to close the window
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", { silent = true, noremap = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":q<CR>", { silent = true, noremap = true })

  return buf, win
end

local function update_window_content(buf, win, content)
  if vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_buf_set_option(buf, "modifiable", true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, content)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
  end
end

local function start_spinner(buf, win, base_content)
  local spinner_chars = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local spinner_index = 1
  local spinner_timer = nil

  local function update_spinner()
    if not vim.api.nvim_win_is_valid(win) then
      if spinner_timer then
        spinner_timer:stop()
        spinner_timer:close()
      end
      return
    end

    local content = vim.deepcopy(base_content)
    content[3] = "Loading... " .. spinner_chars[spinner_index]
    update_window_content(buf, win, content)

    spinner_index = spinner_index % #spinner_chars + 1
  end

  -- Start the spinner animation
  spinner_timer = vim.loop.new_timer()
  spinner_timer:start(0, 100, vim.schedule_wrap(update_spinner))

  return spinner_timer
end

local function get_openrouter_usage()
  local api_key_hash = io.popen("pass show innius.openrouter.ai/api_key_hash"):read("*a"):gsub("\n", "")
  local api_key = io.popen("pass show innius.openrouter.ai/provisioning/api_key"):read("*a"):gsub("\n", "")
  local url = "https://openrouter.ai/api/v1/keys/" .. api_key_hash

  -- Create loading content template
  local loading_content = {
    "OpenRouter API Usage Statistics",
    "",
    "Loading... ⠋",
    "",
    "",
    "Press 'q' or <Esc> to close",
  }

  -- Create and show the floating window immediately
  local buf, win = create_floating_window(loading_content)

  -- Start the animated spinner
  local spinner_timer = start_spinner(buf, win, loading_content)

  -- Perform the network call asynchronously
  local command = { "curl", "-s", "-H", "Authorization: Bearer " .. api_key, url }

  vim.system(command, {}, function(result)
    vim.schedule(function()
      -- Stop the spinner
      if spinner_timer then
        spinner_timer:stop()
        spinner_timer:close()
      end

      if result.code ~= 0 then
        local error_content = {
          "OpenRouter API Usage Statistics",
          "",
          "Error: Failed to fetch data",
          "Exit code: " .. result.code,
          "",
          "Press 'q' or <Esc> to close",
        }
        update_window_content(buf, win, error_content)
        return
      end

      local json = vim.fn.json_decode(result.stdout)
      if not json or not json.data then
        local error_content = {
          "OpenRouter API Usage Statistics",
          "",
          "Error: Failed to parse response",
          "",
          "",
          "Press 'q' or <Esc> to close",
        }
        update_window_content(buf, win, error_content)
        return
      end

      local limit = json.data.limit
      local limit_remaining = json.data.limit_remaining
      local percent_remaining = (limit_remaining / limit) * 100

      -- Create final content for the floating window
      local content = {
        "OpenRouter API Usage Statistics",
        "",
        string.format("Total Limit: %d | Remaining: %.4f", limit, limit_remaining),
        string.format("Remaining: %.2f%%", percent_remaining),
        "",
        "Press 'q' or <Esc> to close",
      }

      update_window_content(buf, win, content)
    end)
  end)
end

vim.api.nvim_create_user_command("OpenRouterGetUsage", function()
  return get_openrouter_usage()
end, {})
-- vim.cmd("command! OpenRouterUsage lua get_openrouter_usage()")
return {}
