local FORCE_UPDATE = 2
local counter = 0

local CritterKillSquad = CreateFrame("Frame")
CritterKillSquad.obj = LibStub("LibDataBroker-1.1"):NewDataObject("Broker_CritterKillSquad", {
	type = "data source",
	icon = "Interface\\Icons\\Ability_Hunter_Aspectofthefox",
	label = "Critters to Kill",
	text  = "?",
	
	OnClick = function(self, btn)
		CritterKillSquad:OnUpdate(FORCE_UPDATE)
	end,
})

function CritterKillSquad:OnUpdate(elapsed)
	counter = counter + elapsed
	if counter >= FORCE_UPDATE then
		-- Load Critter Kill Squad
		_, _, completed, _, _, _, _, _, quantityString, _ = GetAchievementCriteriaInfo(5144, 1);
		if completed then
			-- Load Crittergeddon
			_, _, completed, _, _s, _, _, _, quantityString, _ = GetAchievementCriteriaInfo(5263, 1);
			if completed then 
				self.obj.text = "Done"
				return 
			end
		end
		self.obj.text = quantityString 
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