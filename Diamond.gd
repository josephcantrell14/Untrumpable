extends Area2D

signal hit

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    show()
    $CollisionShape2D.set_deferred("disabled", false)
    
func enable():
    show()
    $CollisionShape2D.set_deferred("disabled", false)

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass
"""
func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
"""
func _on_Diamond_area_entered(area):
    if area.get_name() == "Player":
        hide()
        emit_signal("hit")
        $CollisionShape2D.set_deferred("disabled", true)
        $Sound.playing = true