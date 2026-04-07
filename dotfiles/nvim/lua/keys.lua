-- Keymaps
-- Init
local k = vim.keymap
local builtin = require('telescope.builtin')
local ls = require("luasnip")
local harpoon = require('harpoon')
harpoon:setup()
local quicker = require('quicker')

--
-- Modmaps (Ctrl/Shift/Alt)
--

-- Telescope
vim.keymap.set({'i', 's'}, '<C-e>', function()
  ls.expand()
end, {silent = true})

vim.keymap.set({'i', 's'}, '<C-j>', function()
  if ls.jumpable(1) then
    ls.jump(1)
  else
    require('blink.cmp')['select_next']()
  end
end, {silent = true})

vim.keymap.set({'i', 's'}, '<C-k>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  else
    require('blink.cmp')['select_prev']()
  end
end, {silent = true})

k.set('n', '<C-o>', builtin.find_files, { desc = 'Telescope find files' })
k.set('n', '<C-p>', builtin.live_grep, { desc = 'Telescope live grep' })

--
-- Leadermaps
--
k.set("n", "<leader>a", function() harpoon:list():add() end)

-- Mappings for common Tabularizations
k.set('n', '<Leader>a=', ':Tabularize /=<CR>')
k.set('v', '<Leader>a=', ':Tabularize /=<CR>')
k.set('n', '<Leader>a:', ':Tabularize /:\zs<CR>')
k.set('v', '<Leader>a:', ':Tabularize /:\zs<CR>')


-- Telescope
k.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
k.set('n', '<leader>fs', ':Telescope luasnip<cr>', { desc = 'Telescope luasnip' })

-- Lazy
k.set('n', '<leader>ll', ':Lazy<cr>', { silent = true })
k.set('n', '<leader>lu', ':Lazy update<cr>', { silent = true })
k.set('n', '<leader>lx', ':Lazy clean<cr>', { silent = true })

-- Snippets
k.set('n', '<leader>se', ':LuaSnipEdit<cr>', { silent = true })

-- Trouble
k.set('n', '<leader>t', ':Trouble diagnostics toggle focus=true<cr>', { silent = true })
k.set('n', '<leader>tl', ':Trouble loclist toggle focus=true<cr>', { silent = true })
k.set('n', '<leader>tq', ':Trouble qflist toggle focus=true<cr>', { silent = true })

--
-- Spacemaps
--

-- EasyDotnet
k.set('n', '<space>db', ':Dotnet build<cr>', { silent = true })
k.set('n', '<space>dr', ':Dotnet run<cr>', { silent = true })
k.set('n', '<space>dt', ':Dotnet testrunner<cr>', { silent = true })
k.set('n', '<space>dlr', ':Dotnet lsp restart<cr>', { silent = true })

-- LSP
k.set('n', '<space>gd', ':lua vim.lsp.buf.definition()<cr>', { silent = true })
k.set('n', '<space>gf', ':lua vim.lsp.buf.references()<cr>', { silent = true })
k.set('n', '<space>gr', ':lua vim.lsp.buf.rename()<cr>', { silent = true })


--
-- nmaps
--
k.set('n', '-', ':Neotree toggle reveal left<CR>', { silent = true })

-- Swap j/k with gj/gk for normal, visual, and select modes
k.set({'n', 'x', 'v'}, 'j', 'gj')
k.set({'n', 'x', 'v'}, 'k', 'gk')
k.set({'n', 'x', 'v'}, 'gj', 'j')
k.set({'n', 'x', 'v'}, 'gk', 'k')

-- Join up
k.set('n', 'K', 'kJ')

-- Better yank
k.set('n', 'Y', 'y$')
k.set('n', 'gy', '"+y')


k.set('n', '<C-b>', ':BufferPick<cr>', { silent = true })
k.set('n', '<C-j>', ':BufferNext<cr>', { silent = true })
k.set('n', '<C-k>', ':BufferPrevious<cr>', { silent = true })

k.set('n', '<C-h>', ':TmuxNavigateLeft<cr>', { silent = true })
k.set('n', '<C-l>', ':TmuxNavigateRight<cr>', { silent = true })

-- Harpoon
k.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

k.set("n", "<A-1>", function() harpoon:list():select(1) end)
k.set("n", "<A-2>", function() harpoon:list():select(2) end)
k.set("n", "<A-3>", function() harpoon:list():select(3) end)
k.set("n", "<A-4>", function() harpoon:list():select(4) end)

-- Quicker
k.set("n", "<leader>q", function()
  quicker.toggle({focus = true})
end, {
  desc = "Toggle quickfix",
})

--
-- vmaps
--

-- * search in visual mode
k.set('v', '*', 'y/<C-r>"<cr>')
k.set('v', '<Tab>', ':Tabularize<space>/')
