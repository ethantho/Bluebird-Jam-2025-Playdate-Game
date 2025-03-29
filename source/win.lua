import "CoreLibs/graphics"
import "CoreLibs/sprites"

local pd = playdate
local gfx = pd.graphics

Win = {}

function Win.init()
    gfx.clear()
    gfx.drawText("Win", 200, 120)
    pd.wait(2000)
end

function Win.update()
    gfx.drawText("Win", 200, 120)
    gfx.drawText("Press A to restart!", 200, 150)
    if pd.buttonJustPressed(pd.kButtonA) then
        ChangeState(Title)
    end
end
