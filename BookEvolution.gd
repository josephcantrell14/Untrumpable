extends Area2D

signal hit

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    hide()
    $CollisionShape2D.set_deferred("disabled", true)
func enable():
    show()
    $CollisionShape2D.set_deferred("disabled", false)
func _on_BookEvolution_area_entered(area):
    if area.get_name() == "Player":
        hide()
        emit_signal("hit")
        $CollisionShape2D.set_deferred("disabled", true)
        $Sound.playing = true
