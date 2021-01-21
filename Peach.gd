extends RigidBody2D

export (int) var MIN_SPEED # minimum speed range
export (int) var MAX_SPEED # maximum speed range

func _ready():
    randomize()
    set_linear_velocity(Vector2(rand_range(-40,40), 450))
func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
