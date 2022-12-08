local cmake_build_type = { 'Debug' }
require("cmake-tools").setup(
  {
    cmake_command = "cmake",
    -- cmake_build_directory = "build",
    cmake_build_type = cmake_build_type,
    build_type = cmake_build_type,
    -- cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
    cmake_default_config = { "Debug" },
    -- cmake_build_options = {},
    -- cmake_console_size = 10, -- cmake output window height
    -- cmake_show_console = "always", -- "always", "only_on_error"
    cmake_dap_configuration = { name = "cpp", type = "lldb", request = "launch" }, -- dap configuration, optional
    cmake_dap_open_command = require("dap").repl.open, -- optional
    -- cmake_variants_message = {
    --   short = { show = true },
    --   long = { show = true, max_length = 40 }
    -- }
  }
)

--vim.g.cmake_link_compile_commands = true
