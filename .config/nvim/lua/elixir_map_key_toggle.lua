-- Helper to get text from a node
local function get_node_text(node, bufnr)
  local start_row, start_col, end_row, end_col = node:range()
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, false)

  if #lines == 0 then
    return ""
  end

  if start_row == end_row then
    return lines[1]:sub(start_col + 1, end_col)
  else
    lines[1] = lines[1]:sub(start_col + 1)
    lines[#lines] = lines[#lines]:sub(1, end_col)
    return table.concat(lines, "\n")
  end
end

-- Helper to get direct children of a node
local function get_direct_children(node)
  local children = {}
  for child in node:iter_children() do
    table.insert(children, child)
  end
  return children
end

-- Replace node text in buffer
local function replace_node(bufnr, node, new_text)
  local start_row, start_col, end_row, end_col = node:range()

  if start_row == end_row then
    local line = vim.api.nvim_buf_get_lines(bufnr, start_row, start_row + 1, false)[1]
    local before = line:sub(1, start_col)
    local after = line:sub(end_col + 1)
    vim.api.nvim_buf_set_lines(bufnr, start_row, start_row + 1, false, { before .. new_text .. after })
  else
    local new_lines = vim.split(new_text, "\n", { plain = true })
    local first_line = vim.api.nvim_buf_get_lines(bufnr, start_row, start_row + 1, false)[1]
    local last_line = vim.api.nvim_buf_get_lines(bufnr, end_row, end_row + 1, false)[1]

    new_lines[1] = first_line:sub(1, start_col) .. new_lines[1]
    new_lines[#new_lines] = new_lines[#new_lines] .. last_line:sub(end_col + 1)

    vim.api.nvim_buf_set_lines(bufnr, start_row, end_row + 1, false, new_lines)
  end
end

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

  -- Debug: inspect the map structure
  local function debug_node(n, depth)
    depth = depth or 0
    local indent = string.rep("  ", depth)
    print(indent .. n:type())
    for child in n:iter_children() do
      debug_node(child, depth + 1)
    end
  end

  -- Uncomment to debug:
  -- debug_node(node)

  -- Find map_content node
  local map_content = nil
  for child in node:iter_children() do
    if child:type() == "map_content" then
      map_content = child
      break
    end
  end

  if not map_content then
    vim.notify("Map has no content", vim.log.levels.WARN)
    return
  end

  -- Get all direct key-value pairs from map_content
  -- Structure can be either:
  -- 1. map_content -> binary_operator nodes (for "key" => value syntax)
  -- 2. map_content -> keywords -> pair nodes (for key: value syntax)
  local pairs = {}
  local is_keyword_syntax = false

  for child in map_content:iter_children() do
    if child:type() == "binary_operator" then
      -- Check if it's an => operator
      local op_text = get_node_text(child, bufnr)
      if op_text:match("^.-=>") then
        table.insert(pairs, child)
      end
    elseif child:type() == "keywords" then
      is_keyword_syntax = true
      -- Get pairs from within keywords node
      for pair_node in child:iter_children() do
        if pair_node:type() == "pair" then
          table.insert(pairs, pair_node)
        end
      end
    end
  end

  if #pairs == 0 then
    vim.notify("No key-value pairs found", vim.log.levels.WARN)
    return
  end

  -- Build the new map content based on syntax type
  if is_keyword_syntax then
    -- Convert key: value to "key" => value
    -- Structure: pair -> keyword, value
    local new_pairs = {}

    for i, pair in ipairs(pairs) do
      local pair_children = get_direct_children(pair)
      local keyword_node = nil
      local value_node = nil

      for _, child in ipairs(pair_children) do
        if child:type() == "keyword" then
          keyword_node = child
        elseif keyword_node and child:type() ~= "," then
          value_node = child
          break
        end
      end

      if keyword_node and value_node then
        local key_text = get_node_text(keyword_node, bufnr)
        -- Remove trailing colon and any whitespace
        key_text = key_text:gsub(":%s*$", "")
        local value_text = get_node_text(value_node, bufnr)
        table.insert(new_pairs, '"' .. key_text .. '" => ' .. value_text)
      end
    end

    if #new_pairs > 0 then
      -- Find the keywords node and replace it
      local keywords_node = nil
      for child in map_content:iter_children() do
        if child:type() == "keywords" then
          keywords_node = child
          break
        end
      end

      if keywords_node then
        local new_text = table.concat(new_pairs, ", ")
        replace_node(bufnr, keywords_node, new_text)
      end
    end

    vim.notify("Toggled to string-key map", vim.log.levels.INFO)
  else
    -- Convert "key" => value to key: value
    -- Structure: binary_operator -> string (key), "=>", value
    local new_pairs = {}

    for i, binary_op in ipairs(pairs) do
      local op_children = get_direct_children(binary_op)

      -- First child should be the key (string), last should be the value
      local key_node = op_children[1]
      local value_node = op_children[#op_children]

      if key_node and key_node:type() == "string" and value_node then
        -- Extract quoted_content from string node
        local quoted_content = nil
        for child in key_node:iter_children() do
          if child:type() == "quoted_content" then
            quoted_content = child
            break
          end
        end

        if quoted_content then
          local key_text = get_node_text(quoted_content, bufnr)
          local value_text = get_node_text(value_node, bufnr)
          table.insert(new_pairs, key_text .. ": " .. value_text)
        end
      end
    end

    if #new_pairs > 0 then
      local new_text = table.concat(new_pairs, ", ")
      replace_node(bufnr, map_content, new_text)
    end

    vim.notify("Toggled to atom-key map", vim.log.levels.INFO)
  end

  -- Make repeatable with dot command
  pcall(vim.fn['repeat#set'], ':ToggleElixirMapKeys\r')
end

-- Create the command
vim.api.nvim_create_user_command('ToggleElixirMapKeys', toggle_elixir_map_keys, {})

-- Optional: Add a keybinding (e.g., <leader>tm for "toggle map")
-- vim.keymap.set('n', '<leader>tm', toggle_elixir_map_keys, { desc = 'Toggle Elixir map keys' })

return false
