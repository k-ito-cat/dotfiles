return {
	{ "nvim-lua/plenary.nvim" },

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fs.root(0, ".git") or vim.uv.cwd(),
					})
				end,
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep({
						cwd = vim.fs.root(0, ".git") or vim.uv.cwd(),
					})
				end,
			},
			{
				"<leader>gs",
				function()
					require("telescope.builtin").git_status({
						cwd = vim.fs.root(0, ".git") or vim.uv.cwd(),
					})
				end,
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").lsp_references()
				end,
			},
			{
				"<leader>fd",
				function()
					require("telescope.builtin").lsp_definitions()
				end,
			},
		},
	},
}
