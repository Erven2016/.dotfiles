local deafult_config = require("default.custom")

local custom_config = {}

local config = vim.tbl_deep_extend("force", deafult_config, custom_config)

return config
