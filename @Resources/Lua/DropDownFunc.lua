function GetMeter(meter, value)
    local TheMeter = SKIN:GetMeter(meter)
    return TheMeter:GetOption(value)
end