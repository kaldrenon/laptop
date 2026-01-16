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
         enabled = true,
         roslynator_enabled = true
       },
       debugger = {
         bin_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason/bin/netcoredbg"),
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
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-space'] = { 'accept','fallback' }
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
    build = "make install_jsregexp"
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      -- Keymaps for controlling the debugger
      vim.keymap.set("n", "<leader>q", function()
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
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
  'AlexvZyl/nordic.nvim',
  'EinfachToll/DidYouMean',
  'Lokaltog/vim-easymotion',
  'OrangeT/vim-csharp',
  'ap/vim-css-color',
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
  'lambdalisue/suda.vim',
  'martinda/Jenkinsfile-vim-syntax',
  'mattn/gist-vim',
  'mattn/webapi-vim',
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
