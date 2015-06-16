local String = require("string")
local Path   = require("path")
local Fs     = require("fs")

local Logger = require("logger")

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
