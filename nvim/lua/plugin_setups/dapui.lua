local dap = require("dap")
dap.adapters.lldb = {
  type = "executable",
  command = "lldb-vscode",
  name = "lldb",
}


local vks = vim.keymap.set

--[[
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
]] --


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

local dapui = require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


local whichkey = require("which-key")

local keymap = {
  d = {
    name = "Debug",
    R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
    E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
    C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
    U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    --b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
    S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    l = { "<cmd>lua require('dap').list_breakpoints()<cr>", "List Breakpoints" },
  },
}

whichkey.register(keymap, {
  mode = "n", prefix = "<leader>", buffer = nil, silent = true, noremap = true, nowait = false,
})

local keymap_v = {
  name = "Debug",
  e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
}
whichkey.register(keymap_v, {
  mode = "v",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})
