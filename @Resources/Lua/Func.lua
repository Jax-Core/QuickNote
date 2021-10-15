function CheckFullScreen()
    local MyMeasure = SKIN:GetMeasure('MeasureIsFullScreen')
    local mString = MyMeasure:GetStringValue()
    local mNum = MyMeasure:GetValue()
    if mString:match('Rainmeter%.exe') then
        mBool = 1
    else
        mBool = 0
    end
    local check = (mNum .. mBool)
    if string.match(check, '10') then
        SKIN:Bang('!Hide')
    else
        SKIN:Bang('!Show')
    end
end

-- -------------------------------------------------------------------------- --
--                         Row manipulation functions                         --
-- -------------------------------------------------------------------------- --

function checkDrag()
    local DragAmount = tonumber(SKIN:GetVariable('DragAmount'))
    local MousePos0 = SKIN:GetVariable('Mouse.0Pos')
    local MousePos1 = SKIN:GetVariable('Mouse.1Pos')
    local Pos0X, Pos0Y = MousePos0:match("([^,]+)|([^,]+)")
    local Pos1X, Pos1Y = MousePos1:match("([^,]+)|([^,]+)")
    local distanceX = (tonumber(Pos1X) - tonumber(Pos0X))
    local distanceY = (tonumber(Pos1Y) - tonumber(Pos0Y))
    if distanceX > DragAmount and distanceY > DragAmount then
        SKIN:Bang('!UpdateMeasure', 'mToggle')
    else
        SKIN:Bang('!SetOption', 'MouseInput', 'MeterStyle', 'Mouse:On')
        SKIN:Bang('!UpdateMeter', 'MouseInput')
        SKIN:Bang('!Redraw')
    end
end

function checkRowDrag()
    local DragAmount = tonumber(SKIN:GetVariable('DragAmount'))
    local Drag0 = SKIN:GetVariable('Drag.0')
    local Drag1 = SKIN:GetVariable('Drag.1')
    local Drag0Index = tonumber(Drag0:match('%d+'))
    local Drag1Index = tonumber(Drag1:match('%d+'))
    if Drag0Index == Drag1Index then
        SKIN:Bang('!PauseMeasure', 'mToggle')
        SKIN:Bang('!SetVariable', 'Editing', Drag0)
        SKIN:Bang('!SetOption', 'mInput', 'X', SKIN:GetMeter(Drag0):GetX())
        SKIN:Bang('!SetOption', 'mInput', 'Y', SKIN:GetMeter(Drag0):GetY())
        SKIN:Bang('!UpdateMeasure', 'mOpenInput')
    else
        SKIN:Bang('!HideMeter', 'DeleteVariMeter')
        SKIN:Bang('!Redraw')
        Drag(Drag0, Drag1)
    end
end

function Wipe()
    local savelocation = SKIN:GetVariable('@')..'Data\\'..SKIN:GetVariable('DataSource')..'\\Lines.inc'
    local savelocation2 = SKIN:GetVariable('@')..'Data\\'..SKIN:GetVariable('DataSource')..'\\1Bools.inc'
    for i = 1, 20 do
        SKIN:Bang('!WriteKeyvalue', 'variables', 'Line'..i, '', savelocation)
        SKIN:Bang('!WriteKeyvalue', 'variables', 'Bool'..i, '0', savelocation2)
    end
    SKIN:Bang('!Refresh')
end

