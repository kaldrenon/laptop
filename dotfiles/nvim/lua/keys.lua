-- Keymaps
local k = vim.keymap

-- Lazy
k.set('n', '<leader>ll', ':Lazy<cr>', { silent = true })
k.set('n', '<leader>lu', ':Lazy update<cr>', { silent = true })
k.set('n', '<leader>lx', ':Lazy clean<cr>', { silent = true })

-- EasyDotnet
k.set('n', '<space>db', ':Dotnet build<cr>', { silent = true })
k.set('n', '<space>dr', ':Dotnet run<cr>', { silent = true })
k.set('n', '<space>dt', ':Dotnet testrunner<cr>', { silent = true })
k.set('n', '<space>dlr', ':Dotnet lsp restart<cr>', { silent = true })

-- LSP
k.set('n', '<space>gd', ':lua vim.lsp.buf.definition()<cr>', { silent = true })
k.set('n', '<space>gf', ':lua vim.lsp.buf.references()<cr>', { silent = true })
k.set('n', '<space>gr', ':lua vim.lsp.buf.rename()<cr>', { silent = true })

-- Trouble
k.set('n', 'gtd', ':Trouble diagnostics toggle<cr>', { silent = true })
k.set('n', 'gtl', ':Trouble loclist toggle<cr>', { silent = true })
k.set('n', 'gtq', ':Trouble qflist toggle<cr>', { silent = true })

-- Telescope
local builtin = require('telescope.builtin')
k.set('n', '<C-o>', builtin.find_files, { desc = 'Telescope find files' })
k.set('n', '<C-p>', builtin.live_grep, { desc = 'Telescope live grep' })
k.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
k.set('n', '<leader>fs', ':Telescope luasnip<cr>', { desc = 'Telescope luasnip' })

-- Swap j/k with gj/gk for normal, visual, and select modes
k.set({'n', 'x', 'v'}, 'j', 'gj')
k.set({'n', 'x', 'v'}, 'k', 'gk')
k.set({'n', 'x', 'v'}, 'gj', 'j')
k.set({'n', 'x', 'v'}, 'gk', 'k')

-- Join up
k.set('n', 'K', 'kJ')

-- Clear search highlighting with \c
k.set('n', '<space>l', ':nohls<CR>', { silent = true })

k.set('n', '-', ':Neotree toggle reveal left<CR>', { silent = true })

-- reduce down to current buffer
k.set('n', '<Leader>o', ':only<cr>', { silent = true })

-- Snippets
local ls = require("luasnip")

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

k.set('n', '<leader>se', ':LuaSnipEdit<cr>', { silent = true })

-- Better yank
k.set('n', 'Y', 'y$')
k.set('n', 'gy', '"+y')

k.set('n', '<C-h>', ':TmuxNavigateLeft<cr>', { silent = true })
k.set('n', '<C-l>', ':TmuxNavigateRight<cr>', { silent = true })

k.set('n', '<C-j>', ':BufferNext<cr>', { silent = true })
k.set('n', '<C-k>', ':BufferPrevious<cr>', { silent = true })
k.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { silent = true })
k.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { silent = true })
k.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { silent = true })
k.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { silent = true })
k.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { silent = true })
k.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { silent = true })
k.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { silent = true })
k.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { silent = true })
k.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { silent = true })
k.set('n', '<C-b>', ':BufferPick<cr>', { silent = true })

-- Fast zoom and even-out
k.set('n', '<C-m>', '<C-w>_', { silent = true })

-- recapitalize a word
k.set('n', '<space>c', 'viw~', { silent = true })

-- * search in visual mode
k.set('v', '*', 'y/<C-r>"<cr>')
k.set('v', '<Tab>', ':Tabularize<space>/')

-- Mappings for common Tabularizations
k.set('n', '<Leader>a=', ':Tabularize /=<CR>')
k.set('v', '<Leader>a=', ':Tabularize /=<CR>')
k.set('n', '<Leader>a:', ':Tabularize /:\zs<CR>')
k.set('v', '<Leader>a:', ':Tabularize /:\zs<CR>')

-- Highlight long rows
-- ctermbg 52 is dark red
-- TODO: Only apply this in certain fts

-- Jump around
k.set('n', 'z[', '{zt')
k.set('n', 'z]', '}zb')

-- Netrw
k.set('n', '<space>gn', ':Explore<cr>', { silent = true })

