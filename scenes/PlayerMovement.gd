extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite = %spritePlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isShooting = false
var hasGun = true
var gunNodeScene = preload("res://scenes/gun.tscn")
var isGunInstantiated = false
@onready var main = get_tree().get_root().get_node("main")
var gun = null

func instantiate_gun():
	gun = gunNodeScene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	main.add_child(gun)
	gun.position = position

func _physics_process(delta):
	if(hasGun && !isGunInstantiated):
		print("test")
		isGunInstantiated = true
		instantiate_gun()
	
	if(hasGun):
		gun.position = position	
		gun.position.x -= 3
		gun.position.y += 10
	
	var direction = Input.get_axis("left", "right")
	
	if(Input.is_action_pressed("mouse_right")):
		isShooting = true
	else:
		isShooting = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY

	if(direction != 0):
		if(isShooting):
			sprite.animation = "walking_shooting"
		sprite.animation = "walking"
		if(direction < 0):	
			sprite.flip_h = true
			gun.flip_h = true
		else: 
			sprite.flip_h = false
			gun.flip_h = false
	else:
		sprite.animation = "idle"
		
	velocity.x = direction * SPEED
	# Add the gravity.
	velocity.y += gravity * delta	

	move_and_slide()
