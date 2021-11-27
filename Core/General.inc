[HotkeysTitle]
Meter=String
Text=Activation
MeterStyle=Set.String:S | Set.OptionCat:S


[Option00]
Meter=String
X=r
Text=Use the skin as widget
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:S191]
Meter=Shape
MeterStyle=Set.Div:S
[Option01]
Meter=String
Text=Use hotkey in addition to dragging from top left of the screen
FontColor=#Set.Text_Color#,(255-150*#StayOnDesktop#)
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:S19131238]
Meter=Shape
MeterStyle=Set.Div:S
[Option02]
Meter=String
Text=Activation hotKey
FontColor=#Set.Text_Color#,(255-150*(#StayOnDesktop# || (1-#UseHotkey#) = 1 ? 1 : 0))
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:12]
Meter=Shape
MeterStyle=Set.Div:S
[Option03]
Meter=String
Text=Automatically hide on startup (doesn't affect refreshes)1
FontColor=#Set.Text_Color#,(255-150*#StayOnDesktop#)
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:1238]
Meter=Shape
MeterStyle=Set.Div:S
[Option04]
Meter=String
Text=Efficiency Hotkeys#CRLF#- Use tab to move to next line#CRLF#- use number keys to quickly edit rows 1-9
MeterStyle=Set.String:S | Set.OptionName:S
FontColor=#Set.Text_Color#,(255-150*#StayOnDesktop#)
;================================================================================================================================================================================

; [Time]
; Meter=String
; Text=Behavior
; MeterStyle=Set.String:S |  Set.OptionCat:S

; [Option12]
; Meter=String
; Text=Show checklist dots
; MeterStyle=Set.String:S | Set.OptionName:S


;================================================================================================================================================================================


[StayOnDesktop]
Meter=Shape
MeterStyle=Set.Bool:S
Y=([Option00:Y]-#Set.P#+(-20/2+8)*[Set.S])

[UseHotkey]
Meter=Shape
MeterStyle=Set.Bool:S
Hidden=#StayOnDesktop#
Y=([Option01:Y]-#Set.P#+(-20/2+8)*[Set.S])

[Button02]
Meter=Shape
MeterStyle=Set.Button:S
Y=([Option02:Y]-#Set.P#+(-30/2+8)*[Set.S])
Hidden=(#StayOnDesktop# || (1-#UseHotkey#) = 1 ? 1 : 0)
Act=[!CommandMeasure Func "startSide('Hotkey')"]
[Value01]
Meter=String
Text=#KeyInString#
Hidden=(#StayOnDesktop# || (1-#UseHotkey#) = 1 ? 1 : 0)
MeterStyle=Set.String:S | Set.Value:S

[HideOnStart]
Meter=Shape
MeterStyle=Set.Bool:S
Hidden=#StayOnDesktop#
Y=([Option03:Y]-#Set.P#+(-20/2+8)*[Set.S])

[EfficiencyHotkey]
Meter=Shape
MeterStyle=Set.Bool:S
Hidden=#StayOnDesktop#
Y=([Option04:Y]-#Set.P#+(-20/2+8)*[Set.S])

; [CheckDots]
; Meter=Shape
; MeterStyle=Set.Bool:S
; Y=([Option12:Y]-#Set.P#+(-20/2+8)*[Set.S])

;================================================================================================================================================================================
[Input:M]
Command2=[!SetVariable #Editing# "$UserInput$"][!UpdateMeasure SaveAndLoad2:M]

[SaveAndLoad2:M]
Measure=Calc
DynamicVariables=1
OnUpdateAction=[!WriteKeyvalue Variables #Editing# "[##Editing#]" "#Sec.SaveLocation#"][!UpdateMeter *][!Redraw][!Refresh "#Skin.Name#\Activator"]
Disabled=1
Group=NUOL

@includeKeys=#SKINSPATH##Skin.Name#\@Resources\Actions\HotKeys.ini