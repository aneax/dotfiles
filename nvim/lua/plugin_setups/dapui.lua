local dap = require("dap")
dap.adapters.lldb = {
  type = "executable",
  command = "lldb-vscode", -- adjust as needed
  name = "lldb",
}


local vks = vim.keymap.set
vks('n', '<leader>dc', function() dap.continue() end)
vks('n', '<leader>db', function() dap.toggle_breakpoint() end)
vks('n', '<leader>dn', function() dap.step_over() end)
vks('n', '<leader>di', function() dap.step_in() end)
vks('n', '<leader>do', function() dap.step_out() end)
vks('n', '<leader>drr', function() dap.run_last() end)
vks('n', '<leader>dt', function() dap.terminate() end)
vks('n', '<leader>dl', function() dap.list_breakpoints() end)
vks('n', '<leader>du', function() dap.up() end)
vks('n', '<leader>dd', function() dap.down() end)
vks('n', '<leader>drc', function() dap.run_to_cursor() end)



dap.configurations.cpp = {
  name = "Launch lldb",
  type = "lldb", -- matches the adapter
  request = "launch", -- could also attach to a currently running process
  program = function()
    return vim.fn.input(
      "Path to executable: ",
      vim.fn.getcwd() .. "/",
      "file"
    )
  end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  args = {},
  runInTerminal = false,
}

dap.configurations.c = dap.configurations.cpp

require("dapui").setup()
