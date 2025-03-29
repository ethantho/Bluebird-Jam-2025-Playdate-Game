import "CoreLibs/graphics"
import "CoreLibs/sprites"

local pd = playdate
local gfx = pd.graphics

Lose = {}

function Lose.init()
    gfx.clear()
    gfx.drawText("L+RATIO", 200, 120)
    pd.wait(250)
end

function Lose.update()
    gfx.drawText("L+RATIO", 200, 120)
    gfx.drawText("Press A to restart!", 200, 150)

    if pd.buttonIsPressed(playdate.kButtonA) then
        ChangeState(Title)
    end
end