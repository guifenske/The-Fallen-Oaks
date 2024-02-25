extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -650.0
@onready var sprite = $Sprite2D
@onready var anothercam = %PhantomCamera2D
@onready var host_cam = %PhantomCameraHost

# Get the gravity from the project settings1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if(Input.is_action_just_pressed("t")):
		if(anothercam.tween_completed):
			goto_another_camera()
	var direction = Input.get_axis("left", "right")
	#if is moving 
	if direction:	
		velocity.x = direction * SPEED
	#if stop moving
	else:	
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if !is_on_floor(): 
		velocity.y += gravity * delta
		sprite.animation = "jump"
	else: 
		if(velocity.x < 0 || velocity.x > 0): sprite.animation = "run"
		else: sprite.animation = "idle"
	
	if(velocity.x < 0):
		sprite.flip_h = true
	elif(velocity.x > 0): sprite.flip_h = false

	if Input.is_action_just_pressed("jump") && is_on_floor():	
		velocity.y = JUMP_VELOCITY

	move_and_slide()
	
func goto_another_camera():
	anothercam.set_priority(2)
	await anothercam.tween_completed
	await get_tree().create_timer(0.5).timeout
	anothercam.set_priority(0)
