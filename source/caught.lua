import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/crank"

local pd = playdate
local gfx = pd.graphics

Caught = {}

local toDraw = {}
local background = {gfx.image.new("images/background_idle0"), gfx.image.new("images/background_idle1"), gfx.image.new("images/background_idle2") }
local binocularsGuy = {gfx.image.new("images/curtains_up_hold0"), gfx.image.new("images/curtains_up_hold1"), gfx.image.new("images/curtains_up_hold2")}
local personShocked = {gfx.image.new("images/person_shocked0"), gfx.image.new("images/person_shocked1"), gfx.image.new("images/person_shocked2")}
local handIdle = {gfx.image.new("images/hand_idle0"), gfx.image.new("images/hand_idle1"), gfx.image.new("images/hand_idle2")}

local animFrame = 0

function Caught.init()
    toDraw = {}
    AddImage(toDraw, background, 0, 0)
    AddImage(toDraw, binocularsGuy, 0, 0)
    AddImage(toDraw, personShocked, 0, 0)
    AddImage(toDraw, handIdle, 0, 0)
    animFrame = 0
end

function Caught.update()
    Caught.input()

    Caught.draw()
end

function Caught.input()

end

function Caught.draw()
    for i, img in ipairs(toDraw) do
        img[1][(math.floor(animFrame) % #img[1]) + 1]:drawRotated(img[2] + 200, img[3] + 120, 0)--pd.getCrankPosition())
    end

    --gfx.drawText("*Position: "..crankPos.."*", 5, 50)
    --gfx.drawText("Index: "..comboIndex, 300, 200)
    --gfx.drawText("*Time Left: "..timeLeft.."*", 290, 25)

    --animFrame += 0.25
end