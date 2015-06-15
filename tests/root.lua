local Path   = require("path")
local Logger = require("logger")

Logger:new({ path = Path.join(process.cwd(), "console.json") })
local log = Logger.getLogger("console_logger")

log:error("Should be logged from root")
log:warn("Should be logged from root")
log:info("Should be logged from root")
log:debug("Should be logged from root")
log:trace("Should be logged from root")

local Child = require("./child")

local child = Child:new()
child:log()
