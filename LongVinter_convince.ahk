#MaxThreadsPerHotkey 3  ; �ѹ��� �� ���� �����带 ����� �� �ֵ��� ����
#include <Vis2>  ; Equivalent to #include .\lib\Vis2.ahk
#SingleInstance force

#Include ImageButton Effects.ahk
#Include ImageButton Effects_�ױ��������.ahk
;#Include ImageButton Effects2.ahk
;#Include Gdip.ahk
;#Include Gdip_All.ahk


;�̹������������� ���� �����
FileCreateDir, %A_ScriptDir%/yulcroimgLVC/
FileCreateDir, %A_ScriptDir%/yulcroimgLVC/MAP
FileCreateDir, %A_ScriptDir%/yulcroimgLVC/MAP/ports
FileCreateDir, %A_ScriptDir%/bin

;�̹����ν���(���ϵ��λ�)
#Include �̹����ν���.ahk
#Include %A_ScriptDir%/lib/Gdip_All.ahk
#Include %A_ScriptDir%/lib/ImagePut.ahk
#Include %A_ScriptDir%/lib/JSON.ahk
#Include %A_ScriptDir%/lib/Vis2.ahk

;������ �̹������� ����ó��
FileSetAttrib, +H, %A_ScriptDir%\yulcroimgLVC, 1, 1
FileSetAttrib, +H, %A_ScriptDir%\bin, 1, 1
FileSetAttrib, +H, %A_ScriptDir%\lib, 1, 1



;�۷ι� ���� ����

;�׸��� ������ _grid, ���� �� ���ڿ�
global GridYn := "_grid"
global Mapnow := 0
global MapOn := true

global latiCode	;�����ڵ�(N or S)
global latiNum	;��������
global longCode	;�浵�ڵ�(E or W)
global longNum	;�浵����

global searchAirdrop := false
global searchMe := 0			;������ġ ã�� 10���̻� ��ã���� Hide

global AirdropCountOn := false
global AirCount := 0
global AirCount_m
global AirCount_s

;������ġ ���� ���������ϴ� ��ġ
global coordLocX = ""
global coordLocY = ""
global coordLocW = ""
global coordLocH = ""

;���� en(default), ko
global lang = "en"

;ini���� ���ð� ��������
IniRead, keySet, Advanced Map Settings.ini, Setting, MapOnOff, F1
IniRead, coordLocX, Advanced Map Settings.ini, Setting, SCX, NULL
IniRead, coordLocY, Advanced Map Settings.ini, Setting, SCY, NULL
IniRead, coordLocW, Advanced Map Settings.ini, Setting, SCW, NULL
IniRead, coordLocH, Advanced Map Settings.ini, Setting, SCH, NULL

settimer, Timer, 1000 ; Timer�� �����ƾ�� 1�ʸ��� ȣ��

;keySet = F1  ; Ctrl+Shift+T ��Ű�� ������ �����մϴ�.
Hotkey, %keySet%, ToggleMap	; ������ ����� ��Ű�� ����Ͽ� �Լ��� ȣ���մϴ�.


Gui, Add, Picture, x0 y0 w1050 h857 vBGMap, %A_ScriptDir%\yulcroimgLVC\Map\Map_0%GridYn%.png

;���α׷� �̸�
Gui, Font, S10 C694642 W600, Malgun Gothic
if(lang = "ko")
{	;�ѱ�
	Gui, Add, Text, x43 y10 +Left CD2E3FD BackgroundTrans, �պ��� ������� v1.0
}
else
{	;����
	Gui, Add, Text, x43 y10 +Left CD2E3FD BackgroundTrans, Longvinter Advanced Map v1.0
}

;���򸻹�ư
Gui, Add, Picture, x15 y11 w18 h18 vHelpBtn gHelpBtn BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\btnInfo.png
;Gui, Add, Text, x30 y20 +Left CD2E3FD BackgroundTrans, F1: Map ON/OFF
;Gui, Add, Text, x30 y40 +Left CD2E3FD BackgroundTrans, F8: Settings

