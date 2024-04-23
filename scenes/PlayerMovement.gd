extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite = %spritePlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isShooting = false
var isLoadedShoot = false
var hasGun = true
var gunNodeScene = preload("res://scenes/gun.tscn")
var isGunInstantiated = false
@onready var main = get_tree().get_root().get_node("main")
var gun = null

func instantiate_gun():
	gun = gunNodeScene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	gun.position = position
	main.add_child(gun)

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	if(hasGun && !isGunInstantiated):
		isGunInstantiated = true
		instantiate_gun()
		
	if(hasGun):
		gun.position = position
		gun.position.x -= 3
		gun.position.y += 10
		gun.look_at(get_global_mouse_position())
		if(Input.is_action_pressed("mouse_right")):
			isShooting = true			
			if(direction == 0):	sprite.animation = "player_gun_shoot"
			else: sprite.animation = "walking_shooting"
			
			if(sprite.flip_h && get_global_mouse_position().x > position.x):
				sprite.flip_h = false
			elif(!sprite.flip_h && get_global_mouse_position().x < position.x):
				sprite.flip_h = true	
			
			gun.animation = "shoot"
		elif(Input.is_action_pressed("mouse_left")):
			isLoadedShoot = true			
			direction = 0
			if(direction == 0):	sprite.animation = "player_loaded_shoot"
			
			if(sprite.flip_h && get_global_mouse_position().x > position.x):
				sprite.flip_h = false
			elif(!sprite.flip_h && get_global_mouse_position().x < position.x):
				sprite.flip_h = true	
			
			gun.animation = "loaded_shoot"
			
		else:
			isShooting = false
			isLoadedShoot = false
			gun.animation = "idle"		

	# Handle jump.
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY

	if(direction != 0):
		if(isShooting):
			sprite.animation = "walking_shooting"
		elif(!isLoadedShoot):	
			sprite.animation = "walking"
			if(direction < 0):	sprite.flip_h = true
			else: sprite.flip_h = false
	else:
		if(!isShooting && !isLoadedShoot):	sprite.animation = "idle"
		
	velocity.x = direction * SPEED
	# Add the gravity.
	velocity.y += gravity * delta	
	
	move_and_slide()
