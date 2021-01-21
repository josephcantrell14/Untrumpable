extends Area2D

signal hit
signal end

export (int) var xVelocity = 375  # how fast the player will move (pixels/sec)
export (int) var yVelocity = 90
export (int) var gravityVelocity = 4
export (int) var dragVelocity = 3
var velocity = Vector2()  # the player's movement vector
var screensize
var hp = 0
var invincible = false

func _ready():
    screensize = get_viewport_rect().size
    hide()
func start(pos):
    position = pos
    hp = 100
    show()
    $AnimatedSprite.show()
    $CollisionShape2D.set_deferred("disabled", false)
    $EndSound.playing = false
    $Explosion.animation = "default"
    $ExplosionSound.playing = false
    $StartSound.playing = true
func _process(delta):
    if hp > 0:
        if Input.is_action_pressed("moveRight"):
            moveRight()
        elif Input.is_action_pressed("moveLeft"):
            moveLeft()
        elif Input.is_action_pressed("blink"):
            if get_global_mouse_position().x < position.x:
                moveLeft()
            else:
                moveRight()
        velocity.y += gravityVelocity
        if velocity.x > 0:
            velocity.x -= dragVelocity
        elif velocity.x < 0:
            velocity.x += dragVelocity
        position += velocity * delta
        if position.y < 0 or position.y > screensize.y or position.x < 0 or position.x > screensize.x:
            end()
    #position.x = clamp(position.x, 0, screensize.x)
    #position.y = clamp(position.y, 0, screensize.y)
func moveLeft():
    velocity = Vector2()
    velocity.x -= xVelocity
    velocity.y -= yVelocity
    $AnimatedSprite.animation = "right"
    $AnimatedSprite.flip_h = true;
func moveRight():
    velocity = Vector2()
    velocity.x += xVelocity
    velocity.y -= yVelocity
    $AnimatedSprite.animation = "right"
    $AnimatedSprite.flip_h = false;
func _on_Player_body_entered(body):
    hit()
func _on_Player_area_entered(area):
    var name = area.get_name()
    if (name == "Tweeter" or name == "Missile"):
        hit()   
func hit():
    if invincible == false:
        emit_signal("hit")
        invincible = true
        $InvincibleTimer.start()
        $AnimatedSprite.modulate = Color(1, 1, 1, .5)
        hp -= 100
        if hp == 100:
            $Upgrade1.hide()
        elif hp == 0:
            end()
func end():
    emit_signal("end")
    hp -= 100
    velocity.x = 0
    velocity.y = 0
    $AnimatedSprite.hide()
    $CollisionShape2D.set_deferred("disabled", true)
    $EndSound.playing = true
    $Explosion.animation = "explode"
    $ExplosionSound.playing = true
func _on_Main_upgrade1Confirm():
    $Upgrade1.show()
    hp += 100
func _on_InvincibleTimer_timeout():
    invincible = false
    $AnimatedSprite.modulate = Color(1, 1, 1, 1)

