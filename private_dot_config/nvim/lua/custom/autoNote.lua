local journalDir = "journal"
local notesDir = "notes"

local function makeNote(dirname)
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

  if dirname ~= journalDir then
    local confirm = vim.fn.confirm("custom filename?", "&y\n&n", 2)
    if confirm == 1 then
      local fn_override = vim.fn.input("filename: ")
      filename = fn_override
    end
  end

  local fullpath = "./" .. dirname .. "/" .. filename

  local file = io.open(fullpath, "a")
  if file then
    file:close()
  end

  vim.cmd("e " .. fullpath) -- open file

  if vim.fn.getfsize(fullpath) == 0 and filename:match(".*.md") then
    local content = ""
    if dirname == journalDir then
      local confirm = vim.fn.confirm("at the office?", "&y\n&n", 2)
      if confirm == 1 then
        content = "journal\n\nOFFICE\n\n"
      else
        content = "journal\n\nHOME\n\n"
      end
    end

    vim.api.nvim_input("i# " .. content)
  end -- enter insert mode & start file with a heading
end

vim.api.nvim_create_user_command("AutoNoteJournal", function()
  return makeNote(journalDir)
end, {})

vim.api.nvim_create_user_command("AutoNoteNote", function()
  return makeNote(notesDir)
end, {})

vim.api.nvim_create_user_command("AutoNoteRoot", function()
  return makeNote(".")
end, {})

return {}
