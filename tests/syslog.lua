local Logger = require("logger")

local log = Logger.getLogger("file_logger")

log:error("Should be logged in syslog")
log:warn("Should be logged in syslog")
log:info("Should be logged in syslog")
log:debug("Should not be logged in syslog")
log:trace("Should not be logged in syslog")
