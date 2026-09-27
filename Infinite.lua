local Sprinting = require(game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting)

local oldInit = Sprinting.Init
Sprinting.Init = function(...)
    local res = oldInit(...)
    Sprinting.StaminaLossDisabled = true
    return res
end

Sprinting.StaminaLossDisabled = true

