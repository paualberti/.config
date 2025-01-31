return { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
	{ "nvim-lua/plenary.nvim", },
	{ -- If encountering errors, see telescope-fzf-native README for installation instructions
	    "nvim-telescope/telescope-fzf-native.nvim",

	    -- `build` is used to run some command when the plugin is installed/updated.
	    -- This is only run then, not every time Neovim starts up.
	    build = "make",

	    -- `cond` is a condition used to determine whether this plugin should be
	    -- installed and loaded.
	    cond = function()
		return vim.fn.executable("make") == 1
	    end,
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- Useful for getting pretty icons, but requires a Nerd Font.
	{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
	-- Telescope is a fuzzy finder that comes with a lot of different things that
	-- it can fuzzy find! It's more than just a "file finder", it can search
	-- many different aspects of Neovim, your workspace, LSP, and more!
	--
	-- The easiest way to use Telescope, is to start by doing something like:
	--  :Telescope help_tags
	--
	-- After running this command, a window will open up and you're able to
	-- type in the prompt window. You'll see a list of `help_tags` options and
	-- a corresponding preview of the help.
	--
	-- Two important keymaps to use while in Telescope are:
	--  - Insert mode: <c-/>
	--  - Normal mode: ?
	--
	-- This opens a window that shows you all of the keymaps for the current
	-- Telescope picker. This is really useful to discover what Telescope can
	-- do as well as how to actually do it!

	-- [[ Configure Telescope ]]
	-- See `:help telescope` and `:help telescope.setup()`
	local actions = require("telescope.actions")
	local themes  = require("telescope.themes")
	local theme   = themes.get_ivy({
	    theme            = "dropdown",
	    results_title    = false,
	    sorting_strategy = "ascending",
	    layout_strategy  = "bottom_pane",
	    layout_config    = {
		preview_cutoff = 1, -- Preview should always show (unless previewer = false)
		width  = function(_, max_columns, _)
		    return math.min(max_columns, 80)
		end,
		height = function(_, _, max_lines)
		    return math.min(max_lines, 15)
		end,
	    },
	    border      = true,
	    borderchars = {
		prompt  = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
		results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
		preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
	    },
	})
	require("telescope").setup({
	    pickers    = {
		-- Custom configuration for builtin pickers, if needed.
	    },
	    extensions = {
		["ui-select"] = theme,
	    },
	})

	-- Enable Telescope extensions if they are installed
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")

	-- See `:help telescope.builtin`
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>sk", function() builtin.keymaps(theme) end,     { desc = "[K]eymaps" })
	vim.keymap.set("n", "<leader>sf", function() builtin.find_files(theme) end,  { desc = "[F]iles" })
	vim.keymap.set("n", "<leader>ss", function() builtin.builtin(theme) end,     { desc = "[S]elect" })
	vim.keymap.set("n", "<leader>sg", function() builtin.live_grep(theme) end,   { desc = "[G]rep" })
	vim.keymap.set("n", "<leader>sd", function() builtin.diagnostics(theme) end, { desc = "[D]iagnostics" })
	vim.keymap.set("n", "<leader>sr", function() builtin.resume(theme) end,      { desc = "[R]esume" })
	vim.keymap.set("n", "<leader>so", function() builtin.oldfiles(theme) end,    { desc = "[O]ld files" })
	vim.keymap.set("n", "<leader>sb", function() builtin.buffers(theme) end,     { desc = "[B]uffers" })
	vim.keymap.set("n", "<leader>sm", function() builtin.marks(theme) end,       { desc = "[B]uffers" })

	local function shallowCopy(t)
	    local copy = {}
	    for k, v in pairs(t) do
		copy[k] = v
	    end
	    return copy
	end

	local live_grep_open_files = shallowCopy(theme)
	live_grep_open_files.grep_open_files = true
	live_grep_open_files.prompt_title    = "Live Grep in Open Files"
	-- It's also possible to pass additional configuration options.
	--  See `:help telescope.builtin.live_grep()` for information about particular keys
	vim.keymap.set("n", "<leader>/", function()
	    builtin.live_grep(live_grep_open_files)
	end, { desc = "Grep in Open Buffers" })

	local search_neovim_files = shallowCopy(theme)
	search_neovim_files.cwd = vim.fn.stdpath("config")
	search_neovim_files.prompt_title = "Search Neovim Files"
	-- Shortcut for searching your Neovim configuration files
	vim.keymap.set("n", "<leader>sn", function()
	    builtin.find_files(search_neovim_files)
	end, { desc = "[N]eovim files" })

	local ignore_patterns = {
	    "%.o",
	    "%.d",
	    "%.json",
	    "%.class",
	}
	require("telescope.config").set_defaults({
	    file_ignore_patterns = ignore_patterns,
	})
    end,
}