;Gui, Add, Text, x30 y60 w1000 vDebug +Left CD2E3FD BackgroundTrans, ����� ;�����
;Gui, Add, Text, x30 y80 w1000 vDebug2 +Left CD2E3FD BackgroundTrans, ����� ;�����

Gui, Add, Picture, x1000 y20 w30 h30 vExitBtn gExitBtn BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\close_button.png
Gui, Add, Picture, x960 y20 w30 h30 vMiniBtn gMiniBtn BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\minimize_button.png

;Gui, Add, Text, x30 y100 w35 h15 vAirTime +Center CDD3C3C BackgroundTrans, 00:00 ;������ Ÿ�̸�
Gui, Add, Text, x30 y100 w38 h16 vAirTime +Center CDD3C3C -Background, 00:00 ;������ Ÿ�̸�
;Gui, Color, DD3C3C 150 ;�۾����� �����
GuiControl, Hide, AirTime

;�� GUI ����
;Gui, Add, Picture, x600 y730 w50 h50 vicon_0 gicon_0 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\icons_ports_0.png
Gui, Add, Picture, x540 y730 w50 h50 vicon_1 gicon_1 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\icons_feathers_0.png
Gui, Add, Picture, x600 y730 w50 h50 vicon_2 gicon_2 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\icons_fish_0.png
Gui, Add, Picture, x660 y730 w50 h50 vicon_3 gicon_3 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\icons_plants_0.png
Gui, Add, Picture, x720 y730 w50 h50 vicon_4 gicon_4 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\icons_shops_0.png
Gui, Add, Picture, x780 y730 w50 h50 vicon_5 gicon_5 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\icons_monuments_0.png
Gui, Add, Picture, x840 y730 w50 h50 vicon_6 gicon_6 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\icons_area_0.png
Gui, Add, Picture, x900 y730 w50 h50 vicon_7 gicon_7 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\icons_grid_2.png


;B0 := new ImageButtonChange("icon_0", "yulcroimgLVC\Map\icons_ports_1.png", "yulcroimgLVC\Map\icons_ports_2.png")
B1 := new ImageButtonChange("icon_1", "yulcroimgLVC\Map\icons_feathers_1.png", "yulcroimgLVC\Map\icons_feathers_2.png")
B2 := new ImageButtonChange("icon_2", "yulcroimgLVC\Map\icons_fish_1.png", "yulcroimgLVC\Map\icons_fish_2.png")
B3 := new ImageButtonChange("icon_3", "yulcroimgLVC\Map\icons_plants_1.png", "yulcroimgLVC\Map\icons_plants_2.png")
B4 := new ImageButtonChange("icon_4", "yulcroimgLVC\Map\icons_shops_1.png", "yulcroimgLVC\Map\icons_shops_2.png")
B5 := new ImageButtonChange("icon_5", "yulcroimgLVC\Map\icons_monuments_1.png", "yulcroimgLVC\Map\icons_monuments_2.png")
B6 := new ImageButtonChange("icon_6", "yulcroimgLVC\Map\icons_area_1.png", "yulcroimgLVC\Map\icons_area_2.png")
B7 := new ImageButtonChange("icon_7", "yulcroimgLVC\Map\icons_grid_1.png", "yulcroimgLVC\Map\icons_grid_0.png")


Gui, Color, 6451DB 0 ;������Ʈ�ʹ���(�ٴٻ�)
;Gui, Color, F0F0F0 0 ;�۾����� �����


;Start - �ױ�����-----------------------------------------------------

;num := "1"
;CoordNow := "3 N / 25 W"

;626, 563
;x-5 y-15
Gui, Add, Picture, x621 y548 w25 h30 vport_1 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x326 y470 w25 h30 vport_2 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x676 y492 w25 h30 vport_3 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x680 y398 w25 h30 vport_4 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x714 y592 w25 h30 vport_5 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x397 y512 w25 h30 vport_6 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x398 y475 w25 h30 vport_7 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x681 y360 w25 h30 vport_8 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x543 y249 w25 h30 vport_9 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x82 y730 w25 h30 vport_10 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x243 y470 w25 h30 vport_11 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x698 y537 w25 h30 vport_12 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x498 y487 w25 h30 vport_13 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x576 y360 w25 h30 vport_14 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x543 y548 w25 h30 vport_15 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png
Gui, Add, Picture, x393 y393 w25 h30 vport_16 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port.png




