return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      'nvim-telescope/telescope.nvim'
    },
    config = function()
      local dotnet = require("easy-dotnet")

      dotnet.setup({
        terminal = function(path, action, args, ctx)
          args = args or ""
          local commands = {
            run = function() return string.format("%s %s", ctx.cmd, args) end,
            test = function() return string.format("%s %s", ctx.cmd, args) end,
            restore = function() return string.format("%s %s", ctx.cmd, args) end,
            build = function() return string.format("%s --property WarningLevel=0 %s", ctx.cmd, args) end,
            watch = function() return string.format("dotnet watch --project %s %s", path, args) end,
          }
          local command = commands[action]()
          if require("easy-dotnet.extensions").isWindows() == true then command = command .. "\r" end
          vim.cmd("split")
          vim.cmd("term " .. command)
        end,
        lsp = {
          enabled = false,
          roslynator_enabled = true
        },
        debugger = {
          bin_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason/bin/netcoredbg"),
          auto_register_dap = true
        },
        file_ignore_patterns = {
          '^.git/'
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
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry"
      },
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
    -- use a release tag to download pre-built binaries
    version = '1.*',
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    opts = {
      keymap = {
        preset = 'default',
        ['<C-e>'] = { 'select_and_accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<C-space>'] = { 'select_and_accept','fallback' }
      },
      appearance = {
        nerd_font_variant = 'mono'
      },

      snippets = { preset = 'luasnip' },
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
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    }
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
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
      window = {
        position = "left",
        width = 30,
        mappings = {}
      }
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
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      -- Keymaps for controlling the debugger
      vim.keymap.set("n", "<leader>dq", function()
        dap.terminate()
        dap.clear_breakpoints()
      end, { desc = "Terminate and clear breakpoints" })

      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/continue debugging" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Step over (alt)" })
      vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
      vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle DAP REPL" })
      vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Go down stack frame" })
      vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Go up stack frame" })

      -- .NET specific setup using `easy-dotnet`
      require("easy-dotnet.netcoredbg").register_dap_variables_viewer() -- special variables viewer specific for .NET
    end
  },
  {
    "folke/trouble.nvim",
    opts = {
      warn_no_results = false,
      open_no_results = true
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
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
    'rcarriga/nvim-dap-ui',
    dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'}
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true
        },
        char = {
          autohide = true
        }
      }
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        cs = { 'clang-format' },
      }
    }
  },
  {
    'bkoropoff/clipipe',
    opts = {
      -- Optional configuration, defaults shown here:
      keep_line_endings = false, -- Set to true to disable \r\n conversion on Windows
      enable = true, -- Automatically set g:clipboard to enable clipipe
      start_timeout = 5000, -- Timeout for starting background process (ms)
      timeout = 500, -- Timeout for responses from background process (ms)
      interval = 50, -- Polling interval for responses (ms)
      download = true, -- Download pre-built binary if needed
      build = true, -- Build from source if needed
    }
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
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
  {
    'stevearc/quicker.nvim',
    ft = "qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  {
    "SalOrak/whaler",
    opts = {
      directories = { "~/code" },
      oneoff_directories = {
        { path = "~/.local/share/nvim/lazy", alias = "Neovim"},
        { path = "~/laptop/", alias = "Dotfile Repo"},
        { path = "~/.config/", alias = "Config"}
      },
      picker = "telescope"
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
      "rktjmp/lush.nvim"
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
    }
  },
  {
    "spacedentist/resolve.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      -- or "fzf-lua" or "snacks" or "default"
      picker = "telescope",
      -- bare Octo command opens picker of commands
      enable_builtin = true,
    },
    keys = {
      {
        "<leader>oi",
        "<CMD>Octo issue list<CR>",
        desc = "List GitHub Issues",
      },
      {
        "<leader>os",
        function()
          require("octo.utils").create_base_search_command { include_current_repo = true }
        end,
        desc = "Search GitHub",
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
  {
    "necrom4/convy.nvim",
    cmd = { "Convy", "ConvySeparator" },
    opts = {}
  },
  {
    "letieu/jira.nvim",
    opts = {
      jira = {
        limit = 200
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
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup(--[[optional config]])
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  -- noconf
  'AlexvZyl/nordic.nvim',
  'EdenEast/nightfox.nvim',
  'EinfachToll/DidYouMean',
  'FeiyouG/commander.nvim',
  'Lokaltog/vim-easymotion',
  'OrangeT/vim-csharp',
  'benfowler/telescope-luasnip.nvim',
  'christoomey/vim-tmux-navigator',
  'digitaltoad/vim-jade',
  'elixir-lang/vim-elixir',
  'elzr/vim-json',
  'godlygeek/tabular',
  'groenewege/vim-less',
  'janko/vim-test',
  'jlcrochet/vim-razor',
  'kana/vim-textobj-user',
  'kchmck/vim-coffee-script',
  'kevinhwang91/nvim-bqf',
  'lambdalisue/suda.vim',
  'martinda/Jenkinsfile-vim-syntax',
  'mateuszwieloch/automkdir.nvim',
  'mattn/gist-vim',
  'mattn/webapi-vim',
  'mhartington/oceanic-next',
  'mhinz/vim-signify',
  'mhinz/vim-tmuxify',
  'mrloop/telescope-git-branch.nvim',
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
