local drawableSprite = require("structs.drawable_sprite")
local drawableLine = require("structs.drawable_line")
local drawableNinePatch = require("structs.drawable_nine_patch")
local drawableRectangle = require("structs.drawable_rectangle")
local utils = require("utils")

local swapBlock = {}

local textures = {
    frame = "/blockRed",
    trail = "/target",
    middle = "/midBlockRed00"
}

local frameNinePatchOptions = {
    mode = "fill",
    borderMode = "repeat"
}

local trailNinePatchOptions = {
    mode = "fill",
    borderMode = "repeat",
    useRealSize = true
}

local pathNinePatchOptions = {
    mode = "fill",
    fillMode = "repeat",
    border = 0
}

local pathDepth = 8999
local trailDepth = 8999
local blockDepth = -9999

swapBlock.name = "MaxHelpingHand/ReskinnableSwapBlock"
swapBlock.nodeLimits = {1, 1}
swapBlock.placements = {}
swapBlock.minimumSize = {16, 16}

swapBlock.placements = {
    name = "swapblock",
    data = {
        width = 16,
        height = 16,
        spriteDirectory = "objects/swapblock",
        transparentBackground = false,
        particleColor1 = "fbf236",
        particleColor2 = "6abe30",
        moveSound = "event:/game/05_mirror_temple/swapblock_move",
        returnSound = "event:/game/05_mirror_temple/swapblock_return",
        moveEndSound = "event:/game/05_mirror_temple/swapblock_move_end",
        returnEndSound = "event:/game/05_mirror_temple/swapblock_return_end"
    }
}

swapBlock.fieldOrder = {"x", "y", "width", "height", "moveSound", "moveEndSound", "returnSound", "returnEndSound"}

swapBlock.fieldInformation = {
    spriteDirectory = {
        options = { "objects/swapblock", "objects/swapblock/moon" }
    }
}

local function addBlockSprites(sprites, entity, frameTexture, middleTexture)
    local x, y = entity.x or 0, entity.y or 0
    local width, height = entity.width or 8, entity.height or 8

    local frameNinePatch = drawableNinePatch.fromTexture(frameTexture, frameNinePatchOptions, x, y, width, height)
    local frameSprites = frameNinePatch:getDrawableSprite()
    local middleSprite = drawableSprite.fromTexture(middleTexture, entity)

    middleSprite:addPosition(math.floor(width / 2), math.floor(height / 2))
    middleSprite.depth = blockDepth

    for _, sprite in ipairs(frameSprites) do
        sprite.depth = blockDepth

        table.insert(sprites, sprite)
    end

    table.insert(sprites, middleSprite)
end

local function addTrailSprites(sprites, entity, trailTexture)
    local nodes = entity.nodes or {}
    local x, y = entity.x or 0, entity.y or 0
    local nodeX, nodeY = nodes[1].x or x, nodes[1].y or y
    local width, height = entity.width or 8, entity.height or 8
    local drawWidth, drawHeight = math.abs(x - nodeX) + width, math.abs(y - nodeY) + height

    x, y = math.min(x, nodeX), math.min(y, nodeY)

    local pathDirection = x == nodeX and "V" or "H"
    local pathTexture = string.format("%s/path%s", entity.transparentBackground and "MaxHelpingHand/swapblocktransparentbg" or entity.spriteDirectory, pathDirection)
    local pathNinePatch = drawableNinePatch.fromTexture(pathTexture, pathNinePatchOptions, x, y, drawWidth, drawHeight)
    local pathSprites = pathNinePatch:getDrawableSprite()

    for _, sprite in ipairs(pathSprites) do
        sprite.depth = pathDepth

        table.insert(sprites, sprite)
    end

    local frameNinePatch = drawableNinePatch.fromTexture(trailTexture, trailNinePatchOptions, x, y, drawWidth, drawHeight)
    local frameSprites = frameNinePatch:getDrawableSprite()

    for _, sprite in ipairs(frameSprites) do
        sprite.depth = trailDepth

        table.insert(sprites, sprite)
    end
end

function swapBlock.sprite(room, entity)
    local sprites = {}

    addTrailSprites(sprites, entity, entity.spriteDirectory .. textures.trail)
    addBlockSprites(sprites, entity, entity.spriteDirectory .. textures.frame, entity.spriteDirectory .. textures.middle)

    return sprites
end

function swapBlock.nodeSprite(room, entity)
    local sprites = {}

    addBlockSprites(sprites, entity, entity.spriteDirectory .. textures.frame, entity.spriteDirectory .. textures.middle)

    return sprites
end

function swapBlock.selection(room, entity)
    local nodes = entity.nodes or {}
    local x, y = entity.x or 0, entity.y or 0
    local nodeX, nodeY = nodes[1].x or x, nodes[1].y or y
    local width, height = entity.width or 8, entity.height or 8

    return utils.rectangle(x, y, width, height), {utils.rectangle(nodeX, nodeY, width, height)}
end

return swapBlock
