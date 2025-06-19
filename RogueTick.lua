local _, class = UnitClass("player")
if class ~= "ROGUE" then
    return
end

local f = CreateFrame("Frame", "RogueTickFrame")

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UNIT_ENERGY")

f:SetScript("OnEvent", function()
    if event == "PLAYER_ENTERING_WORLD" then
        DEFAULT_CHAT_FRAME:AddMessage("RogueTick", 0, 1, 0)
    elseif event == "UNIT_ENERGY" then
        DEFAULT_CHAT_FRAME:AddMessage(event, 0, 1, 0)
    end
end)
