-- Realistic Player Size for LS 19
--
-- Author: Jason06 / Glowins Mod-Schmiede
-- Version: 0.0.0.1


source(g_currentModDirectory.."tools/gmsDebug.lua")
GMSDebug:init(g_currentModName, true)
GMSDebug:enableConsoleCommands(true)

RealisticPlayerSize = {}

-- general data
RealisticPlayerSize.size = nil

function RealisticPlayerSize:loadPlayer(xmlFilename, playerStyle, creatorConnection, isOwner)
	if g_currentMission.player ~= nil and RealisticPlayerSize.size ~= nil then	
		g_currentMission.player.camY = RealisticPlayerSize.size
	end
end

function RealisticPlayerSize:update(dt)
	if g_currentMission:getIsClient() and g_currentMission.controlPlayer and g_currentMission.player ~= nil then
		local player = g_currentMission.player
		dbgrender("Spielergröße: "..tostring(player.camY))
		if RealisticPlayerSize.size ~= nil and RealisticPlayerSize.size ~= player.camY then	
			g_currentMission.player.camY = RealisticPlayerSize.size
			dbgrender("Korrigiert auf: "..tostring(RealisticPlayerSize.size),1)
		end
	end
end

addConsoleCommand("rpsSize", "Glowins Mod Smithery: Set player's size", "setSize", RealisticPlayerSize)
function RealisticPlayerSize:setSize(y)
	if y ~= nil and tonumber(y) ~= nil then RealisticPlayerSize.size = y; end
end

-- Register mod to event management
addModEventListener(RealisticPlayerSize);

-- Get unique User-Id on joining
Player.load = Utils.appendedFunction(Player.load, RealisticPlayerSize.loadPlayer)

-- Free space on leaving
--Player.delete = Utils.prependedFunction(Player.delete, ExtendedTabbing.deletePlayer)

-- Transfer information from server to client on joining
--Player.readStream = Utils.appendedFunction(Player.readStream, ExtendedTabbing.readStream)
--Player.writeStream = Utils.appendedFunction(Player.writeStream, ExtendedTabbing.writeStream)

-- Update information from client to server while playing
--Player.readUpdateStream = Utils.appendedFunction(Player.readUpdateStream, ExtendedTabbing.readUpdateStream)
--Player.writeUpdateStream = Utils.appendedFunction(Player.writeUpdateStream, ExtendedTabbing.writeUpdateStream)

-- Include database-information while saving gamedata
--FSCareerMissionInfo.saveToXMLFile = Utils.appendedFunction(FSCareerMissionInfo.saveToXMLFile, ExtendedTabbing.saveDataBase)

-- make localizations available
local i18nTable = getfenv(0).g_i18n
for l18nId,l18nText in pairs(g_i18n.texts) do
  i18nTable:setText(l18nId, l18nText)
end
