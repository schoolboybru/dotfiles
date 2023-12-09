local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>df", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)
    

end)

vim.g.neoformat_try_node_exe = 1
vim.cmd [[autocmd BufWritePre *.tsx,*.ts,*.js,*.html,*.css Neoformat]]

vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.format()]]

vim.diagnostic.config({
    virtual_text = true,
})


lsp.setup()
