vim.g.python3_host_prog = require('local').python3_host_prog
vim.opt.runtimepath:append(",~/.config/nvim/after/")

require('plugins')

vim.o.encoding = 'utf-8'
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.linebreak = true
vim.o.wrap = true
vim.o.hidden = true
vim.o.compatible = false
vim.o.ignorecase = true
vim.o.conceallevel = 0
vim.o.title = true
vim.o.titlestring = "%F"
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.backspace = 'indent,eol,start'
vim.o.display = 'lastline'

-- vim.o.spelllang=de,en
vim.o.confirm = true
vim.o.ttimeout = true
vim.o.ttimeoutlen = 200

vim.o.shell = "/bin/bash"
vim.o.grepprg = "rg -i --vimgrep"

-- Markdown Preview
vim.g.mkdp_browser = 'firefox'

-- Updatetime
vim.o.updatetime = 800

-- Vim-cmake
vim.g.cmake_generate_options = { '-G', 'Ninja', '-B', 'build' }

-- Autocompletion
vim.o.completeopt = "menuone,noselect"

require('my_autocommands')
require('my_keymapping')

vim.api.nvim_create_user_command("Term", function(args)
  vim.cmd("split | term " .. args["args"])
end, { nargs = '?', complete = "shellcmd" })

vim.api.nvim_create_user_command("Py", function(args)
  vim.cmd("split | term python " .. args["args"])
end, { nargs = '?', complete = "shellcmd" })

require('my_ui_visuals')
require('my_funcs')

vim.lsp.config('*', {
  root_markers = { '.git' },
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  }
})

vim.api.nvim_set_hl(0, "@env_cmd.latex", { link = "keyword" })
vim.api.nvim_set_hl(0, "@section.latex", { link = "keyword" })
vim.api.nvim_set_hl(0, "@label_name.latex", { link = "@string.special.url" })
vim.api.nvim_set_hl(0, "@ref.latex", { link = "@string.special.url" })
vim.api.nvim_set_hl(0, "@citekeys.latex", { link = "@string.special.url" })
vim.api.nvim_set_hl(0, "@keylabel.latex", { link = "@type" })

vim.api.nvim_command("sign define LspDiagnosticsSignError text=\\ ☠")
vim.api.nvim_command("sign define LspDiagnosticsSignWarning text=⚠")
vim.api.nvim_command("sign define LspDiagnosticsSignInformation text=ⓘ")
vim.api.nvim_command("sign define lspLspDiagnosticsSignHint text=⚐")

local lsp_names = { "lua_ls", "rust-analyzer", "texlab", "clangd", "pyright" }

vim.lsp.enable(lsp_names)

vim.api.nvim_create_user_command("LspRestart", function()
  vim.lsp.enable(lsp_names, false)
  vim.lsp.enable(lsp_names, true)
end, {})
