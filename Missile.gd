extends Area2D

var velocity = Vector2()
var screensize  # size of the game window

func _ready():
    hide()
    screensize = get_viewport_rect().size
    position = Vector2(rand_range(0, screensize.x), screensize.y + 666)
    randomize() 
func enable():
    position = Vector2(rand_range(0, screensize.x), screensize.y + 666)
    velocity = Vector2(rand_range(0, 10), -350)
    show()
    $AnimatedSprite.show()
    $CollisionShape2D.set_deferred("disabled", false)
    $Explosion.animation = "default"
    $Explosion2.animation = "default"
    $Explosion3.animation = "default"
    $Explosion4.animation = "default"
    $Explosion5.animation = "default"
    $Explosion6.animation = "default"
    $Explosion7.animation = "default"
func _process(delta):
    position += velocity * delta
    if position.y < -1800:
        enable()
"""
func _on_Missile_area_entered(area):
    var name = area.get_name()
    if name == "Player":
        end()
 """       
func end():
    $EndTimer.start()
    $AnimatedSprite.hide()
    velocity = Vector2()
    $CollisionShape2D.set_deferred("disabled", true)
    $Explosion.animation = "explode"
    $Explosion2.animation = "explode"
    $Explosion3.animation = "explode"
    $Explosion4.animation = "explode"
    $Explosion5.animation = "explode"
    $Explosion6.animation = "explode"
    $Explosion7.animation = "explode"
func _on_EndTimer_timeout():
    position = Vector2(rand_range(0, screensize.x), screensize.y + 666)
