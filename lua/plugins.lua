local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  "folke/lazy.nvim",

  -- UI
  'hoob3rt/lualine.nvim',
  'kyazdani42/nvim-web-devicons',

  -- File Explorer
  { 'stevearc/oil.nvim',    config = function() require("config.oil").setup() end, dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- Colorscheme
  'rktjmp/lush.nvim',
  'savq/melange',

  'norcalli/nvim-colorizer.lua',

  { 'b3nj5m1n/kommentary', config = function()
    require('kommentary.config').configure_language('default', {
      prefer_single_line_comments = true,
    })
  end },

  -- Movement
  { "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    }
  },
  { 'ThePrimeagen/harpoon', dependencies = { 'nvim-lua/plenary.nvim' },            config = function() require('harpoon')
        .setup() end },

  -- LSP-y / Language specific stuff
  'vhdirk/vim-cmake',
  { 'inkarkat/vim-SpellCheck',      dependencies = { 'inkarkat/vim-ingo-library' } },

  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function() require('config.cmp').setup() end
  },

  'SirVer/ultisnips',

  { 'lervag/vimtex',                config = function() require('config.vimtex').setup() end },
  { 'iamcco/markdown-preview.nvim', build = ":call mkdp#util#install()" },
  'mrjones2014/legendary.nvim',

  -- Debugging
  { 'mfussenegger/nvim-dap',                       lazy = false,                                        config = require('config.dap').setup },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = require('config.dapui').setup,
    lazy = false
  },
  { 'leoluz/nvim-dap-go', config = function()
    require('dap-go').setup {
      dap_configurations = {
        {
          type = 'go',
          name = 'Attach Remote',
          mode = 'remote',

        }
      },
      delve = {
        path = "dlv",
        initialize_timeout_sec = 20,
        port = "${port}",
        args = {},
        build_flags = {},
        detached = vim.fn.has("win32") == 0,
        cwd = nil,
      },
      -- options related to running closest test
      tests = {
        -- enables verbosity when running the test.
        verbose = false,
      }
    }
  end },
  { 'theHamsta/nvim-dap-virtual-text',             dependencies = { "mfussenegger/nvim-dap" } },

  { 'nvim-treesitter/nvim-treesitter',             build = ":TSUpdate",                                 config = require('config.treesitter').config },
  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = { 'nvim-treesitter/nvim-treesitter' }, config = function() 
    require('nvim-treesitter-textobjects').setup {
	    select = {
		    enable = true,
		    lookahead = true,
		    keymaps = {
			    ["ab"] = "@block.outer",
			    ["ib"] = "@block.inner",
			    ["af"] = "@function.outer",
			    ["if"] = "@function.inner",
			    ["aC"] = "@class.outer",
			    ["iC"] = "@class.inner",
			    ["aK"] = "@comment.outer",
			    ["ai"] = "@conditional.outer",
			    ["ii"] = "@conditional.inner",
			    ["ac"] = "@call.outer",
			    ["ic"] = "@call.inner",
			    ["al"] = "@loop.outer",
			    ["il"] = "@loop.inner",
			    ["iP"] = "@parameter.inter",
			    ["aP"] = "@parameter.outer",
			    ["aS"] = "@statement.outer",
		    }
	    },
	    swap = {
		    enable = true,
		    swap_next = {
			    ["<leader>s"] = "@parameter.inner",
		    },
		    swap_previous = {
			    ["<leader>S"] = "@parameter.inner",
		    }
	    },
	    move = {
		    enable = true,
		    set_jumps = true,
		    goto_next_start = {
			    ["]m"] = "@function.outer",
			    ["]]"] = "@class.outer",
		    },
		    goto_next_end = {
			    ["]M"] = "@function.outer",
			    ["]["] = "@class.outer",
		    },
		    goto_previous_start = {
			    ["[m"] = "@function.outer",
			    ["[["] = "@class.outer",
		    },
		    goto_previous_end = {
			    ["[M"] = "@function.outer",
			    ["[]"] = "@class.outer",
		    },
	    },
    }
    end
  },
  {
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function() require('neogen').setup {} end,
  },

  -- libraries
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',


  -- Telescope
  { 'nvim-telescope/telescope.nvim', config = function() require('config.telescope').setup() end },

  -- Quality of life
  'junegunn/vim-easy-align',
  'tpope/vim-repeat',
  'tpope/vim-surround',

  -- Git
  { 'TimUntersberger/Neogit',        config = require('config.neogit').setup },
  { 'lewis6991/gitsigns.nvim',       config = function() require('config.gitsigns').setup() end },
  'tpope/vim-git',
  { 'FabijanZulj/blame.nvim', config = function()
    require('blame').setup {
      date_format = "%H:%M %d.%m.%Y",
      virtual_style = "right_align"
    }
  end },

  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' }
}
