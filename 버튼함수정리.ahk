;버튼처리
icon_0:
{
	;누른 버튼 활성화
	;나머지 버튼 비활성화
	;배경화면 변경
	GuiControl, , Debug, 버튼누름!
	GuiControl,,% Buttonhwnd,% "icons_ports_2.png"


	;Gui, Add, Picture, x0 y0 w1050 h857, %A_ScriptDir%\yulcroimgLVC\Map\Map_2fish%GridYn%.png
	;Gui, Show, NoActivate
}
return

;feathers
icon_1:
{
	if (B1.ButtonPressed = 0)
		Mapnow := 0
	else
		Mapnow := 1


	;누른 버튼 활성화
	;나머지 버튼 비활성화
	;배경화면 변경
	GuiControl, , BGMap, %A_ScriptDir%\yulcroimgLVC\Map\Map_%Mapnow%%GridYn%.png

	;turnoffBtn(1)

	;if(B1.ButtonPressed != 0){
		;B1.ButtonPressed := 0
		;turnoffBtn(1)
	;}
	if(B2.ButtonPressed != 0){
		B2.ButtonPressed := 0
		turnoffBtn(2)
	}
	if(B3.ButtonPressed != 0){
		B3.ButtonPressed := 0
		turnoffBtn(3)
	}
	if(B4.ButtonPressed != 0){
		B4.ButtonPressed := 0
		turnoffBtn(4)
	}
	if(B5.ButtonPressed != 0){
		B5.ButtonPressed := 0
		turnoffBtn(5)
	}
	if(B6.ButtonPressed != 0){
		B6.ButtonPressed := 0
		turnoffBtn(6)
	}

	;아직 해야하나 잘 모르겠음
	Gui, Show, NoActivate
}
return

;fish
icon_2:
{
	if (B2.ButtonPressed = 0)
		Mapnow := 0
	else
		Mapnow := 2
	B1.ButtonState := 0
	GuiControl, , BGMap, %A_ScriptDir%\yulcroimgLVC\Map\Map_%Mapnow%%GridYn%.png
	;turnoffBtn(2)

	if(B1.ButtonPressed != 0){
		B1.ButtonPressed := 0
		turnoffBtn(1)
	}
	;if(B2.ButtonPressed != 0){
		;B2.ButtonPressed := 0
		;turnoffBtn(2)
	;}
	if(B3.ButtonPressed != 0){
		B3.ButtonPressed := 0
		turnoffBtn(3)
	}
	if(B4.ButtonPressed != 0){
		B4.ButtonPressed := 0
		turnoffBtn(4)
	}
	if(B5.ButtonPressed != 0){
		B5.ButtonPressed := 0
		turnoffBtn(5)
	}
	if(B6.ButtonPressed != 0){
		B6.ButtonPressed := 0
		turnoffBtn(6)
	}

	;아직 해야하나 잘 모르겠음
	Gui, Show, NoActivate

}
return

;plants
icon_3:
{
	if (B3.ButtonPressed = 0)
		Mapnow := 0
	else
		Mapnow := 3

	GuiControl, , BGMap, %A_ScriptDir%\yulcroimgLVC\Map\Map_%Mapnow%%GridYn%.png

	;turnoffBtn(3)

	if(B1.ButtonPressed != 0){
		B1.ButtonPressed := 0
		turnoffBtn(1)
	}
	if(B2.ButtonPressed != 0){
		B2.ButtonPressed := 0
		turnoffBtn(2)
	}
	;if(B3.ButtonPressed != 0){
		;B3.ButtonPressed := 0
		;turnoffBtn(3)
	;}
	if(B4.ButtonPressed != 0){
		B4.ButtonPressed := 0
		turnoffBtn(4)
	}
	if(B5.ButtonPressed != 0){
		B5.ButtonPressed := 0
		turnoffBtn(5)
	}
	if(B6.ButtonPressed != 0){
		B6.ButtonPressed := 0
		turnoffBtn(6)
	}

	;아직 해야하나 잘 모르겠음
	Gui, Show, NoActivate
}
return

