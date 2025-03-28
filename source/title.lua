import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "Gameplay.lua"

local pd = playdate
local gfx = pd.graphics

Title = {
}

local titleImage = gfx.image.new("images/playdate_game2")
local toDraw = {}

function Title.init()
    toDraw = {}
    AddImage(toDraw, titleImage, 0, 0)
end

function Title.update()
    for i, img in ipairs(toDraw) do
        img[1]:draw(img[2], img[3])
    end
    if pd.buttonIsPressed(playdate.kButtonA) then
        ChangeState(Gameplay)
    end
end

function AddImage(tableToAddTo, img, x, y)
    table.insert(tableToAddTo, {img, x, y})
end