extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite = %spritePlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * SPEED
	
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta
	elif(direction == 0):
		sprite.animation = "idle"

	# Handle jump.
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY

	if(direction != 0):
		sprite.animation = "walking"
		if(direction < 0):	sprite.flip_h = true
		else: sprite.flip_h = false

	move_and_slide()
