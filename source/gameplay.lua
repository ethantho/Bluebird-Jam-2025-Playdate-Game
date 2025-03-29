import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/crank"

local pd = playdate
local gfx = pd.graphics

Gameplay = {}

local toDraw = {}
local gameplayImage = gfx.image.new("images/playdate_game")

local combo = {45, 270, 180}
local hazards = {}
local comboIndex = 1
local frame = 0
local timeLimit <const> = 20
local activeHazard = nil

function Gameplay.init()
    toDraw = {}
    AddImage(toDraw, gameplayImage, 0, 0)
    comboIndex = 1
    frame = 0
    GenHazards()
    activeHazard = nil
end

function Gameplay.update()

    local crankPos = pd.getCrankPosition()

    for i, img in ipairs(toDraw) do
        img[1]:drawRotated(img[2] + 200, img[3] + 120, pd.getCrankPosition())
    end

    if pd.buttonJustPressed(pd.kButtonA) and math.abs(combo[comboIndex] - crankPos) < 10 then
        comboIndex += 1
    elseif pd.buttonJustPressed(pd.kButtonA) then
        frame += 150
    end

    if comboIndex > #combo then
        ChangeState(Win)
    end

    if frame / 30 >= timeLimit then
        ChangeState(Lose)
    end

    gfx.drawText(crankPos, 300, 120)
    gfx.drawText(comboIndex, 300, 200)
    gfx.drawText("Time Left: "..(timeLimit - frame / 30), 250, 30)
    frame += 1
end

function GenHazards()
    --HAZARD FORMAT:
    -- {startFrame, soundEffect, timeUntilKill}
    hazards = {
        {30, nil, 10}
    }
end