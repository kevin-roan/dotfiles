-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	-- auto indent added by ludan
	use("lukas-reineke/indent-blankline.nvim")
	-- image viewer like vs code added by ludan
	use({ "edluffy/hologram.nvim" })
	-- ranger for neovim installed by ludan
	use({ "kevinhwang91/rnvimr" })

	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	use("zchee/deoplete-jedi")

	-- neovim startup page
	--
	use({
		"startup-nvim/startup.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("startup").setup()
		end,
	})

	-- colorscheme devaslife
	use({
		"svrana/neosolarized.nvim",
		requires = { "tjdevries/colorbuddy.nvim" },
	})
	-- use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme

	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	use("szw/vim-maximizer") -- maximizes and restores current window

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)

	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	use("numToStr/Comment.nvim")

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- ludan addons
	-- code jump(go-to) plugin

	-- use("davidhalter/jedi-vim")

	-- neovim colorizer
	use("norcalli/nvim-colorizer.lua")

	use("dinhhuy258/git.nvim")

	use("tjdevries/colorbuddy.nvim")

	-- a snazzy bufferline
	use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })

	-- end of ludan addons

	use({
		"tanvirtin/vgit.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths
	use("sbdchd/neoformat") -- code auto-format plugin

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("Tom-xacademy/xa-snippets")
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets
	use("SirVer/ultisnips")
	use("mlaursen/vim-react-snippets")
	use("neoclide/coc-snippets")
	use({ "dsznajder/vscode-es7-javascript-react-snippets", run = "yarn install --frozen-lockfile && yarn compile" })

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- neodev for init.lua
	use("folke/neodev.nvim")

	-- neovim-dap debug adapter protocol(debug stuffs,inpsect the state of app etc )
	use("mfussenegger/nvim-dap")

	-- neovim navic
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	-- barbar.nvim used for tabpages (refer neovim.io)
	use("nvim-tree/nvim-web-devicons")
	-- use("ryanoasis/vim-devicons")

	use({ "romgrk/barbar.nvim", requires = "nvim-web-devicons" })
	-- project managment
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
