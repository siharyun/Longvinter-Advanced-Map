;==================================================================================
; 파일명 : ImageButton Effects.ahk
; 설명 : 이미지버튼 마우스 효과 추가 라이브러리
; 버전: v1.0
; 라이센스: CC BY-SA 3.0 (https://creativecommons.org/licenses/by-sa/3.0/deed.ko)
; 설치방법: #Include ImageButton Effects.ahk
; 제작자: https://catlab.tistory.com/ (fty816@gmail.com)
;==================================================================================


class ImageButtonAdd_hover
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

	__New(ButtonVar, HoverImage, NameImage:="")
	{
		this.HoverImage := HoverImage
		this.NameImage := NameImage

		GuiControlGet, OriPic, , % ButtonVar
		GuiControlGet, Buttonhwnd, Hwnd, % ButtonVar

		this.Buttonhwnd := Buttonhwnd, this.OriPic := OriPic
		this.MouseMovFunc := ObjBindMethod(this,"_GET_MOUSEMOV")

		OnMessage(0x200, this.MouseMovFunc)
	}

	_GET_MOUSEMOV(wParam, lParam, msg, hwnd)
	{
		MouseGetPos,,,,controlhwnd ,2

		if (controlhwnd = this.Buttonhwnd && this.ButtonState = 0)
		{
			;GuiControl, , Debug, 버튼0마우스올림

			;선택 이미지 이름가져오기
			;GuiControl, , Debug, % this.NameImage
			GuiControl, Show, % this.NameImage

			this.ButtonState := 1
		}
		else if (controlhwnd != this.Buttonhwnd && this.ButtonState = 1)
		{
			;GuiControl, , Debug, 버튼0마우스벗어남

			GuiControl, Hide, % this.NameImage
			this.ButtonState := 0
		}

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