local Logger = require("logger")
local Path   = require("path")

Logger:new({ path = Path.join(process.cwd(), "config.json") })

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

local String = require("string")
local Path   = require("path")
local Fs     = require("fs")

-- parent level info
-- log1 level error
-- log2 level debug
-- log3 inherit

if Fs.accessSync(Path.join(process.cwd(), "tmp/log1.log")) then
  fd = Fs.openSync(Path.join(process.cwd(), "tmp/log1.log"), "a", "0640")
  Fs.ftruncateSync(fd)
end
if Fs.accessSync(Path.join(process.cwd(), "tmp/log2.log")) then
  fd = Fs.openSync(Path.join(process.cwd(), "tmp/log2.log"), "a", "0640")
  Fs.ftruncateSync(fd)
end
if Fs.accessSync(Path.join(process.cwd(), "tmp/log3.log")) then
  fd = Fs.openSync(Path.join(process.cwd(), "tmp/log3.log"), "a", "0640")
  Fs.ftruncateSync(fd)
end

local function assertLine(logname)
  local data = Fs.readFileSync(Path.join(process.cwd(), "tmp/" .. logname .. ".log"))
  String.gsub(data, "(.-)\r?\n", function(s)
    if not String.find(s, logname) then
      error( logname .. " not found in " .. logname .. ".log")
    end
  end)
end

local log = Logger.getLogger("file_logger")

log:error("Should be logged in log1 log2 log3")
log:warn("Should be logged in log2 log3")
log:info("Should be logged in log2 log3")
log:debug("Should be logged in log2")
log:trace("Should be logged")

log:setLevel(Logger.ERROR)
assert(Logger.ERROR == log:getLevel())

log:error("Should be logged in log1 log2 log3")
log:warn("Should be logged in log2")
log:info("Should be logged in log2")
log:debug("Should be logged in log2")
log:trace("Should be logged")

log:setLevel(Logger.WARN)
assert(Logger.WARN == log:getLevel())

log:error("Should be logged in log1 log2 log3")
log:warn("Should be logged in log2 log3")
log:info("Should be logged in log2")
log:debug("Should be logged in log2")
log:trace("Should be logged")

log:setLevel(Logger.INFO)
assert(Logger.INFO == log:getLevel())

log:error("Should be logged in log1 log2 log3")
log:warn("Should be logged in log2 log3")
log:info("Should be logged in log2 log3")
log:debug("Should be logged in log2")
log:trace("Should be logged")

log:setLevel(Logger.DEBUG)
assert(Logger.DEBUG == log:getLevel())

log:error("Should be logged in log1 log2 log3")
log:warn("Should be logged in log2 log3")
log:info("Should be logged in log2 log3")
log:debug("Should be logged in log2 log3")
log:trace("Should be logged")

log:setLevel(Logger.TRACE)
assert(Logger.TRACE == log:getLevel())

log:error("Should be logged in log1 log2 log3")
log:warn("Should be logged in log2 log3")
log:info("Should be logged in log2 log3")
log:debug("Should be logged in log2 log3")
log:trace("Should be logged in log3")

log:setLevel("level")
assert(Logger.TRACE == log:getLevel())

log:error("Should be logged in log1 log2 log3")
log:warn("Should be logged in log2 log3")
log:info("Should be logged in log2 log3")
log:debug("Should be logged in log2 log3")
log:trace("Should be logged in log3")

assertLine("log1")
assertLine("log2")
assertLine("log3")


local log = Logger.getLogger("console_logger")

log:error("Should be logged from root")
log:warn("Should be logged from root")
log:info("Should be logged from root")
log:debug("Should be logged from root")
log:trace("Should be logged from root")

local Child = require("./child")

local child = Child:new()
child:log()

require("hooks"):on("process.exit", function()
  Logger.close()
end)