function Drag(prev, next)
    -- ----------------------- load values into variables ----------------------- --
    local savelocation = SKIN:GetVariable('@')..'Data\\'..SKIN:GetVariable('DataSource')..'\\Lines.inc'
    local savelocation2 = SKIN:GetVariable('@')..'Data\\'..SKIN:GetVariable('DataSource')..'\\1Bools.inc'
    local prevIndex = tonumber(prev:match('%d+'))
    local nextIndex = tonumber(next:match('%d+'))
    local prevContent = SKIN:GetVariable(prev)
    local nextContent = SKIN:GetVariable(next)
    local prevBool = SKIN:GetVariable('Bool'..prevIndex)
    local nextBool = SKIN:GetVariable('Bool'..nextIndex)
    -- ----------------------------- switch function ---------------------------- --
    local function switch()
        if prev ~= next then
            SKIN:Bang('!SetVariable', next, prevContent)
            SKIN:Bang('!SetVariable', prev, nextContent)
            SKIN:Bang('!WriteKeyvalue', 'Variables', next, prevContent, savelocation)
            SKIN:Bang('!WriteKeyvalue', 'Variables', prev, nextContent, savelocation)
            if prevBool ~= nil then
                SKIN:Bang('!SetVariable', 'Bool'..nextIndex, prevBool)
                SKIN:Bang('!SetVariable', 'Bool'..prevIndex, nextBool)
                SKIN:Bang('!WriteKeyvalue', 'Variables', 'Bool'..nextIndex, prevBool, savelocation2)
                SKIN:Bang('!WriteKeyvalue', 'Variables', 'Bool'..prevIndex, nextBool, savelocation2)
            end
            SKIN:Bang('!UpdateMeterGroup', 'Items')
        end
    end
    -- -------------------------------- animation ------------------------------- --
    if tonumber(SKIN:GetVariable('TransitionalAnimations')) == 1 and tonumber(SKIN:GetVariable('Animation')) == 1 then
        -- --------------------- resets the previous animations --------------------- --
        SKIN:Bang('!SetOptionGroup', 'Animating', 'Group', 'Stroke | Items')
        -- -------------------------- disable mouse actions ------------------------- --
        SKIN:Bang('!SetOptionGroup', 'Stroke', 'This', 'Fill Color 0,0,0,1')
        SKIN:Bang('!DisableMouseActionGroup', '*', 'Items')
        SKIN:Bang('!UpdateMeterGroup', 'Items')
        switch()
        -- ----------------------------- animation start ---------------------------- --
        SKIN:Bang('!SetOption', 'Bool'..prevIndex, 'Group', 'Animating | Stroke | Items')
        SKIN:Bang('!SetOption', 'Bool'..prevIndex, 'Y', '((70+30*('..(prevIndex - 1)..'+'..(nextIndex - prevIndex)..'*#*TweenNode2*#))*#Scale#)')
        SKIN:Bang('!SetOption', 'Bool'..nextIndex, 'Group', 'Animating | Stroke | Items')
        SKIN:Bang('!SetOption', 'Bool'..nextIndex, 'Y', '((70+30*('..(nextIndex - 1)..'+'..(prevIndex - nextIndex)..'*#*TweenNode2*#))*#Scale#)')
        SKIN:Bang('!UpdateMeterGroup', 'Items')
        SKIN:Bang('!SetOption', 'mMidTween', 'FinishAction', '[!EnableMouseActionGroup * Items][!UpdateMeterGroup Items]')
        SKIN:Bang('!CommandMeasure', 'mMidTween', 'Restart(0)')
    else
        switch()
        SKIN:Bang('!Redraw')
    end
end

function Delete()
    local deleteMeter = SKIN:GetVariable('HoverIndex')
    local deleteIndex = tonumber(deleteMeter:match('%d+'))
    -- -------------------------------- animation ------------------------------- --
    if tonumber(SKIN:GetVariable('TransitionalAnimations')) == 1 and tonumber(SKIN:GetVariable('Animation')) == 1 then
        -- --------------------- resets the previous animations --------------------- --
        SKIN:Bang('!SetOptionGroup', 'Animating', 'Group', 'Stroke | Items')
        -- -------------------------- disable mouse actions ------------------------- --
        SKIN:Bang('!SetOptionGroup', 'Stroke', 'This', 'Fill Color 0,0,0,1')
        SKIN:Bang('!DisableMouseActionGroup', '*', 'Items')
        SKIN:Bang('!UpdateMeterGroup', 'Items')
        -- ------- make all meters equal and above the deleted index animating ------ --
        for i = deleteIndex, 20 do
            SKIN:Bang('!SetOption', 'Bool'..i, 'Group', 'Animating | Stroke | Items')
        end
        -- ----------------------------- animation start ---------------------------- --
        SKIN:Bang('!SetOption', 'Line'..deleteIndex, 'X', '(35*#Scale#*#CheckDots#)r')
        SKIN:Bang('!SetOption', 'Bool'..deleteIndex, 'X', '(#P#+(#W#-#P#)*(1-#*TweenNode2*#))')
        SKIN:Bang('!SetOption', 'Bool'..(deleteIndex + 1), 'Y', '((70+30*('..deleteIndex..'-(1-#*TweenNode2*#)))*#Scale#)')
        for i = deleteIndex + 2, 20 do
            SKIN:Bang('!SetOption', 'Bool'..i, 'Y', '(30*#Scale#)r')
        end
        SKIN:Bang('!UpdateMeterGroup', 'Items')
        SKIN:Bang('!SetOption', 'mMidTween', 'FinishAction', '[!CommandMEasure Func "revertDeleteAnimation()"]')
        SKIN:Bang('!CommandMeasure', 'mMidTween', 'Restart(0)')
    else
        revertDeleteAnimation()
    end
