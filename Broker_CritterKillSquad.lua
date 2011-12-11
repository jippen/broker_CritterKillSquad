local progress = GetStatistic(5144)

local FORCE_UPDATE = 100
local counter = 0
local delay = 1

local CritterKillSquad = CreateFrame("Frame")
CritterKillSquad.obj = LibStub("LibDataBroker-1.1"):NewDataObject("Broker_CritterKillSquad", {
	type = "data source",
	icon = "Interface\\Icons\\Ability_Hunter_Aspectofthefox",
	label = "Critters to Kill",
	text  = progress,
	
	OnClick = function(self, btn)
		CritterKillSquad:OnUpdate(FORCE_UPDATE)
	end,
})

function CritterKillSquad:OnUpdate(elapsed)
	counter = counter + elapsed
	if counter >= delay then
		self.obj.text = GetStatistic(5144)
		counter = 0
	end
end

function CritterKillSquad:ADDON_LOADED(event, addon)
	if addon == "Broker_CritterKillSquad" then
		self:OnUpdate(FORCE_UPDATE)
		self:UnregisterEvent("ADDON_LOADED")
		self:SetScript("OnEvent", nil)
		self.ADDON_LOADED = nil
	end
end

CritterKillSquad:SetScript("OnUpdate", CritterKillSquad.OnUpdate)
CritterKillSquad:SetScript("OnEvent", CritterKillSquad.ADDON_LOADED)
CritterKillSquad:RegisterEvent("ADDON_LOADED")