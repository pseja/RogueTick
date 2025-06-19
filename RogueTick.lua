local _, class = UnitClass("player")
if class ~= "ROGUE" then
    return
end

local TICK_INTERVAL = 2.0
local last_tick = 0.0
local last_energy = 0

local f = CreateFrame("Frame", "RogueTickFrame")

local indicator = f:CreateTexture(nil, "OVERLAY")
indicator:SetWidth(16)
indicator:SetHeight(16)
indicator:SetTexture("interface\\castingbar\\ui-castingbar-spark")
indicator:SetBlendMode("ADD")

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UNIT_ENERGY")

f:SetScript("OnEvent", function()
    if event == "PLAYER_ENTERING_WORLD" then
        indicator:SetPoint("CENTER", "PlayerFrameManaBar", "LEFT", 0, 0)

        last_tick = GetTime()
        last_energy = UnitMana("player")
    elseif event == "UNIT_ENERGY" then
        local current_energy = UnitMana("player")

        if current_energy > last_energy then
            last_tick = GetTime()
        end

        last_energy = current_energy
    end
end)

f:SetScript("OnUpdate", function()
    local current = GetTime()

    if current - last_tick >= TICK_INTERVAL then
        last_tick = current
    end

    local time_since_tick = current - last_tick
    local progress = time_since_tick / TICK_INTERVAL

    local bar_width = PlayerFrameManaBar:GetWidth() * 0.75
    local x_offset = bar_width * progress

    indicator:SetPoint("CENTER", "PlayerFrameManaBar", "LEFT", x_offset, 0)
end)