end
function revertDeleteAnimation()
    local deleteMeter = SKIN:GetVariable('HoverIndex')
    local deleteIndex = tonumber(deleteMeter:match('%d+'))
    local savelocation = SKIN:GetVariable('@')..'Data\\'..SKIN:GetVariable('DataSource')..'\\Lines.inc'
    local savelocation2 = SKIN:GetVariable('@')..'Data\\'..SKIN:GetVariable('DataSource')..'\\1Bools.inc'
    if tonumber(SKIN:GetVariable('TransitionalAnimations')) == 1 and tonumber(SKIN:GetVariable('Animation')) == 1 then
        for i = deleteIndex, 20 do
            SKIN:Bang('!WriteKeyvalue', 'Variables', "Line"..i, SKIN:GetVariable("Line"..i+1), savelocation)
            if SKIN:GetVariable('Bool1') ~= nil then
                SKIN:Bang('!WriteKeyvalue', 'Variables', "Bool"..i, SKIN:GetVariable("Bool"..i+1), savelocation2)
            end
        end
        SKIN:Bang('!Refresh')
    else
        for i = deleteIndex, 20 do
            SKIN:Bang('!SetVariable', "Line"..i, SKIN:GetVariable("Line"..i+1))
            SKIN:Bang('!WriteKeyvalue', 'Variables', "Line"..i, SKIN:GetVariable("Line"..i+1), savelocation)
            if SKIN:GetVariable('Bool1') ~= nil then
                SKIN:Bang('!SetVariable', "Bool"..i, SKIN:GetVariable("Bool"..i+1))
                SKIN:Bang('!WriteKeyvalue', 'Variables', "Bool"..i, SKIN:GetVariable("Bool"..i+1), savelocation2)
            end
        end
        SKIN:Bang('!UpdateMeterGroup', 'Items')
        SKIN:Bang('!Redraw')
    end
end



function Generate(change)
    local modifiedIndex = SKIN:GetVariable("Rows") + change
    if modifiedIndex < 1 then modifiedIndex = 1 end
    local savelocation = SKIN:GetVariable('@')..'Vars.inc'
    SKIN:Bang('!WriteKeyvalue', 'Variables', 'Rows', modifiedIndex, savelocation)
    -- SKIN:Bang('!WriteKeyvalue', 'Variables', 'H', (70*#Scale#+30*#Scale#*'..modifiedIndex..'), SKIN:GetVariable('ROOTCONFIGPATH')..'Main\\Main.ini')
    local File = io.open(SKIN:GetVariable('ROOTCONFIGPATH')..'Main\\@Rows.inc','w')
    for i = 2, modifiedIndex - 1 do
        File:write(
            '[Bool'..i..']\n'
            ,'Meter=Shape\n'
            ,'Y=((70+30*'..(i - 1)..')*#Scale#)\n'
            ,'MeterStyle=Stroke:S\n'
            ,'[Line'..i..']\n'
            ,'Meter=String\n'
            ,'MeterStyle=String:S | Note:S\n'
        )
    end
    File:write(
        '[Bool'..modifiedIndex..']\n'
        ,'Meter=Shape\n'
        ,'Y=((70+30*'..(modifiedIndex - 1)..')*#Scale#)\n'
        ,'Shape=Line 0,(25*#scale#),(#W#-#P#*2),(25*#scale#) | StrokeWidth 0\n'
        ,'MeterStyle=Stroke:S\n'
        ,'[Line'..modifiedIndex..']\n'
        ,'Meter=String\n'
        ,'MeterStyle=String:S | Note:S\n'
        ) 
    File:close()
    SKIN:Bang('!Refresh')
end

-- -------------------------------------------------------------------------- --
--                       Dropdown and utility functions                       --
-- -------------------------------------------------------------------------- --



function startDrop(variant, handler, offset)
	local File = SKIN:GetVariable('ROOTCONFIGPATH')..'Main\\Accessories\\Drop.ini'
	local MyMeter = SKIN:GetMeter(handler)
	local scale = tonumber(SKIN:GetVariable('Scale'))
    local PosX = MyMeter:GetX() + offset * scale
    local PosY = MyMeter:GetY() + offset * scale
	SKIN:Bang('!WriteKeyvalue', 'Variables', 'Sec.name', skin, File)
	SKIN:Bang('!WriteKeyvalue', 'Variables', 'Sec.Variant', variant, File)
	SKIN:Bang('!WriteKeyvalue', 'Variables', 'Sec.S', scale, File)
	SKIN:Bang('!PauseMeasure', 'mToggle')
    SKIN:Bang('!ZPos', '0')
	SKIN:Bang('!Activateconfig', 'QuickNote\\Main\\Accessories', 'Drop.ini')
	SKIN:Bang('!Move', PosX, PosY, 'QuickNote\\Main\\Accessories')
end