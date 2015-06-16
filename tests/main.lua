local Logger = require("logger")
local Path   = require("path")

Logger:new({ path = Path.join(process.cwd(), "config.json") })

require("./console")

require("./file")

require("./root")

require("./redis")

require("./syslog")

local Timer = require("timer")
Timer.setTimeout(1500, function()
  --process:exit()
  Logger.close()
end)

require("hooks"):on("process.exit", function()
  Logger.close()
end)
