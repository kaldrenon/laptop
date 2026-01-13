-- Keymaps
local k = vim.keymap

-- EasyDotnet
k.set('n', '<space>db', ':Dotnet build<cr>')
k.set('n', '<space>dr', ':Dotnet run<cr>')
k.set('n', '<space>dt', ':Dotnet testrunner<cr>')

-- Telescope
local builtin = require('telescope.builtin')
k.set('n', '<C-o>', builtin.find_files, { desc = 'Telescope find files' })
k.set('n', '<C-p>', builtin.live_grep, { desc = 'Telescope live grep' })
k.set('n', '<C-b>', builtin.buffers, { desc = 'Telescope buffers' })
k.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

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

k.set({"i"}, "<C-j>", function() ls.expand() end, {silent = true})

k.set({"i", "s"}, "<C-L>", function() ls.jump(1) end, {silent = true})
k.set({"i", "s"}, "<C-H>", function() ls.jump(-1) end, {silent = true})

k.set({"i", "s"}, "<C-e>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, {silent = true})

-- Better yank
k.set('n', 'Y', 'y$')
k.set('n', 'gy', '"+y')

-- Uncomment these and comment the ones above to enable tmux nav
k.set('n', '<C-h>', ':TmuxNavigateLeft<cr>', { silent = true })
k.set('n', '<C-j>', ':TmuxNavigateDown<cr><C-w>_zz', { silent = true })
k.set('n', '<C-k>', ':TmuxNavigateUp<cr><C-w>_zz', { silent = true })
k.set('n', '<C-l>', ':TmuxNavigateRight<cr>', { silent = true })

-- Fast zoom and even-out
k.set('n', '<C-m>', '<C-w>_', { silent = true })

-- recapitalize a word
k.set('n', '<space>c', 'viw~', { silent = true })

-- Syntax and Lint
k.set('n', '<space>sc', ':SyntasticCheck<cr>', { silent = true })
k.set('n', '<space>sC', ':lclose<cr><C-w>_', { silent = true })

-- * search in visual mode
k.set('v', '*', 'y/<C-r>"<cr>')
k.set('v', '<Tab>', ':Tabularize<space>/')

-- Mappings for common Tabularizations
k.set('n', '<Leader>a=', ':Tabularize /=<CR>')
k.set('v', '<Leader>a=', ':Tabularize /=<CR>')
k.set('n', '<Leader>a:', ':Tabularize /:\zs<CR>')
k.set('v', '<Leader>a:', ':Tabularize /:\zs<CR>')

-- Bi-directional find motion
-- Jump to anywhere you want with minimal keystrokes, with just one key binding.
-- Version 2 Needs one more keystroke, but on average, it may be more comfortable.
k.set('n', 's', '<Plug>(easymotion-s)')
k.set('n', 'S', '<Plug>(easymotion-s2)')
k.set('n', 't', '<Plug>(easymotion-t)')
k.set('n', 'T', '<Plug>(easymotion-T2)')

k.set('n', '<space>tn', ':TestNearest<CR>', { silent = true })
k.set('n', '<space>tf', ':TestFile<CR>', { silent = true })
k.set('n', '<space>ts', ':TestSuite<CR>', { silent = true })
k.set('n', '<space>tl', ':TestLast<CR>', { silent = true })
k.set('n', '<space>tg', ':TestVisit<CR>', { silent = true })

-- JK motions: Line motions
k.set('n', '<Leader>j', '<Plug>(easymotion-j)')
k.set('n', '<Leader>k', '<Plug>(easymotion-k)')

-- replace incremental search
k.set('n', '/', '<Plug>(easymotion-sn)')
k.set('n', '/', '<Plug>(easymotion-tn)')
k.set('n', '?', '<Plug>(easymotion-sn)')
k.set('n', '?', '<Plug>(easymotion-tn)')

-- replace n/N for fast targeting
k.set('n', '<space>n', '<Plug>(easymotion-next)')
k.set('n', '<space>N', '<Plug>(easymotion-prev)')

-- Highlight long rows
-- ctermbg 52 is dark red
-- TODO: Only apply this in certain fts

-- Jump around
k.set('n', 'z[', '{zt')
k.set('n', 'z]', '}zt')

-- Netrw
k.set('n', '<space>gn', ':Explore<cr>', { silent = true })


