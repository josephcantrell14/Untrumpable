extends RigidBody2D

export (int) var MIN_SPEED # minimum speed range
export (int) var MAX_SPEED # maximum speed range

func _ready():
    set_linear_velocity(Vector2(0, 0))

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass


func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
