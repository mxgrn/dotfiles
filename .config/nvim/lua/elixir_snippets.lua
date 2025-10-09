-- Expands foo:bar to %{foo: foo, bar: bar}
local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

ls.add_snippets("elixir", {
  s({
    trig = "([%l|%d|_]+:[%l|%d|_]+)", -- Matches a line that contains at least one colon
    regTrig = true,
    wordTrig = false,
  }, {
    f(function(_, snip)
      local input = snip.captures[1]
      local words = {}
      -- Split on colons
      for w in input:gmatch("[^:]+") do
        table.insert(words, w)
      end

      local pairs = {}
      for _, w in ipairs(words) do
        table.insert(pairs, w .. ": " .. w)
      end

      return "%{" .. table.concat(pairs, ", ") .. "}"
    end, {}),
  }),
})

return false
