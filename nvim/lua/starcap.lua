-- Keymaps
-- Init
local k = vim.keymap
local builtin = require("telescope.builtin")
local ls = require("luasnip")
local harpoon = require("harpoon")
harpoon:setup()
local quicker = require("quicker")
local dap = require("dap")
local dap_pb = require("persistent-breakpoints.api")

-- Trinity Specific functions
k.set("n", "<space>tc", "", { silent = true })
k.set("n", "<space>ts", ":SarifLoad test/metrics/inspect.sarif<cr>:SarifView<cr>", { silent = true })
-- k.set("n", "<space>t", "", { silent = true })
-- k.set("n", "<space>t", "", { silent = true })
