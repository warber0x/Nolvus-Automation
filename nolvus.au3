#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

Func reset()
	$pid = Run("D:\Novalus\NolvusDashBoard.exe")
	$startTime = TimerInit()
	
	WinWait("[CLASS:Nolvus Dashboard]", "", 10)
	MouseClick("left", 1182, 570)
	MouseClick("left", 1770, 1136)
	Sleep(3000)
EndFunc

Func click()
	; White color found, perform a mouse click
	MouseClick("left", $x, $y)
	Sleep(9000) ; 
	
	$y = $WinLoc[1] + ($WinLoc[3]  / 3)

	MouseMove($x, $y, 2)
	MouseWheel("down", 1)
	$startTime = TimerInit()
EndFunc

Func init()
	WinActivate($windowClass , $windowTitle )
	WinWaitActive($windowClass, $windowTitle)

	$winLoc = WinGetPos($windowClass , $windowTitle)
	$x = $winLoc[0] + ($winLoc[2] / 2)
	$y = $winLoc[1] + ($winLoc[3] / 2)
	
	MouseMove($x, $y, 0)
	MouseWheel("down", 1)
EndFunc

Local $timeout = 60000 ; one minute
Local $startTime = 0
Local $lazySleep = 7200  * 1000 ; 2 hour => Reduce it if you want
Local $windowClass = "[CLASS:WindowsForms10.Window.8.app.0.2982bee_r7_ad1]"
Local $windowTitle = "Manual download"
Local $targetColor = 0xAAAAAA ; Milky White color
Local $pid = 0
Local $x = 0
Local $y = 0
Local $winLoc = 0

reset()
init()

While 1
	
	While TimerDiff($startTime) < $timeout    
		$currentColor = PixelGetColor($x, $y)

		; Check if the color is white then click
		If $currentColor = $targetColor Then
			click()
			ContinueLoop
		EndIf

		; Move the mouse down
		$y += 5 ; Adjust the step size as needed
		MouseMove($x, $y, 2)
	WEnd

	Sleep($lazySleep) ; Sleep until some downloads are complete
	WinClose($windowClass)
	ProcessClose($pid)
	reset()
WEnd