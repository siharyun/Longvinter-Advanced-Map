;==================================================================================
; 파일명 : ImageButton Effects.ahk
; 설명 : 이미지버튼 마우스 효과 추가 라이브러리
; 버전: v1.0
; 라이센스: CC BY-SA 3.0 (https://creativecommons.org/licenses/by-sa/3.0/deed.ko)
; 설치방법: #Include ImageButton Effects.ahk
; 제작자: https://catlab.tistory.com/ (fty816@gmail.com)
;==================================================================================


class ImageButtonChange
{
	;==================================================================================
	; 객체생성 :
	; Obj := new ImageButtonChange(Picutre 변수, 마우스 호버 후 이미지, [마우스 클릭 후 이미지])
	; 이미지교체 :
	; Obj.ReplaceImage(마우스 호버 전 이미지, 마우스 호버 후 이미지, [마우스 클릭 후 이미지])
	; 제거 :
	; Obj.Destroy()
	;==================================================================================

	static ButtonState := 0
	static ButtonPressed := 0

	__New(ButtonVar, HoverImage, PressImage:="")
	{
		this.HoverImage := HoverImage
		this.PressImage := PressImage

		GuiControlGet, OriPic, , % ButtonVar
		GuiControlGet, Buttonhwnd, Hwnd, % ButtonVar
		this.Buttonhwnd := Buttonhwnd, this.OriPic := OriPic

		this.MouseMovFunc := ObjBindMethod(this,"_GET_MOUSEMOV")
		this.LButtonDownFunc := ObjBindMethod(this,"_GET_LBDOWN")

		OnMessage(0x200, this.MouseMovFunc)
		OnMessage(0x201, this.LButtonDownFunc)
	}

	_GET_MOUSEMOV(wParam, lParam, msg, hwnd)
	{
		MouseGetPos,,,,controlhwnd ,2

		;안눌린버튼상태
		if (this.ButtonPressed = 0)
		{
			if (controlhwnd = this.Buttonhwnd && this.ButtonState = 0)
			{
				;GuiControl, , Debug, 버튼0마우스올림
				GuiControl,,% this.Buttonhwnd,% this.HoverImage
				this.ButtonState := 1
			}
			else if (controlhwnd != this.Buttonhwnd && this.ButtonState = 1)
			{
				;GuiControl, , Debug, 버튼0마우스벗어남
				GuiControl,,% this.Buttonhwnd,% this.OriPic
				this.ButtonState := 0
			}
		}
		;눌린버튼상태
		else if (this.ButtonPressed = 1)
		{
			if (controlhwnd = this.Buttonhwnd && this.ButtonState = 0)
			{
				;GuiControl, , Debug, 버튼1마우스올림
				GuiControl,,% this.Buttonhwnd,% this.HoverImage
				this.ButtonState := 1
			}
			else if (controlhwnd != this.Buttonhwnd && this.ButtonState = 1)
			{
				;GuiControl, , Debug, 버튼1마우스벗어남
				GuiControl,,% this.Buttonhwnd,% this.PressImage
				this.ButtonState := 0
			}
		}
	}

	_GET_LBDOWN(wParam, lParam, msg, hwnd)
	{
		if this.ButtonState && this.PressImage != ""
		{
			if (this.ButtonPressed = 0)
			{
				;GuiControl, , Debug, 버튼누름
				GuiControl,,% this.Buttonhwnd,% this.PressImage
				;KeyWait, LButton
				this.ButtonPressed := 1
				;GuiControl, , Debug, 버튼손뗌
			}
			else if (this.ButtonPressed = 1)
			{
				;GuiControl, , Debug, 버튼누름
				;KeyWait, LButton
				this.ButtonPressed := 0
				GuiControl,,% this.Buttonhwnd,% this.OriPic
				;GuiControl, , Debug, 버튼손뗌
			}
		}
	}

	ReplaceImage(ReplaceOriImage, ReplaceHoverImage, ReplacePressImage:="")
	{
		this.OriPic := ReplaceOriImage, this.HoverImage := ReplaceHoverImage, this.PressImage := ReplacePressImage
		GuiControl,,% this.Buttonhwnd,% this.OriPic
	}

	__Delete()
	{
		this.Destroy()
	}

	Destroy()
	{
		GuiControl,,% this.Buttonhwnd,% this.OriPic
		OnMessage(0x200, this.MouseMovFunc, 0)
		OnMessage(0x201, this.LButtonDownFunc, 0)
	}
}