#MaxThreadsPerHotkey 3  ; 한번에 세 개의 스레드를 사용할 수 있도록 설정
#include <Vis2>  ; Equivalent to #include .\lib\Vis2.ahk
#SingleInstance force

#Include ImageButton Effects.ahk
#Include ImageButton Effects_항구용수정본.ahk
;#Include ImageButton Effects2.ahk
;#Include Gdip.ahk
;#Include Gdip_All.ahk


;이미지파일저장할 폴더 만들기
FileCreateDir, %A_ScriptDir%/yulcroimgLVC/
FileCreateDir, %A_ScriptDir%/yulcroimgLVC/MAP
FileCreateDir, %A_ScriptDir%/yulcroimgLVC/MAP/ports
FileCreateDir, %A_ScriptDir%/bin

;이미지인스톨(파일따로뺌)
#Include 이미지인스톨.ahk
#Include %A_ScriptDir%/lib/Gdip_All.ahk
#Include %A_ScriptDir%/lib/ImagePut.ahk
#Include %A_ScriptDir%/lib/JSON.ahk
#Include %A_ScriptDir%/lib/Vis2.ahk

;생성한 이미지폴더 숨김처리
FileSetAttrib, +H, %A_ScriptDir%\yulcroimgLVC, 1, 1
FileSetAttrib, +H, %A_ScriptDir%\bin, 1, 1
FileSetAttrib, +H, %A_ScriptDir%\lib, 1, 1



;글로벌 변수 선언

;그리드 있을시 _grid, 없을 시 빈문자열
global GridYn := "_grid"
global Mapnow := 0
global MapOn := true

global latiCode	;위도코드(N or S)
global latiNum	;위도숫자
global longCode	;경도코드(E or W)
global longNum	;경도숫자

global searchAirdrop := false
global searchMe := 0			;본인위치 찾기 10초이상 못찾으면 Hide

global AirdropCountOn := false
global AirCount := 0
global AirCount_m
global AirCount_s

;현재위치 감지 직접셋팅하는 위치
global coordLocX = ""
global coordLocY = ""
global coordLocW = ""
global coordLocH = ""

;언어설정 en(default), ko
global lang = "en"

;ini파일 셋팅값 가져오기
IniRead, keySet, Advanced Map Settings.ini, Setting, MapOnOff, F1
IniRead, coordLocX, Advanced Map Settings.ini, Setting, SCX, NULL
IniRead, coordLocY, Advanced Map Settings.ini, Setting, SCY, NULL
IniRead, coordLocW, Advanced Map Settings.ini, Setting, SCW, NULL
IniRead, coordLocH, Advanced Map Settings.ini, Setting, SCH, NULL

settimer, Timer, 1000 ; Timer란 서브루틴을 1초마다 호출

;keySet = F1  ; Ctrl+Shift+T 핫키를 변수에 저장합니다.
Hotkey, %keySet%, ToggleMap	; 변수에 저장된 핫키를 사용하여 함수를 호출합니다.


Gui, Add, Picture, x0 y0 w1050 h857 vBGMap, %A_ScriptDir%\yulcroimgLVC\Map\Map_0%GridYn%.png

;프로그램 이름
Gui, Font, S10 C694642 W600, Malgun Gothic
if(lang = "ko")
{	;한글
	Gui, Add, Text, x43 y10 +Left CD2E3FD BackgroundTrans, 롱빈터 고급지도 v1.0
}
else
{	;영어
	Gui, Add, Text, x43 y10 +Left CD2E3FD BackgroundTrans, Longvinter Advanced Map v1.0
}

;도움말버튼
Gui, Add, Picture, x15 y11 w18 h18 vHelpBtn gHelpBtn BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\btnInfo.png
;Gui, Add, Text, x30 y20 +Left CD2E3FD BackgroundTrans, F1: Map ON/OFF
;Gui, Add, Text, x30 y40 +Left CD2E3FD BackgroundTrans, F8: Settings

;Gui, Add, Text, x30 y60 w1000 vDebug +Left CD2E3FD BackgroundTrans, 디버그 ;디버그
;Gui, Add, Text, x30 y80 w1000 vDebug2 +Left CD2E3FD BackgroundTrans, 디버그 ;디버그

Gui, Add, Picture, x1000 y20 w30 h30 vExitBtn gExitBtn BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\close_button.png
Gui, Add, Picture, x960 y20 w30 h30 vMiniBtn gMiniBtn BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\minimize_button.png

;Gui, Add, Text, x30 y100 w35 h15 vAirTime +Center CDD3C3C BackgroundTrans, 00:00 ;에어드랍 타이머
Gui, Add, Text, x30 y100 w38 h16 vAirTime +Center CDD3C3C -Background, 00:00 ;에어드랍 타이머
;Gui, Color, DD3C3C 150 ;글씨배경색 지우기
GuiControl, Hide, AirTime

