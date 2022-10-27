--[[
Diminishing Returns - Attach diminishing return icons to unit frames.
--]]

local addon = _G.DiminishingReturns
if not addon then return end

addon:RegisterAddonSupport('Gladdy', function()
	--<GLOBALS
	local _G = _G
	local GetAddOnMetadata = _G.GetAddOnMetadata
	local hooksecurefunc = _G.hooksecurefunc
	local strmatch = _G.strmatch
	--GLOBALS>

	local state = 'supported'
	local version = GetAddOnMetadata("Gladdy", "Version")

	local db = addon.db:RegisterNamespace('Gladdy', {profile={
		enabled = true,
		iconSize = 32,
		direction = 'LEFT',
		spacing = 2,
		anchorPoint = 'TOPRIGHT',
		relPoint = 'TOPLEFT',
		xOffset = -10,
		yOffset = 0,
	}})

	local function GetDatabase()
		return db.profile, db
	end

	addon:RegisterFrameConfig('Gladdy', GetDatabase)

	local LibStub = _G["LibStub"]
	local Gladdy = LibStub("Gladdy")

	local function SetupFrame(frame)
		addon:Debug('Gladdy:SetupFrame', frame)
		return addon:SpawnFrame(frame:GetParent(), frame, GetDatabase)
	end

	local needHook = false
	for i = 1,5 do
		if not addon:RegisterFrame('GladdyButton'..i, SetupFrame) then
			needHook = true
		end
	end

	if needHook then
		hooksecurefunc(Gladdy, 'CreateButton', function(gladdy, unit)
			addon:Debug('Gladdy:CreateButton', "arena"..unit)
			addon.CheckFrame(gladdy.buttons["arena"..unit].secure)
		end)
	end

	return state, version
end)

