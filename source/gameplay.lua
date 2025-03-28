import "CoreLibs/graphics"
import "CoreLibs/sprites"

local pd = playdate
local gfx = pd.graphics

Gameplay = {}

local toDraw = {}
local gameplayImage = gfx.image.new("images/playdate_game")



function Gameplay.init()
    toDraw = {}
    AddImage(toDraw, gameplayImage, 0, 0)
end

function Gameplay.update()
    for i, img in ipairs(toDraw) do
        img[1]:draw(img[2], img[3])
    end
end