;맵 GUI 관련
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


Gui, Color, 6451DB 0 ;웹사이트맵배경색(바다색)
;Gui, Color, F0F0F0 0 ;글씨배경색 지우기


;Start - 항구관련-----------------------------------------------------

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

;End - 항구관련-----------------------------------------------------

Gui, +LastFound +OwnDialogs +AlwaysOnTop +ToolWindow +E0x20 ;항상맨위로 어쩌구여러개
Gui, -Caption  ; 제목 표시줄 제거


;Gui,Show, x435 y111 w1050 h857 NoActivate, Advanced Map
Gui,Show, xCenter yCenter w1050 h857 NoActivate, Advanced Map


;에어드랍 레드도트
Gui, Add, Picture, x500 y200 w10 h10 BackgroundTrans vDot_drop, %A_ScriptDir%\yulcroimgLVC\Dot_airdrop.png
GuiControl, Hide, Dot_drop

;에어드랍 블루도트
Gui, Add, Picture, x537 y425 w10 h10 BackgroundTrans vDot_me, %A_ScriptDir%\yulcroimgLVC\Dot_me.png
GuiControl, Hide, Dot_me

;도움말
Gui, Add, Picture, x0 y0 w1050 h857 vInfo BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\info_%lang%.png
GuiControl, Hide, Info
Gui, Add, Picture, x790 y210 w25 h25s vExitinfoBtn gExitinfoBtn BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\close_button.png
GuiControl, Hide, ExitinfoBtn
Gui, Font, S10 C7E6957 W600, Malgun Gothic
if(lang = "ko")
{	;한글
	Gui, Add, Text, x265 y245 +Left C7E6957  BackgroundTrans vinfoText, 1. 이 프로그램은 1920X1080 해상도 창 모드에 최적화되어 있습니다.`n   다른 설정에서는 오차범위가 늘어날 수 있습니다.`n   그 경우 F8을 눌러 위성 통신기의 위치를 재설정하세요.`n`n2. 지도를 켜고 끌 수 있는 단축키는 ' Advanced Map Settings.ini ' 파일에서`n   설정할 수 있습니다. 기본값은 F1입니다.`n`n3. 실시간 위치는 위성 통신기를 장착한 경우에만 작동합니다.`n   만약 위치를 볼 수 없는 경우, 장착 해제 후 다시 장착해보세요.`n`n4. 에어드랍 위치는 에어드랍 알림이 켜진 상태에서 지도를 켜야만 작동합니다.`n   위치가 스캔되면 저장되어 지도를 껏다켜도 유지됩니다.`n`n5. 이 지도들은 vintermap.co를 기반으로 하여 업데이트되었습니다.`n`n6. 이 프로그램은 완벽하지 않습니다.`n   표시된 정보가 정확하지 않을 수 있으니 참고 바랍니다. ;`n`n`nCreated by Siharyun`nDesign assistance by Ragnarok`nDiscord inquiries: siharyun#6555
	Gui, Font, S10 C746452 W600, Segoe UI
	Gui, Add, Text, x265 y550 +Left  BackgroundTrans vinfoText2, 제작자 시하륜`n디자인 도움 Ragnarok`n디스코드 문의 : siharyun
}
else
{	;영어
	Gui, Add, Text, x265 y245 +Left C7E6957  BackgroundTrans vinfoText, 1. This program is optimized for the 1920X1080 resolution window mode.`n   Error range may increase in other settings.`n   In that case, press F8 to reposition the satellite communicator.`n`n2. The hotkey for turning the map on and off can be set in the`n   'Advanced Map Settings.ini' file. The default is F1.`n`n3. Real-time location only works if you have your communicator equipped.`n   If you cannot see it, try unequipping and equipping it again.`n`n4. Airdrop Location only works if you turn on the map while the airdrop`n   alert is on. Once the location is scanned, it will be saved and remain`n   even if you turn off and on the map.`n`n5. These maps are based on vintermap.co and are updated regularly.`n`n6. This program is not perfect. Please note that the displayed information`n   may not be entirely accurate. ;`n`n`nCreated by Siharyun`nDesign assistance by Ragnarok`nDiscord inquiries: siharyun#6555
	Gui, Font, S10 C746452 W600, Segoe UI
	Gui, Add, Text, x265 y565 +Left  BackgroundTrans vinfoText2, Created by Siharyun`nDesign assistance by Ragnarok`nDiscord inquiries: siharyun
}

GuiControl, Hide, infoText
GuiControl, Hide, infoText2
return


;맵버튼인스톨(파일따로뺌)
#Include 버튼함수정리.ahk


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
	;배포시 이거주석풀어야함
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
		;초마다 반복을 위해 함수로 뺌
		Gui, Show, NoActivate
		Getpointset()
	}
}
return

;프로그램 테스트용
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
	GuiControl, Move, Dot_drop, x%MoveDropX% y%MoveDropY%	;점 이동

	AirdropCountOn := true
	AirCount := 60

	GuiControl, Show, AirTime
	GuiControl, Move, AirTime, x%MoveTimerX% y%MoveTimerY%	;타이머 이동

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
	{	;한글
		global tr := Vis2.Graphics.Subtitle.Render("위성통신기의 좌표 표시 영역을 지정하세요!", "time: 30000 xCenter y92% p1.35% cFFB1AC r8", "c000000 s2.23%")
	}
	else
	{	;영어
		global tr := Vis2.Graphics.Subtitle.Render("Please specify the coordinates for the satellite communication device display area.", "time: 30000 xCenter y92% p1.35% cFFB1AC r8", "c000000 s2.23%")
	}

	;#Persistent
	Vis2.core.ux.start()
	;MsgBox, 0, info, X:%coordLocX% Y:%coordLocY% W:%coordLocW% H:%coordLocH%

}
return

;이거는 Vis2안에서 드래그 끝나면 실행되게 해놨음
F8finish()
{
	;화면에 텍스트 삭제
	tr.Destroy()

	coordLocW := coordLocW - coordLocX
	coordLocH := coordLocH - coordLocY

	if (coordLocW < 0 || coordLocH < 0)
	{
		if(lang = "ko")
		{	;한글
			MsgBox, 좌표 지정이 정상적으로 완료되지 않았습니다! 왼쪽 위에서 부터 오른쪽 아래쪽으로 선택해주세요.
		}
		else
		{	;영어
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
		{	;한글
			MsgBox, 0, 성공적, 저장완료!, 0.5
		}
		else
		{	;영어
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

	;에어드랍 위치 확인

	latiCode := ""	;위도코드(N or S)
	latiNum	:= ""	;위도숫자
	longCode := ""	;경도코드(E or W)
	longNum	:= ""	;경도숫자

	;ImageSearch, FoundX, FoundY, 20, 50, 100, 100, *100 %A_ScriptDir%\yulcroimgLVC\search_airdrop.bmp
	if (AirCount <= 0 || searchAirdrop = true)
	{
		searchAirdrop := false

		;GuiControl, , Debug, 에어드랍있음

		;에어드랍 좌표 인식을 위한 스캔위치설정
		/* 동작하던거
		topLeftX := AirFoundX + 150
		topLeftY := AirFoundY - 13
		widthToScan := 115
		heightToScan := 24
		*/

		;해상도별 호환을 위한 위치 지정
		topLeftX := Round(A_ScreenWidth * 0.045)
		topLeftY := Round(A_ScreenHeight * 0.056)
		widthToScan := Round(A_ScreenWidth * 0.120)
		heightToScan := Round(A_ScreenHeight * 0.050)

		;GuiControl, , Debug, AirFoundX : %AirFoundX% / AirFoundY : %AirFoundY% / topLeftX : %topLeftX% / topLeftY : %topLeftY% /
		;MouseMove, topLeftX, topLeftY


		CoordNow := OCR([topLeftX, topLeftY, widthToScan, heightToScan])
		;CoordNow := "13°S / 8°E"
		;GuiControl, , Debug2, %AirCount%
		GuiControl, , Debug, %CoordNow%


		;에어드랍없을시 진행X
		if (InStr(CoordNow, "°S") || InStr(CoordNow, "°N"))
		{
		/*
			;클립보드 저장용
			capinfo := % topLeftX "|" topLeftY "|" widthToScan "|" heightToScan

			Gdip := Gdip_Startup()
			hBitmap := Gdip_BitmapFromScreen(capinfo)
			;이미지저장추가
			Gdip_SaveBitmapToFile(hBitmap, A_ScriptDir "\Airdrop_capture.png")
			GuiControl, , Debug2, 에어드랍 캡쳐이미지 저장!
			;Gdip_SetBitmapToClipboard(hBitmap)
			Gdip_DisposeImage(hBitmap)
			Gdip_Shutdown(Gdip)
		*/
			;OCR한 문자열에서 좌표숫자와 NWES분리진행
			SubCoord(CoordNow)
			;GuiControl, , Debug, latiCode = %latiCode% / latiNum = %latiNum% / longCode = %longCode% / longNum = %longNum%

			;분리된 좌표를 이용해서 점 위치 이동
			MoveDrop := CalcPixel()

			MoveDropX := MoveDrop[1]
			MoveDropY := MoveDrop[2]
			MoveTimerX := MoveDropX-14
			MoveTimerY := MoveDropY-20

			;GuiControl, , Debug, X = %MoveDropX% / Y = %MoveDropY%
			;GuiControl, , Debug, MoveMeX : %MoveMeX% / MoveMeY : %MoveMeY%

			;GuiControl, Show, Dot_drop
			;GuiControl, Move, Dot_drop, x%MoveDropX% y%MoveDropY%	;점 이동
			;점 추가(이동이 아닌 추가)
			Gui, Add, Picture, x%MoveDropX% y%MoveDropY% w10 h10 BackgroundTrans, %A_ScriptDir%\yulcroimgLVC\Dot_airdrop.png

			AirdropCountOn := true
			AirCount := 600

			GuiControl, Show, AirTime
			GuiControl, Move, AirTime, x%MoveTimerX% y%MoveTimerY%	;타이머 이동

			/* ;클립보드 저장용
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

	;현재위치확인

	;해상도별 호환을 위한 위치 지정

	;커스텀위치
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

	;현재위치 텍스트 못찾으면 진행X
	if (InStr(CoordNow, "°"))
	{
		;현재위치 찾으면 초기화
		searchMe := 0

		;OCR한 문자열에서 좌표숫자와 NWES분리진행
		GuiControl, , Debug, %CoordNow%
		SubCoord(CoordNow)
		GuiControl, , Debug2, latiCode = %latiCode% / latiNum = %latiNum% / longCode = %longCode% / longNum = %longNum%

		;분리된 좌표를 이용해서 점 위치 이동
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

		;캡쳐영역확인용 클립보드저장
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
		;위성통신기 미장착
		;GuiControl, , Debug, 위성통신기없음
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
	;x355 y354 = 그 사이간격
	;x184 y70  = -64, -64
	;x353 y355 = 그 사이간격

	;좌표 1당 옮겨질 픽셀
	standardX := 5.546875
	standardY := 5.53125

	;계산된 X, Y좌표로 이동
	;MoveMeX := 184
	;MoveMeY := 70

	;현재 좌표 계산
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

;46°N / S°W
SubCoord(CoordNow)
{
	;좌표변수 나누기 진행

	;latiCode = 위도코드(N or S)
	;latiNum = 위도숫자
	;longCode = 경도코드(E or W)
	;longNum = 경도숫자

	;N좌표인지 S인지 먼저 확인
	position := InStr(CoordNow, "°N")
	GuiControl, , Debug2, %position%
	if (position > 0)
		latiCode := "N"
	else {
		position := InStr(CoordNow, "°S")
		if (position > 0)
			latiCode := "S"
		else {
			;N과 S를 둘다 못찾은경우(재검색)
		}
	}
	;GuiControl, , Debug2, % SubStr(CoordNow, position-2, 1)
	;숫자여부 체크(10자리수인지 한자리수인지 체크)
	if (RegExMatch(SubStr(CoordNow, position-2, 1), "^\d+$"))
		latiNum := SubStr(CoordNow, position-2, 2)
	else
		latiNum := SubStr(CoordNow, position-1, 1)

	;GuiControl, , Debug, %CoordNow%


	;E좌표인지 W인지 확인진행
	;/기준으로 먼저 잘라서 뒤쪽 좌표만 남김
	position := InStr(CoordNow, "/")

	CoordNow := SubStr(CoordNow, position + 1, StrLen(CoordNow)-position)

	;5°W 좌표 버그 예외처리
	if (InStr(CoordNow, "S°W"))
	{
		longCode := "W"
		longNum := 5
	}
	else
	{
		;E좌표인지 W인지 확인
		position := InStr(CoordNow, "°E") + InStr(CoordNow, "°F")
		if (position > 0) {
			longCode := "E"
			GuiControl, , Debug2, %position%
		}
		else {
			position := InStr(CoordNow, "°W")
			if (position > 0) {
				longCode := "W"
				;GuiControl, , Debug, %position%
			} else {
				;E와 W를 둘다 못찾은경우(재검색)
			}
		}

		if (RegExMatch(SubStr(CoordNow, position-2, 1), "^\d+$"))
			longNum := SubStr(CoordNow, position-2, 2)
		else if (RegExMatch(SubStr(CoordNow, position-1, 1), "^\d+$"))
			longNum := SubStr(CoordNow, position-1, 1)

		if (InStr(CoordNow, "104°E"))
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
	;관련변수
	;AirdropCountOn := false
	;AirCount		전체시간(초단위)
	;AirCount_m		분단위
	;AirCount_s		초단위
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
		;GuiControl, , Debug, 맵열림
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


