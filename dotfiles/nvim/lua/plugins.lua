return {
  --
  -- @@ Using regularly
  --
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "saghen/blink.cmp",
    -- use a release tag to download pre-built binaries
    version = "1.*",
    dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
    opts = {
      keymap = {
        preset = "default",
        ["<C-e>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-space>"] = { "select_and_accept", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },

      snippets = { preset = "luasnip" },
      completion = {
        documentation = { auto_show = false },
        list = {
          selection = {
            preselect = false,
          },
        },
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
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
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        window = {
          mappings = {
            ["z"] = "noop",
          },
        },
      },
      window = {
        position = "left",
        width = 30,
        mappings = {},
      },
    },
    lazy = false, -- neo-tree will lazily load itself
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release),
    build = "make install_jsregexp",
    config = function()
      require("luasnip")
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {
      warn_no_results = false,
      open_no_results = true,
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      search = {
        mode = "search",
        incremental = true,
      },
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = false,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "clang-format" },
        html = { "prettier" },
        js = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        scss = { "prettier" },
        ts = { "prettier" },
        vue = { "prettier" },
        xml = { "xmlformatter" },
      },
    },
  },
  {
    "seblyng/roslyn.nvim",
    init = function()
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  "tomtom/tcomment_vim",
  {
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup({
        copy_sync = {
          redirect_to_clipboard = true,
        },
      })
    end,
  },
  "kevinhwang91/nvim-bqf",
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },

  --
  -- @@ Learning/setting up now
  --
  "mrloop/telescope-git-branch.nvim",
  "terryma/vim-expand-region",
  "mhinz/vim-tmuxify",
  {
    "tris203/hawtkeys.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = {
      -- an empty table will work for default config
      --- if you use functions, or whichkey, or lazy to map keys
      --- then please see the API below for options
    },
  },
  "lambdalisue/suda.vim",
  "tpope/vim-surround",

  --
  -- @@ Learn soon
  --
  "FeiyouG/commander.nvim",
  "nvim-pack/nvim-spectre",
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "nvim-mini/mini.nvim", version = "*" },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- .NET specific setup using `easy-dotnet`
      require("easy-dotnet.netcoredbg").register_dap_variables_viewer() -- special variables viewer specific for .NET
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },
  "Carcuis/dap-breakpoints.nvim",
  "Weissle/persistent-breakpoints.nvim",
  "vim-test/vim-test",
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local dotnet = require("easy-dotnet")

      dotnet.setup({
        terminal = function(path, action, args, ctx)
          args = args or ""
          local commands = {
            run = function()
              return string.format("%s %s", ctx.cmd, args)
            end,
            test = function()
              return string.format("%s %s", ctx.cmd, args)
            end,
            restore = function()
              return string.format("%s %s", ctx.cmd, args)
            end,
            build = function()
              return string.format("%s --property WarningLevel=0 %s", ctx.cmd, args)
            end,
            watch = function()
              return string.format("dotnet watch --project %s %s", path, args)
            end,
          }
          local command = commands[action]()
          if require("easy-dotnet.extensions").isWindows() == true then
            command = command .. "\r"
          end
          vim.cmd("split")
          vim.cmd("term " .. command)
        end,
        lsp = {
          enabled = false,
          roslynator_enabled = true,
        },
        debugger = {
          bin_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason/bin/netcoredbg"),
          auto_register_dap = true,
        },
        file_ignore_patterns = {
          "^.git/",
        },
      })
    end,
  },
  {
    "spacedentist/resolve.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  "karnull/switchboard.nvim",
  --
  -- @@ Backlog / Low priority
  --
  "tpope/vim-unimpaired",
  {
    "necrom4/convy.nvim",
    cmd = { "Convy", "ConvySeparator" },
    opts = {},
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
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {},
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {},
  },
  {
    "erl-koenig/theme-hub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Optional: for themes that use lush (will be notified if a theme requires it)
      "rktjmp/lush.nvim",
    },
    config = function()
      require("theme-hub").setup({
        -- Configuration options (see below)
      })
    end,
  },
  {
    "YouSame2/inlinediff-nvim",
    lazy = true, -- disable loading plugin until called with cmd or keys
    cmd = "InlineDiff",
    opts = {
      debounce_time = 200,
      ignored_buftype = { "terminal", "nofile" },
      ignored_filetype = { "TelescopePrompt", "NvimTree", "neo-tree" },
      colors = {
        -- context = dim background color; change = bright background color for changed text.
        InlineDiffAddContext = "#182400",
        InlineDiffAddChange = "#395200",
        InlineDiffDeleteContext = "#240004",
        InlineDiffDeleteChange = "#520005",
      },
    }, -- leave blank to use defaults
    keys = {
      {
        "<leader>di",
        function()
          require("inlinediff").toggle()
        end,
        desc = "Toggle inline diff",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "0x-ximon/acario.nvim",
    name = "acario",
    lazy = false,
    priority = 1000,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {
    "mikemcbride/telescope-mru.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "lmgraf/wsl-clipboard.nvim",
    opts = {
      mode = "sync", -- options: "system", "sync", "focus"
    },
  },
  "EinfachToll/DidYouMean",
  "benfowler/telescope-luasnip.nvim",
  "mhinz/vim-signify",
  "nvim-tree/nvim-web-devicons",
  "ryanoasis/vim-devicons",
  "tpope/vim-abolish",

  -- @@ Language support
  "digitaltoad/vim-jade",
  "elixir-lang/vim-elixir",
  "elzr/vim-json",
  "groenewege/vim-less",
  "jlcrochet/vim-razor",
  "kana/vim-textobj-user",
  "kchmck/vim-coffee-script",
  "martinda/Jenkinsfile-vim-syntax",
  "mxw/vim-jsx",
  "nanotee/sqls.nvim",
  "nifey/sarif.nvim",
  "othree/html5.vim",
  "pangloss/vim-javascript",
  "posva/vim-vue",
  "rust-lang/rust.vim",
  "slim-template/vim-slim",
  "tpope/vim-bundler",
  "tpope/vim-haml",
  "tpope/vim-markdown",
  "tpope/vim-rails",
  "tpope/vim-rake",
  "vim-ruby/vim-ruby",

  -- @@ Colorschemes
  "AlexvZyl/nordic.nvim",
  "EdenEast/nightfox.nvim",
  "mhartington/oceanic-next",
  "preservim/vim-colors-pencil",
  "rebelot/kanagawa.nvim",
  "sainnhe/everforest",
  "shaunsingh/nord.nvim",
}
