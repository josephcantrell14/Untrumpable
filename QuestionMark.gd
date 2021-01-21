extends Area2D

signal hit
var screensize

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    hide()
    screensize = get_viewport_rect().size
    $CollisionShape2D.set_deferred("disabled", false)
    
func enable():
    show()
    $CollisionShape2D.set_deferred("disabled", false)
    position = Vector2(rand_range(200, screensize.x - 200), rand_range(200, screensize.y - 200))

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()

func _on_QuestionMark_area_entered(area):
    if area.get_name() == "Player":
        #hide()
        emit_signal("hit")
        position = Vector2(rand_range(200, screensize.x - 200), rand_range(200, screensize.y - 200))
        #$CollisionShape2D.disabled = true
        $Sound.playing = true