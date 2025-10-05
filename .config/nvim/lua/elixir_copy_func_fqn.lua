local M = {}

local function get_node_text(node, bufnr)
  return vim.treesitter.get_node_text(node, bufnr or 0)
end

local function find_parent(node, type_name)
  while node do
    if node:type() == type_name then return node end
    node = node:parent()
  end
  return nil
end

function M.elixir_copy_func_fqn()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]

  local parser = vim.treesitter.get_parser(bufnr, "elixir")
  local tree = parser:parse()[1]
  local root = tree:root()
  local node = root:named_descendant_for_range(row, col, row, col)

  -- find enclosing def/defp 'call' node
  local def_node = node
  while def_node do
    if def_node:type() == "call" then
      local head = def_node:child(0)
      if head then
        local head_text = get_node_text(head, bufnr) or ""
        if head_text:match("^defp?$") then
          break
        end
      end
    end
    def_node = def_node:parent()
  end

  if not def_node then
    vim.notify("Cursor not inside a function definition", vim.log.levels.WARN)
    return
  end

  -- get the raw name text (may include args)
  local fun_expr = def_node:child(1)
  local raw_name
  if fun_expr and fun_expr:type() == "call" then
    local inner = fun_expr:child(0)
    raw_name = get_node_text(inner, bufnr)
  else
    raw_name = get_node_text(fun_expr, bufnr)
  end
  raw_name = raw_name or ""

  -- CLEANUP: strip (args), guards and trailing 'do', then trim
  raw_name = raw_name:gsub("%s*%b()", "")    -- remove balanced parentheses and contents
  raw_name = raw_name:gsub("%s+when.*$", "") -- remove guards
  raw_name = raw_name:gsub("%s*do%s*$", "")  -- remove trailing 'do'
  raw_name = raw_name:match("^%s*(.-)%s*$")  -- trim

  local func_name = raw_name
  if func_name == "" then
    vim.notify("Couldn't determine function name", vim.log.levels.WARN)
    return
  end

  -- find all enclosing module names (walk ancestors, collect all)
  local module_parts = {}
  local cur = def_node
  while cur do
    if cur:type() == "call" then
      local h = get_node_text(cur:child(0), bufnr) or ""
      if h == "defmodule" then
        local mod_node = cur:child(1)
        local mod_name = get_node_text(mod_node, bufnr)
        -- insert at beginning to maintain outer-to-inner order
        table.insert(module_parts, 1, mod_name)
      end
    end
    cur = cur:parent()
  end

  if #module_parts == 0 then
    vim.notify("No enclosing module found", vim.log.levels.WARN)
    return
  end

  local full_path = table.concat(module_parts, ".") .. "." .. func_name

  -- write to unnamed and system clipboard (pcall for safety)
  vim.fn.setreg('"', full_path)
  pcall(vim.fn.setreg, '+', full_path)

  print(full_path)
end

vim.api.nvim_create_user_command("ElixirCopyFuncFqn", function()
  M.elixir_copy_func_fqn()
end, {})

return M
