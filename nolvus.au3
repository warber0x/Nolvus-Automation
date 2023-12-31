#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

Local $timeout = 60000 ; one minute
Local $startTime = 0

; Main window classes and downloadWindowTitle
; ===========================================
Local $mainWindowClass = "[CLASS:WindowsForms10.Window.8.app.0.2982bee_r7_ad1]"
Local $downloadWindowTitle = "Manual download"

; Colors to detect
; =================
Local $targetColor = 0xAAAAAA
Local $backgroundColor = 0x444444

; Window Coordinates
; ===========
Local $x = 0
Local $y = 0

; Misc variables for tests
; ========================
Local $mouseWheelSteps = 6
Local $winLoc = 0
Local $dashboard = ""
Local $isPageUp = False

; Configuration to change
; =======================
Local $nolvusPath = "D:\Novalus\NolvusDashBoard.exe" 

Func startApp()
	; Start the Nolvus
	; =================
	Run($nolvusPath)	
	Sleep(3000)

	; Click on ok button if FrmMessageBox active
	; ==========================================
	ControlClick("FrmMessageBox", "", "[CLASS:WindowsForms10.BUTTON.app.0.2982bee_r7_ad1]")
	
	; Start chrono
	; ============
	$startTime = TimerInit()

	; Click on resume
	; ===============
	WinActivate("Nolvus Dashboard")
	WinWait("[CLASS:Nolvus Dashboard]", "", 10)
	ControlClick("Nolvus Dashboard", "", "[CLASS:WindowsForms10.BUTTON.app.0.2982bee_r7_ad1]")
	ControlClick("Nolvus Dashboard", "", "[CLASS:WindowsForms10.BUTTON.app.0.2982bee_r7_ad1; INSTANCE:7]")
	
	Sleep(3000)
EndFunc

Func click()
	; Click Download button
	; ====================
	MouseClick("left", $x, $y)	
	Sleep(9000)

	;Move away the mouse
	;===================
	$y = $WinLoc[1] + 70
	MouseMove($x, $y, 2)
	Sleep(2000)

	;Restart the timer and reset counters
	;====================================
	$startTime = TimerInit()
	$isPageUp = False
	$backgroundColor = 0x444444
	$mouseWheelSteps = 6
EndFunc

Func init()
	; Init the window and get size
	; ============================
	WinActivate($mainWindowClass , $downloadWindowTitle )
	WinWaitActive($mainWindowClass, $downloadWindowTitle)

	$winLoc = WinGetPos($mainWindowClass , $downloadWindowTitle)
	$x = $winLoc[0] + ($winLoc[2] / 2)
	$y = $winLoc[1] + 70
	
	; Move the mouse at the center of the window and reset the MouseWheel
	; ===================================================================
	MouseMove($x, $y, 0)
	MouseWheel("up", 30)
	MouseWheel("down", 6)
	Sleep(5000)
EndFunc
		
While 1
	
	startApp()
	init()
	
	While TimerDiff($startTime) < $timeout
		; If the download page is not visible try again
		; ==============================================
		If Not WinActive($mainWindowClass , $downloadWindowTitle ) Then
			WinActivate($mainWindowClass , $downloadWindowTitle )
			WinWaitActive($mainWindowClass, $downloadWindowTitle)	
			Sleep(3000)
			ContinueLoop
		Else
			If $isPageUp == False Then
				MouseWheel("up", 30)
				MouseWheel("down", 6)
				$isPageUp = True
			EndIf
			
			$currentColor = PixelGetColor($x, $y)

			; Check if the color is white then click
			; =====================================
			If $currentColor = $backgroundColor Then
				MouseWheel("down", $mouseWheelSteps)
				$winLoc = WinGetPos($mainWindowClass , $downloadWindowTitle)
				$x = $winLoc[0] + ($winLoc[2] / 2)
				$y = $winLoc[1] + 30
				$backgroundColor = -1
			EndIf
			
			; If button found click on it 
			; ===========================
			If $currentColor = $targetColor Then
				click()
				ContinueLoop
			EndIf

			; Move the mouse down
			; ==========================
			$y += 5 ; Adjust the step size as needed
			MouseMove($x, $y, 2)
		EndIf
	WEnd
	
	; Slow down the mouse wheel if the download button not visible
	; ============================================================
	$mouseWheelSteps = $mouseWheelSteps - 2
WEnd
