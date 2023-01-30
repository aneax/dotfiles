return {
  "folke/which-key.nvim",
  config = function()
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

      f = { ":Telescope find_files<cr>", "Telescope Find Files" },
      r = { ":Telescope live_grep<cr>", "Telescope Live Grep" },

      --
      c = {
        name = "CMake",
        g = { ":CMakeGenerate<cr>", "CMake Generate" },
        b = { ":CMakeBuild<cr>", "CMake Build" },
        d = { ":CMakeDebug<cr>", "Run debug" },
        r = { ":CMakeRun<cr>", "Run executable" },
        t = { ":CMakeInstall<cr>", "CMake Test" },
        o = { ":CMakeOpen<cr>", "Open Console" },
        c = { ":CMakeClose<cr>", "Close Console" },
        C = { ":CMakeClean<cr>:CMakeClose<cr>", "Clean target and close" },
        T = { ":CMakeSelectBuildType<cr>", "Select build type" },
        B = { ":CMakeSelectBuildTarget<cr>", "Select Build Target" },
        R = { ":CMakeSelectLaunchTarget<cr>", "Select Run Target" }
      },
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
  end,
}
