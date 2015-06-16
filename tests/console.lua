local Logger = require("logger")

local log = Logger.getLogger("console_logger")

log:error("Should be logged twice")
log:warn("Should be logged")
log:info("Should be logged")
log:debug("Should be logged")
log:trace("Should be logged")

log:setLevel(Logger.ERROR)
assert(Logger.ERROR == log:getLevel())

log:error("Should be logged twice")
log:warn("Should be logged")
log:info("Should be logged")
log:debug("Should be logged")
log:trace("Should be logged")

log:setLevel(Logger.WARN)
assert(Logger.WARN == log:getLevel())

log:error("Should be logged twice")
log:warn("Should be logged twice")
log:info("Should be logged")
log:debug("Should be logged")
log:trace("Should be logged")

log:setLevel(Logger.INFO)
assert(Logger.INFO == log:getLevel())

log:error("Should be logged twice")
log:warn("Should be logged twice")
log:info("Should be logged twice")
log:debug("Should be logged")
log:trace("Should be logged")

log:setLevel(Logger.DEBUG)
assert(Logger.DEBUG == log:getLevel())

log:error("Should be logged twice")
log:warn("Should be logged twice")
log:info("Should be logged twice")
log:debug("Should be logged twice")
log:trace("Should be logged")

log:setLevel(Logger.TRACE)
assert(Logger.TRACE == log:getLevel())

log:error("Should be logged twice")
log:warn("Should be logged twice")
log:info("Should be logged twice")
log:debug("Should be logged twice")
log:trace("Should be logged twice")

log:setLevel("level")
assert(Logger.TRACE == log:getLevel())

log:error("Should be logged twice")
log:warn("Should be logged twice")
log:info("Should be logged twice")
log:debug("Should be logged twice")
log:trace("Should be logged twice")

log:setLevel(Logger.ERROR)
log:log(Logger.ERROR, "Should be ERROR twice")
log:log(Logger.WARN, "Should be WARN")
log:log(Logger.INFO, "Should be INFO")
log:log(Logger.DEBUG, "Should be DEBUG")
log:log(Logger.TRACE, "Should be TRACE")

log:log(Logger.INFO, "Should be %s quoted %q %c %X", "formatted", "yes", 76, 1024)
