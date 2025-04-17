return {
	{
		-- https://github.com/rcarriga/nvim-dap-ui
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("dapui").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			local venv = os.getenv("VIRTUAL_ENV")
			local command = string.format("%s/bin/python", venv)

			require("dap-python").setup(command)
		end,
	},
}
