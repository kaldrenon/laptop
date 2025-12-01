-- Keymaps

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-o>', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Swap j/k with gj/gk for normal, visual, and select modes
vim.keymap.set({'n', 'x', 'v'}, 'j', 'gj')
vim.keymap.set({'n', 'x', 'v'}, 'k', 'gk')
vim.keymap.set({'n', 'x', 'v'}, 'gj', 'j')
vim.keymap.set({'n', 'x', 'v'}, 'gk', 'k')

-- Join up
vim.keymap.set('n', 'K', 'kJ')

-- Clear search highlighting with \c
vim.keymap.set('n', '<space>l', ':nohls<CR>', { silent = true })

vim.keymap.set('n', '-', ':NvimTreeToggle<CR>', { silent = true })

-- Various leader maps

-- reduce down to current buffer
vim.keymap.set('n', '<Leader>o', ':only<cr>', { silent = true })

-- lets me use snippets in mappings!
vim.keymap.set('i', '<c-b>', '<C-R>=UltiSnips_ExpandSnippetOrJump()<cr>', { silent = true })

-- minor cursor adjust without leaving insert mode
vim.keymap.set('i', '<C-h>', '<left>')
vim.keymap.set('i', '<C-l>', '<right>')

-- Save and quit in the ZZ ZQ family
vim.keymap.set('n', 'ZA', ':wqa<cr>')

-- Better yank
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'gy', '"+y')

-- Uncomment these and comment the ones above to enable tmux nav
vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<cr>', { silent = true })
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<cr><C-w>_zz', { silent = true })
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<cr><C-w>_zz', { silent = true })
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<cr>', { silent = true })
vim.keymap.set('n', '<C-\\>', ':TmuxNavigatePrevious<cr>', { silent = true })

-- Fast zoom and even-out
vim.keymap.set('n', '<C-=>', '<C-w>=', { silent = true })
vim.keymap.set('n', '<C-m>', '<C-w>_', { silent = true })

-- recapitalize a word
vim.keymap.set('n', '<space>c', 'viw~', { silent = true })

vim.keymap.set('n', '<space>sc', ':SyntasticCheck<cr>', { silent = true })
vim.keymap.set('n', '<space>sC', ':lclose<cr><C-w>_', { silent = true })

-- * search in visual mode
vim.keymap.set('v', '*', 'y/<C-r>"<cr>')
vim.keymap.set('v', '<Tab>', ':Tabularize<space>/')

-- Mappings for common Tabularizations
vim.keymap.set('n', '<Leader>a=', ':Tabularize /=<CR>')
vim.keymap.set('v', '<Leader>a=', ':Tabularize /=<CR>')
vim.keymap.set('n', '<Leader>a:', ':Tabularize /:\zs<CR>')
vim.keymap.set('v', '<Leader>a:', ':Tabularize /:\zs<CR>')

-- Bi-directional find motion
-- Jump to anywhere you want with minimal keystrokes, with just one key binding.
-- Version 2 Needs one more keystroke, but on average, it may be more comfortable.
vim.keymap.set('n', 's', '<Plug>(easymotion-s)')
vim.keymap.set('n', 'S', '<Plug>(easymotion-s2)')
vim.keymap.set('n', 't', '<Plug>(easymotion-t)')
vim.keymap.set('n', 'T', '<Plug>(easymotion-T2)')

vim.keymap.set('n', '<space>tn', ':TestNearest<CR>', { silent = true })
vim.keymap.set('n', '<space>tf', ':TestFile<CR>', { silent = true })
vim.keymap.set('n', '<space>ts', ':TestSuite<CR>', { silent = true })
vim.keymap.set('n', '<space>tl', ':TestLast<CR>', { silent = true })
vim.keymap.set('n', '<space>tg', ':TestVisit<CR>', { silent = true })

-- JK motions: Line motions
vim.keymap.set('n', '<Leader>j', '<Plug>(easymotion-j)')
vim.keymap.set('n', '<Leader>k', '<Plug>(easymotion-k)')

-- replace incremental search
vim.keymap.set('n', '/', '<Plug>(easymotion-sn)')
vim.keymap.set('n', '/', '<Plug>(easymotion-tn)')
vim.keymap.set('n', '?', '<Plug>(easymotion-sn)')
vim.keymap.set('n', '?', '<Plug>(easymotion-tn)')

-- replace n/N for fast targeting
vim.keymap.set('n', '<space>n', '<Plug>(easymotion-next)')
vim.keymap.set('n', '<space>N', '<Plug>(easymotion-prev)')

-- Highlight long rows
-- ctermbg 52 is dark red
-- TODO: Only apply this in certain fts

-- Jump around
vim.keymap.set('n', 'z[', '{zt')
vim.keymap.set('n', 'z]', '}zt')

-- Netrw
vim.keymap.set('n', '<space>gn', ':Explore<cr>', { silent = true })

