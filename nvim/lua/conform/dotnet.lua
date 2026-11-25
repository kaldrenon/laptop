
---@type conform.FileFormatterConfig
return {
  meta = {
    url = "https://github.com/dotnet/sdk",
    description = "dotnet's built in formatter",
  },
  command = function()
    return "dotnet"
  end,
  args = function()
    return { "format", "$FILENAME" }
  end,
  stdin = true,
}
