import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/crank"

local pd = playdate
local gfx = pd.graphics

Gameplay = {}

local toDraw = {}
local background = {gfx.image.new("images/background_idle0"), gfx.image.new("images/background_idle1"), gfx.image.new("images/background_idle2") }
local binocularsGuy = {gfx.image.new("images/curtains_up_hold0"), gfx.image.new("images/curtains_up_hold1"), gfx.image.new("images/curtains_up_hold2")}
local personHappy = {gfx.image.new("images/person_happy0"), gfx.image.new("images/person_happy1"), gfx.image.new("images/person_happy2")}
local handIdle = {gfx.image.new("images/hand_idle0"), gfx.image.new("images/hand_idle1"), gfx.image.new("images/hand_idle2")}

local curtains = {gfx.image.new("images/curtains_idle0")}
local curtainsUp = {gfx.image.new("images/curtains_up0"), gfx.image.new("images/curtains_up1"), gfx.image.new("images/curtains_up2")}
local areCurtainsUp = false
--local curtains0 = 
local combo = {45, 270, 180}
local hazards = {}
local comboIndex = 1
local frame = 0
local animFrame = 0
local hazardFrame = 0
local timeLimit <const> = 20
local activeHazard = nil
local activeHazardStartFrame = 0
local activeHazardKillFrame = 0
local hazardIndex = 1
local crankPos = 0
local timeLeft = 999999999
local hiding = false

function Gameplay.init()
    toDraw = {}
    AddImage(toDraw, background, 0, 0)
    --AddImage(toDraw, binocularsGuy, 0, 0)
    AddImage(toDraw, personHappy, 0, 0)
    AddImage(toDraw, handIdle, 0, 0)
    AddImage(toDraw, curtains, 0, 0)
    hazardIndex = 1
    comboIndex = 1
    frame = 0
    animFrame = 0
    hazardFrame = 0
    GenHazards()
    GenCombo()
    activeHazard = nil
    
end

function Gameplay.update()
    Gameplay.input()
    
    timeLeft = math.floor((timeLimit - (frame / 30))+0.5)
    Gameplay.checkForWinLoss()
    Gameplay.doHazards()
    frame += 1
    hazardFrame += 1

    Gameplay.draw()
    print(activeHazard)
end

function Gameplay.draw()
    for i, img in ipairs(toDraw) do
        img[1][(math.floor(animFrame) % #img[1]) + 1]:drawRotated(img[2] + 200, img[3] + 120, 0)--pd.getCrankPosition())
    end

    gfx.drawText("*Position: "..crankPos.."*", 1, 50)
    gfx.drawText("Index: "..comboIndex, 300, 200)
    gfx.drawText("*Time Left: "..timeLeft.."*", 290, 25)

    animFrame += 0.25
end

function Gameplay.checkForWinLoss()
    if comboIndex > #combo then
        ChangeState(Win)
    end

    if timeLeft <= 0 then
        ChangeState(Lose)
    end
end

function Gameplay.input()
    crankPos = math.floor(pd.getCrankPosition()+0.5)

    if pd.buttonJustPressed(pd.kButtonA) and math.abs(combo[comboIndex] - crankPos) < 10 then
        comboIndex += 1
        --TODO: PLAY CORRECT DING SOUND
    elseif pd.buttonJustPressed(pd.kButtonA) then
        frame += 150
        --TODO: PLAY BUZZER SOUND
    end
end

function GenHazards()
    hazards = {
        {startFrame = 30, soundEffect = nil, timeUntilKill = 2} --time is in seconds
    }
end

function Gameplay.doHazards()
    --start new hazards
    if activeHazard == nil and hazardFrame > hazards[hazardIndex].startFrame then
        activeHazard = hazards[hazardIndex]
        activeHazardStartFrame = hazardFrame
        activeHazardKillFrame = activeHazardStartFrame + (activeHazard.timeUntilKill * 30.0) --converted to frames
        hazardIndex += 1
    end

    --check for hazard completion
    if activeHazard ~= nil then

        --curtains up animation
        if (not areCurtainsUp) and hazardFrame > activeHazardKillFrame - (12) then
            toDraw[4] = {{curtainsUp[1]}, 0, 0}
            --areCurtainsUp = true
        end
        if (not areCurtainsUp) and hazardFrame > activeHazardKillFrame - (8) then
            toDraw[4] = {{curtainsUp[2]}, 0, 0}
            --areCurtainsUp = true
        end
        if (not areCurtainsUp) and hazardFrame > activeHazardKillFrame - (4) then
            toDraw[4] = {{curtainsUp[3]}, 0, 0}
            --areCurtainsUp = true
        end

        if hazardFrame > activeHazardKillFrame then
            Gameplay.checkForKill()
            activeHazard = nil
            activeHazardStartFrame = 99999
            activeHazardKillFrame = 99999
            toDraw[4] = {curtains, 0, 0}
            areCurtainsUp = false
        end
    end
end

function Gameplay.checkForKill()
    if not hiding then
        ChangeState(Caught) --PLACEHOLDER, PROBABLY SHOULD GO TO "CAUGHT" STATE FIRST
    end
end

function GenCombo()
    combo = {math.random(0, 359), math.random(0, 359), math.random(0, 359)}
end