;shops
icon_4:
{
	if (B4.ButtonPressed = 0)
		Mapnow := 0
	else
		Mapnow := 4

	GuiControl, , BGMap, %A_ScriptDir%\yulcroimgLVC\Map\Map_%Mapnow%%GridYn%.png

	;turnoffBtn(4)

	if(B1.ButtonPressed != 0){
		B1.ButtonPressed := 0
		turnoffBtn(1)
	}
	if(B2.ButtonPressed != 0){
		B2.ButtonPressed := 0
		turnoffBtn(2)
	}
	if(B3.ButtonPressed != 0){
		B3.ButtonPressed := 0
		turnoffBtn(3)
	}
	;if(B4.ButtonPressed != 0){
		;B4.ButtonPressed := 0
		;turnoffBtn(4)
	;}
	if(B5.ButtonPressed != 0){
		B5.ButtonPressed := 0
		turnoffBtn(5)
	}
	if(B6.ButtonPressed != 0){
		B6.ButtonPressed := 0
		turnoffBtn(6)
	}

	;아직 해야하나 잘 모르겠음
	Gui, Show, NoActivate
}
return

;monuments
icon_5:
{
	if (B5.ButtonPressed = 0)
		Mapnow := 0
	else
		Mapnow := 5

	GuiControl, , BGMap, %A_ScriptDir%\yulcroimgLVC\Map\Map_%Mapnow%%GridYn%.png

	;turnoffBtn(5)

	if(B1.ButtonPressed != 0){
		B1.ButtonPressed := 0
		turnoffBtn(1)
	}
	if(B2.ButtonPressed != 0){
		B2.ButtonPressed := 0
		turnoffBtn(2)
	}
	if(B3.ButtonPressed != 0){
		B3.ButtonPressed := 0
		turnoffBtn(3)
	}
	if(B4.ButtonPressed != 0){
		B4.ButtonPressed := 0
		turnoffBtn(4)
	}
	;if(B5.ButtonPressed != 0){
		;B5.ButtonPressed := 0
		;turnoffBtn(5)
	;}
	if(B6.ButtonPressed != 0){
		B6.ButtonPressed := 0
		turnoffBtn(6)
	}

	;아직 해야하나 잘 모르겠음
	Gui, Show, NoActivate
}
return

icon_6:
{
	if (B6.ButtonPressed = 0)
		Mapnow := 0
	else
		Mapnow := 6

	GuiControl, , BGMap, %A_ScriptDir%\yulcroimgLVC\Map\Map_%Mapnow%%GridYn%.png

	;turnoffBtn(6)

	if(B1.ButtonPressed != 0){
		B1.ButtonPressed := 0
		turnoffBtn(1)
	}
	if(B2.ButtonPressed != 0){
		B2.ButtonPressed := 0
		turnoffBtn(2)
	}
	if(B3.ButtonPressed != 0){
		B3.ButtonPressed := 0
		turnoffBtn(3)
	}
	if(B4.ButtonPressed != 0){
		B4.ButtonPressed := 0
		turnoffBtn(4)
	}
	if(B5.ButtonPressed != 0){
		B5.ButtonPressed := 0
		turnoffBtn(5)
	}
	;if(B6.ButtonPressed != 0){
		;B6.ButtonPressed := 0
		;turnoffBtn(6)
	;}

	;아직 해야하나 잘 모르겠음
	;Gui, Show, NoActivate
}
return

icon_7:
{
	;GuiControl, , Debug, % B6.ButtonPressed

	if (B7.ButtonPressed = 0)
		GridYn := "_grid"
	else
		GridYn := ""

	GuiControl, , BGMap, %A_ScriptDir%\yulcroimgLVC\Map\Map_%Mapnow%%GridYn%.png

	;아직 해야하나 잘 모르겠음
	Gui, Show, NoActivate
}
return

turnoffBtn(num)
{
	if(num = 1){
		GuiControl, , icon_1, %A_ScriptDir%\yulcroimgLVC\Map\icons_feathers_0.png
	}
	if(num = 2){
		;GuiControl, , Debug, 22222
		GuiControl, , icon_2, %A_ScriptDir%\yulcroimgLVC\Map\icons_fish_0.png
	}
	if(num = 3){
		GuiControl, , icon_3, %A_ScriptDir%\yulcroimgLVC\Map\icons_plants_0.png
	}
	if(num = 4){
		GuiControl, , icon_4, %A_ScriptDir%\yulcroimgLVC\Map\icons_shops_0.png
	}
	if(num = 5){
		GuiControl, , icon_5, %A_ScriptDir%\yulcroimgLVC\Map\icons_monuments_0.png
	}
	if(num = 6){
		GuiControl, , icon_6, %A_ScriptDir%\yulcroimgLVC\Map\icons_area_0.png
	}
}
return