;x+25 y-8
Gui, Add, Picture, x646 y540 w147 h48 vportname_1 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_artur.png
Gui, Add, Picture, x351 y462 w147 h48 vportname_2 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_diogo.png
Gui, Add, Picture, x701 y484 w147 h48 vportname_3 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_filemon.png
Gui, Add, Picture, x705 y390 w147 h48 vportname_4 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_heimo.png
Gui, Add, Picture, x739 y584 w147 h48 vportname_5 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_heisala.png
Gui, Add, Picture, x422 y504 w147 h48 vportname_6 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_henry.png
Gui, Add, Picture, x423 y467 w147 h48 vportname_7 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_jax.png
Gui, Add, Picture, x706 y352 w147 h48 vportname_8 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_koilot.png
Gui, Add, Picture, x568 y241 w147 h48 vportname_9 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_kyrres.png
Gui, Add, Picture, x107 y722 w147 h48 vportname_10 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_lighthouse.png
Gui, Add, Picture, x268 y462 w147 h48 vportname_11 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_padva.png
Gui, Add, Picture, x723 y529 w147 h48 vportname_12 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_pix.png
Gui, Add, Picture, x523 y479 w147 h48 vportname_13 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_sgt.png
Gui, Add, Picture, x601 y352 w147 h48 vportname_14 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_sirola.png
Gui, Add, Picture, x568 y540 w147 h48 vportname_15 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_snow.png
Gui, Add, Picture, x418 y385 w147 h48 vportname_16 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Map\ports\port_tim.png

Loop 16
{
	GuiControl, Hide, portname_%A_Index%
	P%A_Index% := new ImageButtonAdd_hover("port_" . A_Index, "", "portname_" . A_Index)
}

;End - �ױ�����-----------------------------------------------------

Gui, +LastFound +OwnDialogs +AlwaysOnTop +ToolWindow +E0x20 ;�׻������ ��¼��������
Gui, -Caption  ; ���� ǥ���� ����


;Gui,Show, x435 y111 w1050 h857 NoActivate, Advanced Map
Gui,Show, xCenter yCenter w1050 h857 NoActivate, Advanced Map


;������ ���嵵Ʈ
Gui, Add, Picture, x500 y200 w10 h10 BackgroundTrans vDot_drop, %A_ScriptDir%\yulcroimgLVC\Dot_airdrop.png
GuiControl, Hide, Dot_drop

;������ ��絵Ʈ
Gui, Add, Picture, x537 y425 w10 h10 BackgroundTrans vDot_me, %A_ScriptDir%\yulcroimgLVC\Dot_me.png
GuiControl, Hide, Dot_me

