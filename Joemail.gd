extends Area2D

var velocity = Vector2()
var screensize  # size of the game window

func _ready():
    hide()
    screensize = get_viewport_rect().size
    position = Vector2(-1000, rand_range(75, screensize.y - 75))
    randomize()
func enable():
    position = Vector2(2425.145, rand_range(75, screensize.y - 75))
    velocity = Vector2(-76, 0)
    show()
    $CollisionShape2D.set_deferred("disabled", false)
func _process(delta):
    position += velocity * delta
    if position.x > screensize.x * 2:
        enable()   
func _on_Joemail_area_entered(area):
    var name = area.get_name()
    if name == "Player":
        end()   
func end():
    hide()
    velocity = Vector2()
    $CollisionShape2D.set_deferred("disabled", true)
