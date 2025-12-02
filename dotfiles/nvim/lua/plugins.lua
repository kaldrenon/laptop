return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      'nvim-telescope/telescope.nvim'
    },
    config = function()
     local dotnet = require("easy-dotnet")

     dotnet.setup({
       lsp = {
         enabled = true,
         roslynator_enabled = true
       },
       debugger = {
         bin_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason/bin/netcoredbg.cmd"),
         auto_register_dap = true
       }
     })
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "mikavilpas/yazi.nvim",
    version = "*", -- use the latest stable version
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- mark netrw as loaded so it's not loaded at all.
      --
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-space'] = { 'accept','fallback' }
      },
      appearance = {
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = { auto_show = false },
        list = {
          selection = {
            preselect = false
          }
        }
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          ["easy-dotnet"] = {
            name = "easy-dotnet",
            enabled = true,
            module = "easy-dotnet.completion.blink",
            score_offset = 10000,
            async = true,
          },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {
    'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'akinsho/toggleterm.nvim', version = "*", config = true },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    opts = {
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<cr>"] = { "open_split" }
        }
      }
    },
    lazy = false, -- neo-tree will lazily load itself
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release),
    build = "make install_jsregexp"
  },
  'AlexvZyl/nordic.nvim',
  'EinfachToll/DidYouMean',
  'Lokaltog/vim-easymotion',
  'OmniSharp/omnisharp-vim',
  'OrangeT/vim-csharp',
  'ap/vim-css-color',
  'christoomey/vim-tmux-navigator',
  'digitaltoad/vim-jade',
  'elixir-lang/vim-elixir',
  'elzr/vim-json',
  'godlygeek/tabular',
  'groenewege/vim-less',
  'janko/vim-test',
  'kana/vim-textobj-user',
  'kchmck/vim-coffee-script',
  'lambdalisue/suda.vim',
  'martinda/Jenkinsfile-vim-syntax',
  'mattn/gist-vim',
  'mattn/webapi-vim',
  'mfussenegger/nvim-dap',
  'mhartington/oceanic-next',
  'mhinz/vim-signify',
  'mhinz/vim-tmuxify',
  'mxw/vim-jsx',
  'nanotee/sqls.nvim',
  'notalex/vim-run-live',
  'nvim-tree/nvim-web-devicons',
  'othree/html5.vim',
  'pangloss/vim-javascript',
  'posva/vim-vue',
  'preservim/vim-colors-pencil',
  'rebelot/kanagawa.nvim',
  'rust-lang/rust.vim',
  'ryanoasis/vim-devicons',
  'sainnhe/everforest',
  'scrooloose/syntastic',
  'shaunsingh/nord.nvim',
  'slim-template/vim-slim',
  'terryma/vim-expand-region',
  'tomtom/tcomment_vim',
  'tpope/vim-abolish',
  'tpope/vim-bundler',
  'tpope/vim-dispatch',
  'tpope/vim-fugitive',
  'tpope/vim-haml',
  'tpope/vim-markdown',
  'tpope/vim-rails',
  'tpope/vim-rake',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'vim-ruby/vim-ruby'
}
