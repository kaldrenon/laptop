-- Load Lazy for all plugin management
require('config.lazy')

-- Set colo before loading lualine, so that lualine will use it
-- vim.cmd([[colorscheme kanagawa-wave]])
-- vim.cmd([[colorscheme nordic]])
vim.cmd([[colorscheme nightfox]])
require('lualine').setup()

require('mason').setup()
require('keys')
require('toggleterm').setup {
  open_mapping = [[<c-\>]],
  direction = 'float',
  float_opts = {
    border = 'single'
  }
}
require('luasnip.loaders.from_snipmate').lazy_load()

require('telescope').load_extension('luasnip')
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--follow",        -- Follow symbolic links
      "--hidden",        -- Search for hidden files
      "--no-heading",    -- Don't group matches by each file
      "--with-filename", -- Print the file path with the matched lines
      "--line-number",   -- Show line numbers
      "--column",        -- Show column numbers
      "--smart-case",    -- Smart case search

      -- Exclude some patterns from search
      "--glob=!**/.git/*",
      "--glob=!**/.idea/*",
      "--glob=!**/.vscode/*",
      "--glob=!**/build/*",
      "--glob=!**/dist/*",
      "--glob=!**/yarn.lock",
      "--glob=!**/package-lock.json",
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      -- needed to exclude some files & dirs from general search
      -- when not included or specified in .gitignore
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob=!**/.git/*",
        "--glob=!**/.idea/*",
        "--glob=!**/.vscode/*",
        "--glob=!**/build/*",
        "--glob=!**/dist/*",
        "--glob=!**/yarn.lock",
        "--glob=!**/package-lock.json",
      },
      live_grep = {
        "rg",
        "--files",
        "--hidden",
        "--glob=!**/.git/*",
        "--glob=!**/.idea/*",
        "--glob=!**/.vscode/*",
        "--glob=!**/build/*",
        "--glob=!**/dist/*",
        "--glob=!**/yarn.lock",
        "--glob=!**/package-lock.json",
      },
    },
  },
}

require('lazydev').setup({
  library = { 'nvim-dap-ui' },
})

vim.lsp.config('roslyn', {
  settings = {
    ['csharp|background_analysis'] = {
      dotnet_analyzer_diagnostics_scope = 'openFiles',
      dotnet_compiler_diagnostics_scope = 'fullSolution'
    }
  }
})

require("conform").setup({
  formatters_by_ft = {
    csharp = { "csharpier" },
    lua = { "stylua" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
})

local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

local opt = vim.opt
local o = vim.o
local g = vim.g


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

g.netrw_liststyle = 3

g.run_mode_map = '<Leader>rr'
g.tmux_navigator_no_mappings = 1

-- Commands
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Bd', 'bd', {})
vim.api.nvim_create_user_command('RS', 'source ~/.vimrc', {})
vim.api.nvim_create_user_command('LuaSnipEdit', 'lua require("luasnip.loaders").edit_snippet_files()', {})

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
vim.api.nvim_create_autocmd('BufReadPost', { pattern = 'quickfix', command = "nnoremap <buffer> <CR> <CR>" })

-- Extension to filetype config
vim.filetype.add({
  extension = {
    cshtml = 'razor'
  }
})
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, { pattern = '*.tex', command = 'setfiletype tex' })
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead', 'BufReadPost'}, { pattern = '*.jade.html', command = 'set filetype=jade' })
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead', 'BufReadPost'}, { pattern = '*.cshtml', command = 'set filetype=razor' })

vim.api.nvim_create_autocmd({'BufNewFile', 'BufNewFile'}, { pattern = {'html','javascript', 'css', 'sass', 'ruby'}, command = "let w:m2=matchadd('ErrorMsg', '\\%>100v.\\+', -1)" })
