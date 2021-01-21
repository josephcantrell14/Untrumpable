extends Node

export (PackedScene) var NNC
export (PackedScene) var Peach
export (int) var score
var peaches = false
var upgrade1Cost = 666
var upgrade2Cost = 2000
var upgrade3Cost = 5000
var upgrade1 = false
var upgrade2 = false
var upgrade3 = false

signal upgrade1Confirm

func _ready():
    randomize()
    set_process_input(true)
func _input(event):
    # Mouse in viewport coordinates
     if event is InputEventScreenTouch or event is InputEventScreenDrag:
        if event.position.x < $Player.position.x:
            $Player.moveLeft()
        else:
            $Player.moveRight()
func new_game():
    score = 0
    $Player.start($StartPosition.position)
    $EnemyTimer.start()
    $ScoreTimer.start()
    $HUD.update_score(score)
    $Diamond._ready()
    $Diamond2._ready()
    $Diamond3._ready()
    $Diamond4._ready()
    $Diamond5._ready()
    $QuestionMark._ready()
    $QuestionMark2._ready()
    $BookEvolution._ready()
    $Tweeter.end()
    $Tweeter._ready()
    $Missile._ready()
    $Joemail.end()
    $Joemail._ready()
    peaches = false
    $BackgroundGameOver.hide()
    $BackgroundStart.hide()
    $Background.show()
    upgrade1 = false
func _on_EndTimer_timeout():
    game_over()
func game_over():
    $HUD.show_game_over()
    $BackgroundGameOver.show()
func _on_HUD_start_game():
    new_game()
func _on_ScoreTimer_timeout():
    score += 1
    $HUD.update_score(score)
func _on_EnemyTimer_timeout():
    # choose a random location on the Path2D
    $EnemyPath/EnemySpawnLocation.set_offset(randi())
    # create a Mob instance and add it to the scene
    var enemy
    print(peaches)
    if peaches == true:
        var random = randi() % 4
        print(random)
        if random == 0:
            enemy = Peach.instance()
        else:
            enemy = NNC.instance()
    else: 
        enemy = NNC.instance()
    add_child(enemy)
    enemy.position = $EnemyPath/EnemySpawnLocation.position
    var direction = $EnemyPath/EnemySpawnLocation.rotation + PI/2
    direction += rand_range(-PI/4, PI/4)
    enemy.rotation = direction
func _on_Player_hit():
    if upgrade2 == true:
        upgrade2 = false
    elif upgrade1 == true:
        upgrade1 = false
func _on_Player_end():
    $ScoreTimer.stop()
    $EnemyTimer.stop()
    $Diamond.hide()
    $Diamond2.hide()
    $Diamond3.hide()
    $Diamond4.hide()
    $Diamond5.hide()
    $QuestionMark.hide()
    $QuestionMark2.hide()
    $BookEvolution.hide()
    $Tweeter.end()
    $Missile.end()
    $EndTimer.start()
func _on_Diamond_hit():
    score += 10
    $HUD.update_score(score)
    if score >= 42:
        $QuestionMark.enable()
        $QuestionMark2.enable()
        $Missile.enable()
func _on_QuestionMark_hit():
    score += 20
    $HUD.update_score(score)
    if score >= 50:
        $BookEvolution.enable()
func _on_BookEvolution_hit():
    score += 50
    $HUD.update_score(score)
    $Tweeter.enable()
    $GolfBall.enable()
func _on_GolfBall_hit():
    score += 100
    $HUD.update_score(score)
    $EnemyPath/EnemySpawnLocation.set_offset(randi())
    $StormyCash.position = $EnemyPath/EnemySpawnLocation.position
    $StormyCash.enable()
func _on_StormyCash_area_entered(area):
    score += 200
    $HUD.update_score(score)
    peaches = true
func _on_HUD_upgrade1():
    if score >= upgrade1Cost and upgrade1 == false:
        upgrade1 = true
        score -= upgrade1Cost
        $BuySound.play()
        emit_signal("upgrade1Confirm")
        $Joemail.enable()


