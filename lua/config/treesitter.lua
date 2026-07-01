return {
	config = function() 
		languages = { "python", "c", "cpp", "bibtex", "json", "lua", "rust", "comment", "go"}
		require('nvim-treesitter').install(languages)

		vim.api.nvim_create_autocmd('FileType', {
			pattern = languages,
			callback = function() vim.treesitter.start() end
		})
	end
}

