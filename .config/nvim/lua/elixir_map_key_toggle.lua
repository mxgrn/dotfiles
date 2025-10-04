-- Toggle between string-key and atom-key Elixir maps (only the cursor's immediate map level)
local function toggle_elixir_map_keys()
  local ts = vim.treesitter
  local node = ts.get_node()

  if not node then
    vim.notify("No treesitter node found", vim.log.levels.WARN)
    return
  end

  -- Find the map node containing the cursor
  while node and node:type() ~= "map" do
    node = node:parent()
  end

  if not node or node:type() ~= "map" then
    vim.notify("Cursor not inside a map", vim.log.levels.WARN)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local start_row, start_col, end_row, end_col = node:range()

  -- Get the full text of this specific map
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, false)
  local map_text = table.concat(lines, "\n")

  -- Extract just this map's content (from the start to end of the node)
  if start_row == end_row then
    map_text = lines[1]:sub(start_col + 1, end_col)
  else
    local first_line = lines[1]:sub(start_col + 1)
    local last_line = lines[#lines]:sub(1, end_col)
    lines[1] = first_line
    lines[#lines] = last_line
    map_text = table.concat(lines, "\n")
  end

  -- Detect if it's a string-key or atom-key map
  local is_string_key = map_text:match('"%w+"%s*=>') ~= nil

  -- Parse and replace only direct children
  local new_text = map_text

  if is_string_key then
    -- Convert "key" => to key: but only at the immediate level
    -- Use a pattern that matches but preserves nested structures
    new_text = new_text:gsub('(%b{})([^}]*)', function(nested, after)
      -- This is a nested map, preserve it
      return nested .. after
    end)

    -- Now replace at the top level
    local depth = 0
    local result = {}
    local i = 1
    local skip_until = 0

    while i <= #map_text do
      if i < skip_until then
        i = i + 1
      else
        local two_char = map_text:sub(i, i + 1)

        if two_char == '%{' then
          depth = depth + 1
          result[#result + 1] = map_text:sub(i, i)
          i = i + 1
        elseif map_text:sub(i, i) == '}' then
          depth = depth - 1
          result[#result + 1] = map_text:sub(i, i)
          i = i + 1
        elseif depth == 1 then
          -- At the direct level of our map
          local key_match, spaces, arrow = map_text:match('^"(%w+)"(%s*)=>%s*', i)
          if key_match then
            result[#result + 1] = key_match .. ': '
            skip_until = i + #key_match + 2 + #spaces + 2 +
                #(map_text:match('^"' .. key_match .. '"' .. spaces .. '=>%s*', i):match('%s*$'))
            i = skip_until
          else
            result[#result + 1] = map_text:sub(i, i)
            i = i + 1
          end
        else
          result[#result + 1] = map_text:sub(i, i)
          i = i + 1
        end
      end
    end

    new_text = table.concat(result)
  else
    -- Convert key: to "key" => but only at the immediate level
    local depth = 0
    local result = {}
    local i = 1
    local skip_until = 0

    while i <= #map_text do
      if i < skip_until then
        i = i + 1
      else
        local two_char = map_text:sub(i, i + 1)

        if two_char == '%{' then
          depth = depth + 1
          result[#result + 1] = map_text:sub(i, i)
          i = i + 1
        elseif map_text:sub(i, i) == '}' then
          depth = depth - 1
          result[#result + 1] = map_text:sub(i, i)
          i = i + 1
        elseif depth == 1 then
          -- At the direct level of our map
          local prev_char = i > 1 and map_text:sub(i - 1, i - 1) or ''
          local key_match = map_text:match('^(%w+):%s*', i)
          if key_match and not prev_char:match('%w') then
            result[#result + 1] = '"' .. key_match .. '" => '
            skip_until = i + #key_match + 1 + #(map_text:match('^' .. key_match .. ':%s*', i):match('%s*$'))
            i = skip_until
          else
            result[#result + 1] = map_text:sub(i, i)
            i = i + 1
          end
        else
          result[#result + 1] = map_text:sub(i, i)
          i = i + 1
        end
      end
    end

    new_text = table.concat(result)
  end

  -- Replace the map content
  if start_row == end_row then
    local line = vim.api.nvim_buf_get_lines(bufnr, start_row, start_row + 1, false)[1]
    local before = line:sub(1, start_col)
    local after = line:sub(end_col + 1)
    vim.api.nvim_buf_set_lines(bufnr, start_row, start_row + 1, false, { before .. new_text .. after })
  else
    local new_lines = vim.split(new_text, "\n")
    local first_line = vim.api.nvim_buf_get_lines(bufnr, start_row, start_row + 1, false)[1]
    local last_line = vim.api.nvim_buf_get_lines(bufnr, end_row, end_row + 1, false)[1]

    new_lines[1] = first_line:sub(1, start_col) .. new_lines[1]
    new_lines[#new_lines] = new_lines[#new_lines] .. last_line:sub(end_col + 1)

    vim.api.nvim_buf_set_lines(bufnr, start_row, end_row + 1, false, new_lines)
  end

  local key_type = is_string_key and "atom" or "string"
  vim.notify("Toggled to " .. key_type .. "-key map", vim.log.levels.INFO)

  -- Make repeatable with dot command
  pcall(vim.fn['repeat#set'], ':ToggleElixirMapKeys\r')
end

-- Create the command
vim.api.nvim_create_user_command('ToggleElixirMapKeys', toggle_elixir_map_keys, {})

-- Optional: Add a keybinding (e.g., <leader>tm for "toggle map")
-- vim.keymap.set('n', '<leader>tm', toggle_elixir_map_keys, { desc = 'Toggle Elixir map keys' })

return false
