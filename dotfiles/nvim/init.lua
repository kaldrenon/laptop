require("config.lazy")
require('lualine').setup()
require('mason').setup()
require("nvim-tree").setup()

local opt = vim.opt
local o = vim.o
local g = vim.g

vim.cmd([[colorscheme kanagawa-wave]])

----stuff I still have to figure out
-- Default height of window is maxxed on new
-- command! -nargs=1 MyWinOpen :new <args> | :resize 100
-- highlight OverLength ctermbg=52 ctermfg=white guibg=#770000
-- match OverLength /\%101v./
--
-- g.syntastic_mode_map = {
--   'mode': 'active',
--   'active_filetypes': [],
--   'passive_filetypes': []
-- }
-- g.tmuxify_run = {
--   'c':  'rails c',
--   'gs': 'gs'
-- }

-- Opts
opt.filetype = "off"
opt.showmode = false
opt.redrawtime = 100000
opt.encoding = "UTF-8"
opt.fileformats = "unix"
o.clipboard = o.clipboard .. 'unnamedplus'
opt.shortmess = 'ltToOcF'
opt.wildmode = 'longest,list'
opt.termguicolors = true
-- Highlight matched HTML tags
opt.showmatch = true
o.matchpairs = o.matchpairs .. ",<:>"
opt.matchtime = 3

-- Make wildcard completion behave like zsh
opt.wildmenu = true

-- Prevent the use of .swp, ~, and other backup files.
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- No code folding
opt.foldenable = false

-- Basic color and format defaults
opt.hidden = true
opt.number = true
opt.ruler = true
opt.background = 'dark'

-- Might be nvim-only?

opt.list = true
opt.listchars = 'tab:‣-,trail:·'

-- Tab formatting
opt.shiftwidth  = 2
opt.softtabstop = 2
opt.tabstop     = 2
opt.expandtab = true

-- Wrapping
opt.wrap = true
opt.linebreak = true

-- Searching
opt.incsearch   = true
opt.ttimeoutlen = 0
opt.hlsearch = false

-- Prevent window stack from evening out when one closes
opt.equalalways = false
opt.winminheight = 0 -- No max height on windows.
opt.splitright = true
opt.autoread = true

opt.ttyfast = true
opt.mouse = 'a'

-- Use Ag over Grep
opt.grepprg = "ag --nogroup --nocolor"

-- remove CR on paste
o.clipboard = "unnamed,unnamedplus"
g.clipboard = {
  name = 'WslClipboard',
  copy = {
    ['+'] = 'clip.exe',
    ['*'] = 'clip.exe',
  },
  paste = {
    ['+'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ['*'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}
-- Settings
g.python3_host_prog='/usr/bin/python3'
g.pymode_python = 'python3'

g.loaded_perl_provider = 0

g.syntastic_always_populate_loc_list = 1
g.syntastic_auto_jump            = 0
g.syntastic_auto_loc_list        = 0
g.syntastic_enable_highlighting  = 1
g.syntastic_enable_signs         = 1
g.syntastic_python_python_exec   = '/usr/bin/python3'
g.syntastic_scss_checkers        = 'scss_lint'
g.syntastic_warning_symbol       = '->'
g.syntastic_style_warning_symbol = 'S-'

g.gist_clip_command = 'pbcopy'
g.gist_open_browser_after_post = 1

g.goyo_width = 100

g.ackprg                          = 'ag --nogroup --nocolor --column'
g.unite_source_rec_async_command  = 'ag -i --nocolor --nogroup'
g.unite_source_grep_command       = 'ag'
g.unite_source_grep_default_ops   = [[ --line-numbers --nocolor --nogroup --hidden ignore '.git' --ignore 'tmp' --ignore 'node_modules' ]]
g.unite_source_grep_recursive_opt = ''

g.tmuxify_custom_command = 'tmux split-window -l 16'
g.tmuxify_map_prefix     = '<space>m'

g.rust_recommended_style = 0

g.jsx_ext_required = 0 -- Allow JSX in normal JS files

-- EasyMotion
g.EasyMotion_leader_key = '<leader>'
g.EasyMotion_keys = 'asdfjklzxcvqwer'
g.EasyMotion_do_mapping = 0 -- Disable default mappings
g.EasyMotion_smartcase = 1
g.EasyMotion_startofline = 0 -- keep cursor column when JK motion

g.netrw_liststyle = 3

g.run_mode_map = '<Leader>rr'
g.tmux_navigator_no_mappings = 1

-- Commands
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Bd', 'bd', {})
vim.api.nvim_create_user_command('RS', 'source ~/.vimrc', {})

-- Keymaps
-- Swap j/k with gj/gk for normal, visual, and select modes
vim.keymap.set({'n', 'x', 'v'}, 'j', 'gj')
vim.keymap.set({'n', 'x', 'v'}, 'k', 'gk')
vim.keymap.set({'n', 'x', 'v'}, 'gj', 'j')
vim.keymap.set({'n', 'x', 'v'}, 'gk', 'k')

-- Join up
vim.keymap.set('n', 'K', 'kJ')

-- Clear search highlighting with \c
vim.keymap.set('n', '<space>l', ':nohls<CR>', { silent = true })

vim.keymap.set('n', '<C-p>', ':Yazi<CR>S', { silent = true })
vim.keymap.set('n', '<C-o>', ':Yazi<CR>s', { silent = true })
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

-- Autocmds
local cg = vim.api.nvim_create_augroup('CursorLine', { clear = true })
  vim.api.nvim_create_autocmd({'VimEnter', 'WinEnter', 'BufWinEnter'}, {
    pattern = '*', command = 'setlocal cursorline', group = cg})
  vim.api.nvim_create_autocmd('WinLeave', {pattern = '*', command = 'setlocal nocursorline', group = cg})

vim.api.nvim_create_autocmd('FileType', { pattern = {'css', 'vue'}, command = "setlocal omnifunc=csscomplete#CompleteCSS" })
vim.api.nvim_create_autocmd('FileType', { pattern = {'html', 'markdown', 'vue'}, command = "setlocal omnifunc=htmlcomplete#CompleteTags" })
vim.api.nvim_create_autocmd('FileType', { pattern = {'javascript', 'vue'}, command = "setlocal omnifunc=javascriptcomplete#CompleteJS" })
vim.api.nvim_create_autocmd('FileType', { pattern = 'python', command = "setlocal omnifunc=pythoncomplete#Complete" })
vim.api.nvim_create_autocmd('FileType', { pattern = 'python', command = "setlocal expandtab shiftwidth=2 softtabstop=2" })
vim.api.nvim_create_autocmd('FileType', { pattern = 'xml', command = "setlocal omnifunc=xmlcomplete#CompleteTags" })


-- Extension to filetype config
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, { pattern = '*.tex', command = 'setfiletype tex' })
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead', 'BufReadPost'}, { pattern = '*.jade.html', command = 'set filetype=jade' })

vim.api.nvim_create_autocmd({'BufNewFile', 'BufNewFile'}, { pattern = {'html','javascript', 'css', 'sass', 'ruby'}, command = "let w:m2=matchadd('ErrorMsg', '\\%>100v.\\+', -1)" })
