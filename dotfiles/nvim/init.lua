-- Load Lazy for all plugin management
require("config.lazy")

-- Set colo before loading lualine, so that lualine will use it
vim.cmd([[colorscheme minimal-base16]])

-- Plugin Setup calls
require("lualine").setup({
  options = {
    theme = "tomorrow_night",
  },
})

require("mason").setup()
require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  direction = "float",
  float_opts = {
    border = "single",
  },
})
require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets/" })

local harpoon = require("harpoon")
harpoon:setup({})

require("telescope").load_extension("luasnip")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("git_branch")
require("telescope").load_extension("mru_files")
require("telescope").setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--follow", -- Follow symbolic links
      "--hidden", -- Search for hidden files
      "--no-heading", -- Don't group matches by each file
      "--with-filename", -- Print the file path with the matched lines
      "--line-number", -- Show line numbers
      "--column", -- Show column numbers
      "--smart-case", -- Smart case search

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
})

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

require("lazydev").setup({
  library = { "nvim-dap-ui" },
})
require("quicker").setup()

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

require("persistent-breakpoints").setup({
  load_breakpoints_event = { "BufReadPost" },
})
require("dap-breakpoints").setup()

-- Configs
vim.lsp.config("html", {
  filetypes = { "razor", "cshtml", "html" },
})

local vue_ls_path = vim.fn.expand("$MASON/packages/vue-language-server")
local vue_ts_plugin_location = vue_ls_path .. "/node_modules/@vue/language-server"

vim.lsp.config["ts_ls"] = {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_ts_plugin_location,
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  root_markers = { "package.json" },
  single_file_support = false,
}

require("mason-lspconfig").setup()

require("jira").setup({
  cli = {
    issues = {
      args = { "issue", "list" },
      columns = { "key" },
      filters = {},
    },
  },
})

require("spectre").setup()

local opt = vim.opt
local o = vim.o
local g = vim.g

----stuff I still have to figure out
-- Default height of window is maxxed on new
-- command! -nargs=1 MyWinOpen :new <args> | :resize 100
-- highlight OverLength ctermbg=52 ctermfg=white guibg=#770000
-- match OverLength /\%101v./

-- Opts
o.clipboard = "unnamedplus"
o.matchpairs = o.matchpairs .. ",<:>"

opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.encoding = "UTF-8"
opt.fileformats = "unix"
opt.filetype = "off"
opt.list = true
opt.listchars = "tab:‣-,trail:·"
opt.matchtime = 3
opt.mouse = "a"
opt.redrawtime = 100000
opt.shortmess = "ltToOcF"
opt.showmatch = true
opt.showmode = false
opt.smartcase = true
opt.termguicolors = true
opt.timeoutlen = 250
opt.ttyfast = true
opt.updatetime = 250
opt.wildmode = "longest,list"

-- Make wildcard completion behave like zsh
opt.wildmenu = true

-- Prevent the use of .swp, ~, and other backup files.
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- No code folding
opt.foldenable = false

-- Basic color and format defaults
opt.background = "dark"
opt.eol = true
opt.fixeol = true
opt.hidden = true
opt.number = true
opt.ruler = true

-- Tab formatting
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

-- Wrapping
opt.linebreak = true
opt.wrap = true

-- Searching
opt.hlsearch = false
opt.ignorecase = true
opt.incsearch = true
opt.ttimeoutlen = 0

-- Prevent window stack from evening out when one closes
opt.autoread = true
opt.equalalways = false
opt.splitright = true
opt.winminheight = 0

-- Use Ag over Grep
opt.grepprg = "ag --nogroup --nocolor"

-- Settings
g.python3_host_prog = "/usr/bin/python3"
g.pymode_python = "python3"

g.loaded_perl_provider = 0

g.gist_clip_command = "tmux"
g.gist_open_browser_after_post = 1

g.ackprg = "ag --nogroup --nocolor --column"

g.rust_recommended_style = 0
g.jsx_ext_required = 0 -- Allow JSX in normal JS files

g.netrw_liststyle = 3

g.tmux_navigator_no_mappings = 1

-- Commands
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("Bd", "bd", {})
vim.api.nvim_create_user_command("RS", "source ~/.vimrc", {})
vim.api.nvim_create_user_command("LuaSnpEdit", 'lua require("luasnip.loaders").edit_snippet_files()', {})

--
-- Autocmds
--

local cg = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd(
  { "VimEnter", "WinEnter", "BufWinEnter" },
  { pattern = "*", command = "setlocal cursorline", group = cg }
)
vim.api.nvim_create_autocmd("WinLeave", { pattern = "*", command = "setlocal nocursorline", group = cg })

vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = { "css", "vue" }, command = "setlocal omnifunc=csscomplete#CompleteCSS" }
)
vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = { "html", "markdown", "vue" }, command = "setlocal omnifunc=htmlcomplete#CompleteTags" }
)
vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = { "javascript", "vue" }, command = "setlocal omnifunc=javascriptcomplete#CompleteJS" }
)
vim.api.nvim_create_autocmd("FileType", { pattern = "python", command = "setlocal omnifunc=pythoncomplete#Complete" })
vim.api.nvim_create_autocmd(
  "FileType",
  { pattern = "python", command = "setlocal expandtab shiftwidth=2 softtabstop=2" }
)
vim.api.nvim_create_autocmd("FileType", { pattern = "xml", command = "setlocal omnifunc=xmlcomplete#CompleteTags" })
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "quickfix", command = "nnoremap <buffer> <CR> <CR>" })

-- Extension to filetype config
vim.filetype.add({
  extension = {
    cshtml = "razor",
  },
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.tex", command = "setfiletype tex" })
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead", "BufReadPost" },
  { pattern = "*.jade.html", command = "set filetype=jade" }
)
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead", "BufReadPost" },
  { pattern = "*.cshtml", command = "set filetype=razor" }
)

vim.api.nvim_create_autocmd({ "BufNewFile", "BufNewFile" }, {
  pattern = { "html", "javascript", "css", "sass", "ruby" },
  command = "let w:m2=matchadd('ErrorMsg', '\\%>100v.\\+', -1)",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- Import key bindings
require("keys")
require("switchboard-config")
