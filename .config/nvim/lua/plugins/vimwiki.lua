return {
	"vimwiki/vimwiki",
	init = function()
		vim.api.nvim_create_autocmd(
			"BufNewFile",
			{
				pattern = {
					'*/diary/*.md'
				},
				command = "silent 0r !~/.config/nvim/lua/plugins/vimwiki-diary-template '%'"
			}
		)

		vim.g.vimwiki_list = {
			{
				syntax = 'markdown',
				ext = '.md'
			}
		}

		vim.g.vimwiki_key_mappings = {
			global = 0,
			headers = 0
		}
	end
}
