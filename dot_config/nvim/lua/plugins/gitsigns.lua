return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, lhs, rhs, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, lhs, rhs, opts)
				end

				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Next git hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Previous git hunk" })

				map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview git hunk" })
				map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview git hunk inline" })
				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Git blame line" })
				map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git diff buffer" })
				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, { desc = "Git diff buffer against previous revision" })
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle git blame" })
				map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle git word diff" })
			end,
		},
	},
}
