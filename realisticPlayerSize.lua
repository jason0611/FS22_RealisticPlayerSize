-- Realistic Player Size for LS 19
--
-- Author: Jason06 / Glowins Mod-Schmiede
-- Version: 1.0.0.0

source(g_currentModDirectory.."tools/gmsDebug.lua")
GMSDebug:init(g_currentModName)
GMSDebug:enableConsoleCommands()

RealisticPlayerSize = {}
RealisticPlayerSize.size = 1.86
--RealisticPlayerSize.size = 2.12 -- game original value

function RealisticPlayerSize:loadPlayer(xmlFilename, playerStyle, creatorConnection, isOwner)
	if g_currentMission.player ~= nil and RealisticPlayerSize.size ~= nil then	
		g_currentMission.player.camY = RealisticPlayerSize.size
	end
end

function RealisticPlayerSize:update(dt)
	if g_currentMission:getIsClient() and g_currentMission.controlPlayer and g_currentMission.player ~= nil then
		local player = g_currentMission.player
		dbgrender("Spielergröße: "..tostring(2.12 * player.camY / 1.68).." m ("..tostring(player.camY)..")")
		if RealisticPlayerSize.size ~= nil and RealisticPlayerSize.size ~= player.camY then	
			g_currentMission.player.camY = 1.68 * RealisticPlayerSize.size / 2.12
		end
	end
end

addConsoleCommand("rpsSize", "Glowins Mod Smithery: Set player's size", "setSize", RealisticPlayerSize)
function RealisticPlayerSize:setSize(y)
	if y ~= nil and tonumber(y) ~= nil then 
		RealisticPlayerSize.size = tonumber(y)
	else
		print("Usage: rpsSize <size in meter>")
	end
end

-- Register mod to event management
addModEventListener(RealisticPlayerSize);

-- Get unique User-Id on joining
Player.load = Utils.appendedFunction(Player.load, RealisticPlayerSize.loadPlayer)
