[HotkeysTitle]
Meter=String
Text=General
MeterStyle=Set.String:S | Set.OptionCat:S

[Option01]
Meter=String
X=r
Text=Font face
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:Ss1231231]
Meter=Shape
MeterStyle=Set.Div:S
[Option02]
Meter=String
Text=Skin scale
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:12123138]
Meter=Shape
MeterStyle=Set.Div:S
[Option03]
Meter=String
Text=Corner rounding
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:1238]
Meter=Shape
MeterStyle=Set.Div:S
[Option04]
Meter=String
Text=QuickNote orb icon
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:112414238]
Meter=Shape
MeterStyle=Set.Div:S
[Option05]
Meter=String
Text=Distance of panel from top edge
FontColor=#Set.Text_Color#,(255-150*#StayOnDesktop#)
MeterStyle=Set.String:S | Set.OptionName:S

;================================================================================================================================================================================

[Time]
Meter=String
Text=Animations
MeterStyle=Set.String:S |  Set.OptionCat:S

[Option11]
Meter=String
Text=Summoning animation
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:Ss]
Meter=Shape
MeterStyle=Set.Div:S
[Option12]
Meter=String
Text=Summon animation duration
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:S123]
Meter=Shape
MeterStyle=Set.Div:S
[Option13]
Meter=String
Text=Transitional animation
MeterStyle=Set.String:S | Set.OptionName:S


;================================================================================================================================================================================

[Anim]
Meter=String
Text=Colors and filling
MeterStyle=Set.String:S | Set.OptionCat:S

[Option20]
Meter=String
Text=Background color
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:S1381]
Meter=Shape
MeterStyle=Set.Div:S
[Option21]
Meter=String
Text=Secondary color
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:S1382]
Meter=Shape
MeterStyle=Set.Div:S
[Option22]
Meter=String
Text=Divider color
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:S1383]
Meter=Shape
MeterStyle=Set.Div:S
[Option23]
Meter=String
Text=Font color
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:S1384]
Meter=Shape
MeterStyle=Set.Div:S
[Option24]
Meter=String
Text=Accent color
MeterStyle=Set.String:S | Set.OptionName:S
[Set.Div:S1385]
Meter=Shape
MeterStyle=Set.Div:S
[Option25]
Meter=String
Text=Check circle colors
MeterStyle=Set.String:S | Set.OptionName:S

;================================================================================================================================================================================

[FontFace]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Str
Y=([Option01:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value01]
Meter=String
Text=#FontFace#
MeterStyle=Set.String:S | Set.Value:S
[Scale]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Num|0.5|2
Y=([Option02:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value02]
Meter=String
Text=#Scale#
MeterStyle=Set.String:S | Set.Value:S
[R]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Num|0|30
Y=([Option03:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value03]
Meter=String
Text=#R#
MeterStyle=Set.String:S | Set.Value:S
[Button04]
Meter=Shape
MeterStyle=Set.Button:S
Act=[!CommandMEasure Func "startBox('NoteOrb', '#IconName#')"]
Y=([Option04:Y]-[ContentContainer:Y]+(-30/2+8)*[Set.S])
[Value04]
Meter=String
Text=#IconName#
MeterStyle=Set.String:S | Set.Value:S
[ScreenPadding]
Meter=Shape
MeterStyle=Set.Textbox:S
Hidden=#StayOnDesktop#
Type=Num|0|50
Y=([Option05:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value05]
Meter=String
Text=#ScreenPadding#
Hidden=#StayOnDesktop#
MeterStyle=Set.String:S | Set.Value:S

[Animation]
Meter=Shape
MeterStyle=Set.Bool:S
Y=([Option11:Y]-#Set.P#+(-20/2+8)*[Set.S])
[TweenTime1]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Int|300|1000
Y=([Option12:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value12]
Meter=String
Text=#TweenTime1#
MeterStyle=Set.String:S | Set.Value:S
[TransitionalAnimations]
Meter=Shape
MeterStyle=Set.Bool:S
Y=([Option13:Y]-#Set.P#+(-20/2+8)*[Set.S])

[Maincolor]
Meter=Shape
MeterStyle=Set.Color:S
Y=([Option20:Y]-#Set.P#+(-30/2+8)*[Set.S])
[SecColor]
Meter=Shape
MeterStyle=Set.Color:S
Y=([Option21:Y]-#Set.P#+(-30/2+8)*[Set.S])
[StrokeColor]
Meter=Shape
MeterStyle=Set.Color:S
Y=([Option22:Y]-#Set.P#+(-30/2+8)*[Set.S])
[FontColor]
Meter=Shape
MeterStyle=Set.Color:S
Y=([Option23:Y]-#Set.P#+(-30/2+8)*[Set.S])
[AccentColor]
Meter=Shape
MeterStyle=Set.Color:S
Y=([Option24:Y]-#Set.P#+(-30/2+8)*[Set.S])
[BoolColor]
Meter=Shape
MeterStyle=Set.Color:S
Y=([Option25:Y]-#Set.P#+(-30/2+8)*[Set.S])