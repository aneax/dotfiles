M = {}

M.highlight = true

function M.toggle()
  M.highlight = not M.highlight
end

function M.do_highlight(client)
  if M.highlight then
    if client.server_capabilities.document_highlight then
      local present, illuminate = pcall(require, "illuminate")
      if present then
        illuminate.on_attach(client)
      else
        vim.api.nvim_exec(
          [[
            augroup lsp_document_highlight
              autocmd! * <buffer>
              autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
          ]],
          false
        )
      end
    end
  end
end

return M
