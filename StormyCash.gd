extends Area2D

signal hit
var enabled = false
var screensize
var velocity = Vector2()
var gravityVelocity = 4
var dragVelocity = 3

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    hide()
    screensize = get_viewport_rect().size
    $CollisionShape2D.set_deferred("disabled", true)

func enable():
    enabled = true
    show()
    $CollisionShape2D.set_deferred("disabled", false)
    velocity = Vector2(0, rand_range(120, 180))

func _process(delta):
    if enabled:
        velocity.y += gravityVelocity
        if velocity.x > 0:
            velocity.x -= dragVelocity
        elif velocity.x < 0:
            velocity.x += dragVelocity
        position += velocity * delta
        if position.y > screensize.y:
            _ready()
            
func _on_StormyCash_area_entered(area):
    if area.get_name() == "Player":
        end()

func end():
    enabled = false
    hide()
    emit_signal("hit")
    $CollisionShape2D.set_deferred("disabled", true)
    $Sound.playing = true

