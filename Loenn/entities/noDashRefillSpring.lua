local springDepth = -8501

local function springTexture(room, entity)
    return entity.spriteDirectory .. "/00"
end

local springUp = {}

springUp.name = "MaxHelpingHand/NoDashRefillSpring"
springUp.depth = springDepth
springUp.justification = {0.5, 1.0}
springUp.texture = springTexture
springUp.placements = {
    name = "up",
    data = {
        spriteDirectory = "objects/MaxHelpingHand/noDashRefillSpring",
        playerCanUse = true,
        ignoreLighting = false
    }
}

local springRight = {}

springRight.name = "MaxHelpingHand/NoDashRefillSpringLeft"
springRight.depth = springDepth
springRight.justification = {0.5, 1.0}
springRight.texture = springTexture
springRight.rotation = math.pi / 2
springRight.placements = {
    name = "right",
    data = {
        spriteDirectory = "objects/MaxHelpingHand/noDashRefillSpring",
        ignoreLighting = false
    }
}

local springLeft = {}

springLeft.name = "MaxHelpingHand/NoDashRefillSpringRight"
springLeft.depth = springDepth
springLeft.justification = {0.5, 1.0}
springLeft.texture = springTexture
springLeft.rotation = -math.pi / 2
springLeft.placements = {
    name = "left",
    data = {
        spriteDirectory = "objects/MaxHelpingHand/noDashRefillSpring",
        ignoreLighting = false
    }
}

return {
    springUp,
    springRight,
    springLeft
}
