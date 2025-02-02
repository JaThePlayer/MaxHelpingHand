local utils = require("utils")
local drawableSprite = require("structs.drawable_sprite")

local floatingDebris = {}

floatingDebris.name = "MaxHelpingHand/ReskinnableFloatingDebris"
floatingDebris.depth = -5
floatingDebris.placements = {
    name = "floating_debris",
    data = {
        texture = "scenery/debris",
        depth = -5
    }
}

floatingDebris.fieldInformation = {
    fadeOutTint = {
        depth = "integer"
    }
}

function floatingDebris.sprite(room, entity)
    utils.setSimpleCoordinateSeed(entity.x, entity.y)

    local sprite = drawableSprite.fromTexture(entity.texture, entity)
    local offsetX = math.random(0, sprite.meta.width / 8 - 1) * 8

    -- Manually offset the sprite, otherwise it will justify with the original image size
    sprite:useRelativeQuad(offsetX, 0, 8, 8)
    sprite:setJustification(0.0, 0.0)
    sprite:addPosition(-4, -4)

    return sprite
end

function floatingDebris.selection(room, entity)
    return utils.rectangle(entity.x - 4, entity.y - 4, 8, 8)
end

return floatingDebris
