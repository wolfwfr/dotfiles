vim.api.nvim_create_user_command("AutoNote", function()
  local tabl = {
    ["ma"] = "mon",
    ["di"] = "tue",
    ["wo"] = "wed",
    ["do"] = "thu",
    ["vr"] = "fri",
    ["za"] = "sat",
    ["zo"] = "sun",
  }

  local function conv(d)
    if tabl[d] then
      return tabl[d]
    end
    return d
  end

  local time = os.date("%Y-%m-%d", os.time())
  local day = os.date("%a", os.time())
  local dayconv = conv(day)
  local filename = time .. " [" .. dayconv .. "]" .. ".md"

  vim.fn.jobstart({ "touch", filename }) -- create file

  vim.cmd("e " .. filename) -- open file

  if vim.fn.getfsize(filename) < 1 then
    vim.api.nvim_input("i# ")
  end -- enter insert mode & start file with a heading
end, {})

return {}
