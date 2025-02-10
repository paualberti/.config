-- return {}
return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"echasnovski/mini.icons",
		"nvim-treesitter/nvim-treesitter-context",
	},
	opts = {
		"hide",
	},
	config = function()
		-- vim.keymap.set("n", Leader .. "/", "<Cmd>FzfLua lgrep_curbuf<CR>", { desc = "Grep current buffer" })
		-- vim.keymap.set("n", Leader .. "fb", "<Cmd>FzfLua buffers<CR>", { desc = "Open Buffers" })
		-- vim.keymap.set("n", Leader .. "fd", "<Cmd>FzfLua diagnostics_workspace<CR>", { desc = "Diagnostics" })
		-- vim.keymap.set("n", Leader .. "ff", "<Cmd>FzfLua files<CR>", { desc = "Files" })
		-- vim.keymap.set("n", Leader .. "fg", "<Cmd>FzfLua live_grep_native<CR>", { desc = "by Grep" })
		-- vim.keymap.set("n", Leader .. "ft", "<Cmd>FzfLua helptags<CR>", { desc = "Help Tags" })
		-- vim.keymap.set("n", Leader .. "fk", "<Cmd>FzfLua keymaps<CR>", { desc = "Keymaps" })
		-- vim.keymap.set("n", Leader .. "fo", "<Cmd>FzfLua oldfiles<CR>", { desc = "Old Files" })
		-- vim.keymap.set("n", Leader .. "fq", "<Cmd>FzfLua quickfix<CR>", { desc = "QuickFix" })
		-- vim.keymap.set("n", Leader .. "fr", "<Cmd>FzfLua resume<CR>", { desc = "Resume" })
		-- vim.keymap.set("n", Leader .. "fs", "<Cmd>FzfLua builtin<CR>", { desc = "Select command" })
		-- vim.keymap.set("v", Leader .. "fv", "<Cmd>FzfLua grep_visual<CR>", { desc = "Grep Visual" })
		--
		-- vim.keymap.set(
		-- 	"n",
		-- 	Leader .. "fc",
		-- 	"<Cmd>FzfLua files cwd=" .. vim.fn.stdpath("config") .. "<CR>",
		-- 	{ desc = "Neovim Config Files" }
		-- )
	end,
}
