local wk = require('which-key')

local mappings = {
  ["q"] = { "<cmd>q<cr>", "Quit" },
  ["Q"] = { "<cmd>wq<cr>", "Save and Quit" },
  ["w"] = { "<cmd>w<cr>", "Save" },
  ["x"] = { "<cmd>bd<cr>", "Close current buffer" },
  b = {
    name = "Buffer",
    x = { "<cmd>bd<cr>", "Close current buffer" },
    d = { "<cmd>bd!<cr>", "Close current buffer with discard" },
    D = { "<cmd>%bd|e#|bd#<cr>", "Delete all buffer" }
  },

  z = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  -- cg = { ":CMakeGenerate<cr>", "CMake Generate" },
  f = { ":Telescope find_files<cr>", "Telescope Find Files" },
  r = { ":Telescope live_grep<cr>", "Telescope Live Grep" },
  -- cb = { ":CMakeBuild<cr>", "CMake Build" },
  -- ct = { ":CMakeInstall<cr>", "CMake Test" },
  -- cr = { ":CMakeRun<cr>", "Run executable" },
  -- cbt = { ":CMakeSelectBuildType<cr>", "Select build type" },
  -- cc = { ":CMakeClean<cr>:CMakeClose<cr>", "Clean target and close" },
  -- co = { ":CMakeOpen<cr>", "Open CMake" },
  -- cd = { ":CMakeDebug<cr>", "Run debug" },

}


local opts = {
  prefix = '<leader>',
  noremap = true,
  nowait = true,
  silent = true,
  mode = "n"
}

wk.setup()
wk.register(mappings, opts)
