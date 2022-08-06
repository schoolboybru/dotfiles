local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)

  	local function buf_set_keymap(...)
		  vim.api.nvim_buf_set_keymap(bufnr, ...)
	  end

    local opts = { noremap = true, silent = true }
	  buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
	  buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  
    buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
    vim.keymap.set("n", "gr", vim.lsp.buf.references, {buffer=0})
    vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})

	if client.server_capabilities.document_formatting then
		vim.cmd([[
			augroup formatting
				autocmd! * <buffer>
				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
				autocmd BufWritePre <buffer> lua OrganizeImports(1000)
			augroup END
		]])
	end

end

require'lspconfig'.rust_analyzer.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}
require'lspconfig'.gopls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

require'lspconfig'.tsserver.setup{
  disable_commands = false,
  disable_formatting = false, 
  capabilities = capabilities,
  on_attach = on_attach,
}

local path_to_elixirls = vim.fn.expand("~/.elixir-ls/release/language_server.sh")
require'lspconfig'.elixirls.setup{
  cmd = {path_to_elixirls},
  capabilities = capabilities,
  on_attach = on_attach,  
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false
    }
  }
}

vim.opt.completeopt = {"menu", "menuone", "noselect"}

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

local action_state = require("telescope.actions.state")
require('telescope').setup{
    defaults = {
        prompt_prefix = "$ ",
        mappings = {
            i = {
              ["<c-a>"] = function() print(vim.inspect(action_state.get_selected_entry())) end
            }
        }
    }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

local mappings = {
}

mappings.curr_buf = function()
    local opt = require('telecsope.themes').get_dropdown({height=10, previewer=false})
    require('telescope.builtin').current_buffer_fuzzy_find(opt)
end

return mappings
