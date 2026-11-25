require("switchboard").setup({
  overlay_sleep = 5, -- sleep in seconds
  commands = {
    lazygit = "lazygit",
    dotnet_test = "dotnet test",
  },
  build_run_config = {
    {
      extension = { "cs" },
      commands = {
        build = "dotnet build --tl:off",
        run = "dotnet run --no-restore",
        test = "dotnet test",
        test_with_coverage = "/bin/bash ./scripts/test.sh",
      },
    },
  },
})