;����
Gui, Add, Picture, x0 y0 w1050 h857 vInfo BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\info_%lang%.png
GuiControl, Hide, Info
Gui, Add, Picture, x790 y210 w25 h25s vExitinfoBtn gExitinfoBtn BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\close_button.png
GuiControl, Hide, ExitinfoBtn
Gui, Font, S10 C7E6957 W600, Malgun Gothic
if(lang = "ko")
{	;�ѱ�
	Gui, Add, Text, x265 y245 +Left C7E6957  BackgroundTrans vinfoText, 1. �� ���α׷��� 1920X1080 �ػ� â ��忡 ����ȭ�Ǿ� �ֽ��ϴ�.`n   �ٸ� ���������� ���������� �þ �� �ֽ��ϴ�.`n   �� ��� F8�� ���� ���� ��ű��� ��ġ�� �缳���ϼ���.`n`n2. ������ �Ѱ� �� �� �ִ� ����Ű�� ' Advanced Map Settings.ini ' ���Ͽ���`n   ������ �� �ֽ��ϴ�. �⺻���� F1�Դϴ�.`n`n3. �ǽð� ��ġ�� ���� ��ű⸦ ������ ��쿡�� �۵��մϴ�.`n   ���� ��ġ�� �� �� ���� ���, ���� ���� �� �ٽ� �����غ�����.`n`n4. ������ ��ġ�� ������ �˸��� ���� ���¿��� ������ �Ѿ߸� �۵��մϴ�.`n   ��ġ�� ��ĵ�Ǹ� ����Ǿ� ������ �����ѵ� �����˴ϴ�.`n`n5. �� �������� vintermap.co�� ������� �Ͽ� ������Ʈ�Ǿ����ϴ�.`n`n6. �� ���α׷��� �Ϻ����� �ʽ��ϴ�.`n   ǥ�õ� ������ ��Ȯ���� ���� �� ������ ���� �ٶ��ϴ�. ;`n`n`nCreated by Siharyun`nDesign assistance by Ragnarok`nDiscord inquiries: siharyun#6555
	Gui, Font, S10 C746452 W600, Segoe UI
	Gui, Add, Text, x265 y550 +Left  BackgroundTrans vinfoText2, ������ ���Ϸ�`n������ ���� Ragnarok`n���ڵ� ���� : siharyun
}
else
{	;����
	Gui, Add, Text, x265 y245 +Left C7E6957  BackgroundTrans vinfoText, 1. This program is optimized for the 1920X1080 resolution window mode.`n   Error range may increase in other settings.`n   In that case, press F8 to reposition the satellite communicator.`n`n2. The hotkey for turning the map on and off can be set in the`n   'Advanced Map Settings.ini' file. The default is F1.`n`n3. Real-time location only works if you have your communicator equipped.`n   If you cannot see it, try unequipping and equipping it again.`n`n4. Airdrop Location only works if you turn on the map while the airdrop`n   alert is on. Once the location is scanned, it will be saved and remain`n   even if you turn off and on the map.`n`n5. These maps are based on vintermap.co and are updated regularly.`n`n6. This program is not perfect. Please note that the displayed information`n   may not be entirely accurate. ;`n`n`nCreated by Siharyun`nDesign assistance by Ragnarok`nDiscord inquiries: siharyun#6555
	Gui, Font, S10 C746452 W600, Segoe UI
	Gui, Add, Text, x265 y565 +Left  BackgroundTrans vinfoText2, Created by Siharyun`nDesign assistance by Ragnarok`nDiscord inquiries: siharyun
}

GuiControl, Hide, infoText
GuiControl, Hide, infoText2
return


;�ʹ�ư�ν���(���ϵ��λ�)
#Include ��ư�Լ�����.ahk


HelpBtn:
{
	GuiControl, Show, Info
	GuiControl, Show, ExitinfoBtn
	GuiControl, Show, infoText
	GuiControl, Show, infoText2
}
return

ExitinfoBtn:
{
	GuiControl, Hide, Info
	GuiControl, Hide, ExitinfoBtn
	GuiControl, Hide, infoText
	GuiControl, Hide, infoText2
}
return


MiniBtn:
{
	if(WinExist("Advanced Map")){
		Gui,Hide
	}
}
return


ExitBtn:
{
	;������ �̰��ּ�Ǯ�����
	;FileRemoveDir, %A_ScriptDir%\yulcroimgLVC, 1
	;FileRemoveDir, %A_ScriptDir%\bin, 1
	ExitApp
}
return

ToggleMap:
{
	if(WinExist("Advanced Map")){
		Gui, Hide
		;Gui, Show, NoActivate
		;MsgBox, adsf, asdf
	}
	else
	{
		;�ʸ��� �ݺ��� ���� �Լ��� ��
		Gui, Show, NoActivate
		Getpointset()
	}
}
return

;���α׷� �׽�Ʈ��
/*
F2::
{
	Reload
}
return


F3::
{
	;Gui, Add, Picture, x0 y0 w1050 h857, %A_ScriptDir%\yulcroimgLVC\Map\Map_2fish%GridYn%.png
	;Gui, Show, NoActivate
	;GuiControl, , Debug, % B6.ButtonPressed

	;AirdropCountOn := true
	;AirCount := 100

	;GuiControl, Show, Dot_drop
	;GuiControl, Move, Dot_drop, x100 y200


	MoveDropX := 180
	MoveDropY := 220
	MoveTimerX := MoveDropX-14
	MoveTimerY := MoveDropY-20

	;GuiControl, , Debug, MoveMeX : %MoveMeX% / MoveMeY : %MoveMeY%
	GuiControl, Show, Dot_drop
	GuiControl, Move, Dot_drop, x%MoveDropX% y%MoveDropY%	;�� �̵�

	AirdropCountOn := true
	AirCount := 60

	GuiControl, Show, AirTime
	GuiControl, Move, AirTime, x%MoveTimerX% y%MoveTimerY%	;Ÿ�̸� �̵�

}
return
*/

/*
F9::
{
	MsgBox, 0, info, X:%coordLocX% Y:%coordLocY% W:%coordLocW% H:%coordLocH%
}
return
*/

F8::
{
	coordLocX := ""
	coordLocY := ""
	coordLocW := ""
	coordLocH := ""

	if(WinExist("Advanced Map")){
		Gui,Hide
	}

	if(lang = "ko")
	{	;�ѱ�
		global tr := Vis2.Graphics.Subtitle.Render("������ű��� ��ǥ ǥ�� ������ �����ϼ���!", "time: 30000 xCenter y92% p1.35% cFFB1AC r8", "c000000 s2.23%")
	}
	else
	{	;����
		global tr := Vis2.Graphics.Subtitle.Render("Please specify the coordinates for the satellite communication device display area.", "time: 30000 xCenter y92% p1.35% cFFB1AC r8", "c000000 s2.23%")
	}

	;#Persistent
	Vis2.core.ux.start()
	;MsgBox, 0, info, X:%coordLocX% Y:%coordLocY% W:%coordLocW% H:%coordLocH%

}
return

;�̰Ŵ� Vis2�ȿ��� �巡�� ������ ����ǰ� �س���
F8finish()
{
	;ȭ�鿡 �ؽ�Ʈ ����
	tr.Destroy()

	coordLocW := coordLocW - coordLocX
	coordLocH := coordLocH - coordLocY

	if (coordLocW < 0 || coordLocH < 0)
	{
		if(lang = "ko")
		{	;�ѱ�
			MsgBox, ��ǥ ������ ���������� �Ϸ���� �ʾҽ��ϴ�! ���� ������ ���� ������ �Ʒ������� �������ּ���.
		}
		else
		{	;����
			MsgBox, The coordinate selection was not completed successfully. Please select from the top left to the bottom right.
		}
	}
	else
	{
		IniWrite, %coordLocX%, Advanced Map Settings.ini, Setting, SCX
		IniWrite, %coordLocY%, Advanced Map Settings.ini, Setting, SCY
		IniWrite, %coordLocW%, Advanced Map Settings.ini, Setting, SCW
		IniWrite, %coordLocH%, Advanced Map Settings.ini, Setting, SCH

		if(lang = "ko")
		{	;�ѱ�
			MsgBox, 0, ������, ����Ϸ�!, 0.5
		}
		else
		{	;����
			MsgBox, 0, successfully, saved!, 0.5
		}

	}
}
return

DrawRectangle(x, y, width, height, color)
{
    hdc := DllCall("GetDC", "ptr", 0)
    gdi := DllCall("CreatePen", "int", 0, "int", 1, "uint", color)
    old := DllCall("SelectObject", "ptr", hdc, "ptr", gdi)

    DllCall("Rectangle", "ptr", hdc, "int", x, "int", y, "int", x+width, "int", y+height)

	Sleep 500

	;DllCall("SelectObject", "ptr", hdc, "ptr", old)
    ;DllCall("DeleteObject", "ptr", gdi)
    ;DllCall("ReleaseDC", "ptr", 0, "ptr", hdc)
}
return

Getpointset()
{
	;CoordMode, Screen

	;������ ��ġ Ȯ��

	latiCode := ""	;�����ڵ�(N or S)
	latiNum	:= ""	;��������
	longCode := ""	;�浵�ڵ�(E or W)
	longNum	:= ""	;�浵����

	;ImageSearch, FoundX, FoundY, 20, 50, 100, 100, *100 %A_ScriptDir%\yulcroimgLVC\search_airdrop.bmp
	if (AirCount <= 0 || searchAirdrop = true)
	{
		searchAirdrop := false

		;GuiControl, , Debug, ����������

		;������ ��ǥ �ν��� ���� ��ĵ��ġ����
		/* �����ϴ���
		topLeftX := AirFoundX + 150
		topLeftY := AirFoundY - 13
		widthToScan := 115
		heightToScan := 24
		*/

		;�ػ󵵺� ȣȯ�� ���� ��ġ ����
		topLeftX := Round(A_ScreenWidth * 0.045)
		topLeftY := Round(A_ScreenHeight * 0.056)
		widthToScan := Round(A_ScreenWidth * 0.120)
		heightToScan := Round(A_ScreenHeight * 0.050)

		;GuiControl, , Debug, AirFoundX : %AirFoundX% / AirFoundY : %AirFoundY% / topLeftX : %topLeftX% / topLeftY : %topLeftY% /
		;MouseMove, topLeftX, topLeftY


		CoordNow := OCR([topLeftX, topLeftY, widthToScan, heightToScan])
		;CoordNow := "13��S / 8��E"
		;GuiControl, , Debug2, %AirCount%
		GuiControl, , Debug, %CoordNow%


		;������������ ����X
		if (InStr(CoordNow, "��S") || InStr(CoordNow, "��N"))
		{
		/*
			;Ŭ������ �����
			capinfo := % topLeftX "|" topLeftY "|" widthToScan "|" heightToScan

			Gdip := Gdip_Startup()
			hBitmap := Gdip_BitmapFromScreen(capinfo)
			;�̹��������߰�
			Gdip_SaveBitmapToFile(hBitmap, A_ScriptDir "\Airdrop_capture.png")
			GuiControl, , Debug2, ������ ĸ���̹��� ����!
			;Gdip_SetBitmapToClipboard(hBitmap)
			Gdip_DisposeImage(hBitmap)
			Gdip_Shutdown(Gdip)
		*/
			;OCR�� ���ڿ����� ��ǥ���ڿ� NWES�и�����
			SubCoord(CoordNow)
			;GuiControl, , Debug, latiCode = %latiCode% / latiNum = %latiNum% / longCode = %longCode% / longNum = %longNum%

			;�и��� ��ǥ�� �̿��ؼ� �� ��ġ �̵�
			MoveDrop := CalcPixel()

			MoveDropX := MoveDrop[1]
			MoveDropY := MoveDrop[2]
			MoveTimerX := MoveDropX-14
			MoveTimerY := MoveDropY-20

			;GuiControl, , Debug, X = %MoveDropX% / Y = %MoveDropY%
			;GuiControl, , Debug, MoveMeX : %MoveMeX% / MoveMeY : %MoveMeY%

			;GuiControl, Show, Dot_drop
			;GuiControl, Move, Dot_drop, x%MoveDropX% y%MoveDropY%	;�� �̵�
			;�� �߰�(�̵��� �ƴ� �߰�)
			Gui, Add, Picture, x%MoveDropX% y%MoveDropY% w10 h10 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Dot_airdrop.png

			AirdropCountOn := true
			AirCount := 600

			GuiControl, Show, AirTime
			GuiControl, Move, AirTime, x%MoveTimerX% y%MoveTimerY%	;Ÿ�̸� �̵�

			/* ;Ŭ������ �����
			capinfo := % topLeftX "|" topLeftY "|" widthToScan "|" heightToScan
			;capinfo := % 20 "|" 0 "|" 200 "|" 200

			Gdip := Gdip_Startup()
			hBitmap := Gdip_BitmapFromScreen(capinfo)
			Gdip_SetBitmapToClipboard(hBitmap)
			Gdip_DisposeImage(hBitmap)
			Gdip_Shutdown(Gdip)
			*/
		}

	}
	else
	{
		;GuiControl, Hide, Dot_drop
	}

	;������ġȮ��

	;�ػ󵵺� ȣȯ�� ���� ��ġ ����

	;Ŀ������ġ
	if (coordLocX != "NULL")
	{
		topLeftX := coordLocX
		topLeftY := coordLocY
		widthToScan := coordLocW
		heightToScan := coordLocH
	}
	else
	{
		topLeftX := Round(A_ScreenWidth * 0.901)
		topLeftY := Round(A_ScreenHeight * 0.025)
		widthToScan := Round(A_ScreenWidth * 0.085)
		heightToScan := Round(A_ScreenHeight * 0.045)
	}

	CoordNow := OCR([topLeftX, topLeftY, widthToScan, heightToScan])

	;������ġ �ؽ�Ʈ ��ã���� ����X
	if (InStr(CoordNow, "��"))
	{
		;������ġ ã���� �ʱ�ȭ
		searchMe := 0

		;OCR�� ���ڿ����� ��ǥ���ڿ� NWES�и�����
		GuiControl, , Debug, %CoordNow%
		SubCoord(CoordNow)
		GuiControl, , Debug2, latiCode = %latiCode% / latiNum = %latiNum% / longCode = %longCode% / longNum = %longNum%

		;�и��� ��ǥ�� �̿��ؼ� �� ��ġ �̵�
		MoveMe := CalcPixel()

		MoveMeX := MoveMe[1]
		MoveMeY := MoveMe[2]

		;GuiControl, , Debug, MoveMeX : %MoveMeX% / MoveMeY : %MoveMeY%

		if (!(latiNum = "" || longNum = ""))
		{

			GuiControl, Move, Dot_me, x%MoveMeX% y%MoveMeY%
			GuiControl, Show, Dot_me
		}
		;Gui, Add, Picture, x%MoveMeX% y%MoveMeY% w10 h10 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Dot_airdrop.png


		;latiNum := GetOCR(topLeftX, topLeftY, widthToScan, heightToScan, numeral)

		;ĸ�Ŀ���Ȯ�ο� Ŭ����������
/*
		capinfo := % topLeftX "|" topLeftY "|" widthToScan "|" heightToScan

		Gdip := Gdip_Startup()
		hBitmap := Gdip_BitmapFromScreen(capinfo)
		Gdip_SetBitmapToClipboard(hBitmap)
		Gdip_DisposeImage(hBitmap)
		Gdip_Shutdown(Gdip)
*/
		;GuiControl, , Debug, %magicalText%
	}
	else
	{
		;������ű� ������
		;GuiControl, , Debug, ������ű����
		searchMe += 1

		if (searchMe > 5)
			GuiControl, Hide, Dot_me

	}

	/*
	capinfo := % 1700 "|" 0 "|" 220 "|" 100

	Gdip := Gdip_Startup()
	hBitmap := Gdip_BitmapFromScreen(capinfo)
	Gdip_SetBitmapToClipboard(hBitmap)
	Gdip_DisposeImage(hBitmap)
	Gdip_Shutdown(Gdip)
	*/

}
return


CalcPixel()
{
	;x537 y425 = 0, 0
	;x892 y779 = 64, 64
	;x355 y354 = �� ���̰���
	;x184 y70  = -64, -64
	;x353 y355 = �� ���̰���

	;��ǥ 1�� �Ű��� �ȼ�
	standardX := 5.546875
	standardY := 5.53125

	;���� X, Y��ǥ�� �̵�
	;MoveMeX := 184
	;MoveMeY := 70

	;���� ��ǥ ���
	if (latiCode = "N")
		MoveDotY := 425 - latiNum * standardY
	if (latiCode = "S")
		MoveDotY := 425 + latiNum * standardY
	if (longCode = "E")
		MoveDotX := 537 + longNum * standardX
	if (longCode = "W")
		MoveDotX := 537 - longNum * standardX

	;GuiControl, , Debug, %MoveDotX%

	return [MoveDotX, MoveDotY]
}
return

;46��N / S��W
SubCoord(CoordNow)
{
	;��ǥ���� ������ ����

	;latiCode = �����ڵ�(N or S)
	;latiNum = ��������
	;longCode = �浵�ڵ�(E or W)
	;longNum = �浵����

	;N��ǥ���� S���� ���� Ȯ��
	position := InStr(CoordNow, "��N")
	GuiControl, , Debug2, %position%
	if (position > 0)
		latiCode := "N"
	else {
		position := InStr(CoordNow, "��S")
		if (position > 0)
			latiCode := "S"
		else {
			;N�� S�� �Ѵ� ��ã�����(��˻�)
		}
	}
	;GuiControl, , Debug2, % SubStr(CoordNow, position-2, 1)
	;���ڿ��� üũ(10�ڸ������� ���ڸ������� üũ)
	if (RegExMatch(SubStr(CoordNow, position-2, 1), "^\d+$"))
		latiNum := SubStr(CoordNow, position-2, 2)
	else
		latiNum := SubStr(CoordNow, position-1, 1)

	;GuiControl, , Debug, %CoordNow%


	;E��ǥ���� W���� Ȯ������
	;/�������� ���� �߶� ���� ��ǥ�� ����
	position := InStr(CoordNow, "/")

	CoordNow := SubStr(CoordNow, position + 1, StrLen(CoordNow)-position)

	;5��W ��ǥ ���� ����ó��
	if (InStr(CoordNow, "S��W"))
	{
		longCode := "W"
		longNum := 5
	}
	else
	{
		;E��ǥ���� W���� Ȯ��
		position := InStr(CoordNow, "��E") + InStr(CoordNow, "��F")
		if (position > 0) {
			longCode := "E"
			GuiControl, , Debug2, %position%
		}
		else {
			position := InStr(CoordNow, "��W")
			if (position > 0) {
				longCode := "W"
				;GuiControl, , Debug, %position%
			} else {
				;E�� W�� �Ѵ� ��ã�����(��˻�)
			}
		}

		if (RegExMatch(SubStr(CoordNow, position-2, 1), "^\d+$"))
			longNum := SubStr(CoordNow, position-2, 2)
		else if (RegExMatch(SubStr(CoordNow, position-1, 1), "^\d+$"))
			longNum := SubStr(CoordNow, position-1, 1)

		if (InStr(CoordNow, "104��E"))
			longNum := 104

		/*
		if (position = 3)
			longNum := SubStr(CoordNow, position-1, 1)
		else if (position = 4)
			longNum := SubStr(CoordNow, position-2, 2)
		else if (position = 5)
			longNum := SubStr(CoordNow, position-3, 3)
		*/
	}
}
return


Timer:
{
	;���ú���
	;AirdropCountOn := false
	;AirCount		��ü�ð�(�ʴ���)
	;AirCount_m		�д���
	;AirCount_s		�ʴ���
	;AirTime		GUI name

	if(AirdropCountOn = true)
	{
		if(AirCount >= 0)
		{
			AirCount_m := Floor(AirCount / 60)
			AirCount_s := Mod(AirCount, 60)

			if(StrLen(AirCount_s) = 1)
				AirCount_s := "0" . AirCount_s

			GuiControl,, AirTime, %AirCount_m%:%AirCount_s%

			AirCount --
		}
	}

	if(WinExist("Advanced Map")){
		;GuiControl, , Debug, �ʿ���
		WinGetTitle,Mapopen,A
		if(!(Mapopen = "Advanced Map"))
		{
			Getpointset()
			;GuiControl, , Debug, %Mapopen%
		}
	}
	;GuiControl, , Debug2, %AirCount%
}
return


