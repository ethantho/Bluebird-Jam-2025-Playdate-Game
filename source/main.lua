import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "title.lua"
import "gameplay.lua"
import "win.lua"
import "lose.lua"
import "caught.lua"

local pd = playdate
local gfx = pd.graphics

GameState = nil

function ChangeState(state)
    state.init()
    GameState = state
end

ChangeState(Title)

--30 fps by default
function pd.update()
    gfx.clear()
    if GameState then
        GameState.update()
    end
end


