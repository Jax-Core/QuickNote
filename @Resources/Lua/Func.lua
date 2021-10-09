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

function checkDrag()
    local DragAmount = tonumber(SKIN:GetVariable('DragAmount'))
    local MousePos0 = SKIN:GetVariable('Mouse.0Pos')
    local MousePos1 = SKIN:GetVariable('Mouse.1Pos')
    local Pos0X, Pos0Y = MousePos0:match("([^,]+)|([^,]+)")
    local Pos1X, Pos1Y = MousePos1:match("([^,]+)|([^,]+)")
    print(Pos0X, Pos0Y, Pos1X, Pos1Y)
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



function AutoNextLine()
    local function sleep(s)
        local ntime = os.clock() + s
        repeat until os.clock() > ntime
    end

    local Bool = tonumber(SKIN:GetVariable('AutoNextLine'))
    local currentediting = SKIN:GetVariable('Editing')
    local nextIndex = tonumber(currentediting:match('%d+')) + 1
    if Bool == 1 then
        SKIN:Bang('!SetVariable', 'Editing', 'Line'..nextIndex)
        local NextObjectX = SKIN:GetMeter('Line'..nextIndex):GetX()
        local NextObjectY = SKIN:GetMeter('Line'..nextIndex):GetY()
        SKIN:Bang('!SetOption', 'mInput', 'X', NextObjectX)
        SKIN:Bang('!SetOption', 'mInput', 'Y', NextObjectY)
        SKIN:Bang('!UpdateMeasure', 'mInput')
        SKIN:Bang('!UpdateMeasure', 'mOpenInput')
    else
        SKIN:Bang('!UnPauseMeasure', 'mToggle')
    end
end

function Wipe()
    local savelocation = SKIN:GetVariable('@')..'Vars.inc'
    local savelocation2 = SKIN:GetVariable('@')..'1Bools.inc'
    for i = 1, 20 do
        SKIN:Bang('!WriteKeyvalue', 'variables', 'Line'..i, '', savelocation)
        SKIN:Bang('!WriteKeyvalue', 'variables', 'Bool'..i, '0', savelocation2)
    end
    SKIN:Bang('!Refresh')
end

function Drag()
    local savelocation = SKIN:GetVariable('@')..'Vars.inc'
    local savelocation2 = SKIN:GetVariable('@')..'1Bools.inc'
    local prev = SKIN:GetVariable('DragPrevIndex')
    local next = SKIN:GetVariable('DragNextIndex')
    local prevIndex = tonumber(prev:match('%d+'))
    local nextIndex = tonumber(next:match('%d+'))
    local prevContent = SKIN:GetVariable(prev)
    local nextContent = SKIN:GetVariable(next)
    local prevBool = SKIN:GetVariable('Bool'..prevIndex)
    local nextBool = SKIN:GetVariable('Bool'..nextIndex)
    if prev ~= next then
        SKIN:Bang('!SetVariable', next, prevContent)
        SKIN:Bang('!SetVariable', prev, nextContent)
        SKIN:Bang('!WriteKeyvalue', 'Variables', next, prevContent, savelocation)
        SKIN:Bang('!WriteKeyvalue', 'Variables', prev, nextContent, savelocation)
        print(prevBool)
        if prevBool ~= nil then
            SKIN:Bang('!SetVariable', 'Bool'..nextIndex, prevBool)
            SKIN:Bang('!SetVariable', 'Bool'..prevIndex, nextBool)
            SKIN:Bang('!WriteKeyvalue', 'Variables', 'Bool'..nextIndex, prevBool, savelocation2)
            SKIN:Bang('!WriteKeyvalue', 'Variables', 'Bool'..prevIndex, nextBool, savelocation2)
        end
        SKIN:Bang('!UpdateMeterGroup', 'Items')
        SKIN:Bang('!Redraw')
    end
    -- print(SKIN:GetVariable(next), SKIN:GetVariable(prev))
end

function Delete()
    local savelocation = SKIN:GetVariable('@')..'Vars.inc'
    local savelocation2 = SKIN:GetVariable('@')..'1Bools.inc'
    local rows = 20
    local deleteMeter = SKIN:GetVariable('HoverIndex')
    local deleteIndex = tonumber(deleteMeter:match('%d+'))
    for i = deleteIndex, (rows - deleteIndex) do
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

function Generate(change)
    local modifiedIndex = SKIN:GetVariable("Rows") + change
    if modifiedIndex < 1 then modifiedIndex = 1 end
    local savelocation = SKIN:GetVariable('@')..'Vars.inc'
    SKIN:Bang('!WriteKeyvalue', 'Variables', 'Rows', modifiedIndex, savelocation)
    local File = io.open(SKIN:GetVariable('ROOTCONFIGPATH')..'Main\\@Rows.inc','w')
    for i = 2, modifiedIndex - 1 do
        File:write(
            '[Bool'..i..']\n'
            ,'Meter=Shape\n'
            ,'MeterStyle=Stroke:S\n'
            ,'[Line'..i..']\n'
            ,'Meter=String\n'
            ,'MeterStyle=String:S | Note:S\n'
        )
    end
    File:write(
        '[Bool'..modifiedIndex..']\n'
        ,'Meter=Shape\n'
        ,'Shape=Line 0,(25*#scale#),(#W#-#P#*2),(25*#scale#) | StrokeWidth 0\n'
        ,'MeterStyle=Stroke:S\n'
        ,'[Line'..modifiedIndex..']\n'
        ,'Meter=String\n'
        ,'MeterStyle=String:S | Note:S\n'
        ) 
    if modifiedIndex < 20 then
        File:write(
            '[AddButton]\n'
            ,'Meter=Shape\n'
            ,'MeterStyle=AddButton:S\n'
            ,'[AddString]\n'
            ,'Meter=String\n'
            ,'MEterStyle=String:S | AddString:S\n'
            ,'[RemButton]\n'
            ,'Meter=Shape\n'
            ,'MeterStyle=RemButton:S\n'
            ,'[RemString]\n'
            ,'Meter=String\n'
            ,'MEterStyle=String:S | RemString:S\n'
        )
    else
        File:write(
            '[AddButton]\n'
            ,'Meter=Shape\n'
            ,'MeterStyle=AddButton:S | CapButtoN:S\n'
            ,'[AddString]\n'
            ,'Meter=String\n'
            ,'MEterStyle=String:S | AddString:S\n'
            ,'[RemButton]\n'
            ,'Meter=Shape\n'
            ,'MeterStyle=RemButton:S\n'
            ,'[RemString]\n'
            ,'Meter=String\n'
            ,'MEterStyle=String:S | RemString:S\n'
        )
    end
    File:close()
    SKIN:Bang('!Refresh')
end