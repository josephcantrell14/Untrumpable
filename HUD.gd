extends CanvasLayer

signal start_game
signal upgrade1

var pauseTexture = preload("res://Sprites/Icons/pause.png")
var playTexture = preload("res://Sprites/Icons/play.png")

func _process(delta):
    if Input.is_action_pressed("pause"):
        _on_PauseButton_pressed()
func show_message(text):
    $MessageLabel.text = text
    $MessageLabel.show()
    $MessageTimer.start()
func show_game_over():
    $PauseButton.hide()
    $UpgradeHUD.hide()
    $StartButton.show()
    $InstructionsButton.show()
    $QuitButton.show()
    yield($MessageTimer, "timeout")
func update_score(score):
    $ScoreLabel.text = str(score)
func _on_MessageTimer_timeout():
    $MessageLabel.hide()
func _on_StartButton_pressed():
    $StartButton.hide()
    $PauseButton.show()
    $InstructionsButton.hide()
    $QuitButton.hide()
    $Popup.hide()
    $ButtonSound.play()
    emit_signal("start_game")
func _on_PauseButton_pressed():
    if not get_tree().paused:
        get_tree().paused = true
        $PauseButton.icon = playTexture
        $UpgradeHUD.show()
        $InstructionsButton.show()
        $QuitButton.show()
    else:
        get_tree().paused = false
        $PauseButton.icon = pauseTexture
        $UpgradeHUD.hide()
        $InstructionsButton.hide()
        $QuitButton.hide()
func _on_Upgrade1Text_pressed():
    print("clicked")
    emit_signal("upgrade1")
func _on_CloseInstructions_pressed():
    $Popup.hide()
func _on_InstructionsButton_pressed():
    $Popup.show()
func _on_QuitButton_pressed():
    get_tree().quit()
