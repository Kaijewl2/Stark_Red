extends CharacterBody2D


var screen_size
@export var speed = 400

func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("w"):
		velocity.y -= 10
		$AnimatedSprite2D.play("up")
	if Input.is_action_pressed("a"):
		velocity.x -= 10
		$AnimatedSprite2D.play("left")
	if Input.is_action_pressed("s"):
		velocity.y += 10
		$AnimatedSprite2D.play("down")
	if Input.is_action_pressed("d"):
		velocity.x += 10
		$AnimatedSprite2D.play("right")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta

	move_and_slide()
