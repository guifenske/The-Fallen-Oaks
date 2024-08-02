extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite = %spritePlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isShooting = false
var isLoadedShoot = false
var gunNodeScene = preload("res://scenes/gun.tscn")
var isGunInstantiated = false
var gun = null
var flip = 0
@onready var should_apply_idle_gun_follow = false
@onready var direction

func instantiate_gun():
	gun = gunNodeScene.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	gun.position = position
	get_parent().add_child(gun)
		
func _process(delta):
	gun.look_at(get_global_mouse_position())
	if should_apply_idle_gun_follow: return
	flip = 0

	gun.position = position
	gun.position.x -= 3
	gun.position.y += 10

func _physics_process(delta):
	direction = Input.get_axis("left", "right")
	if(!isGunInstantiated):
		isGunInstantiated = true
		instantiate_gun()	
		
	if(sprite.flip_h && get_global_mouse_position().x > position.x):
		sprite.flip_h = false
	elif(!sprite.flip_h && get_global_mouse_position().x < position.x):
		sprite.flip_h = true	
				
	if(Input.is_action_pressed("mouse_right")):
		isShooting = true	
		should_apply_idle_gun_follow = false		
		if(direction == 0):	sprite.animation = "player_gun_shoot"
		else: sprite.animation = "walking_shooting"
			
		gun.animation = "shoot"
	elif(Input.is_action_pressed("mouse_left")):
		isLoadedShoot = true			
		direction = 0
		sprite.animation = "player_loaded_shoot"
		should_apply_idle_gun_follow = false
		gun.animation = "loaded_shoot"
	else:
		isShooting = false
		isLoadedShoot = false
		gun.animation = "idle"		

	# Handle jump.
	if Input.is_action_just_pressed("jump") && is_on_floor() && !isLoadedShoot:
		velocity.y = JUMP_VELOCITY

	if(direction != 0):
		flip = 0
		should_apply_idle_gun_follow = false
		if(isShooting):
			sprite.animation = "walking_shooting"
		elif(!isLoadedShoot):	
			sprite.animation = "walking"
	else:
		if(!isShooting && !isLoadedShoot):	
			sprite.animation = "idle"
			should_apply_idle_gun_follow = true
		
	velocity.x = direction * SPEED
	# Add the gravity.
	velocity.y += gravity * delta	
	
	move_and_slide()
		

func _on_sprite_player_frame_changed():
	if !should_apply_idle_gun_follow: return
	
	gun.position = position
	gun.position.x -= 3
	gun.position.y += 10
	
	if flip == 0:
		gun.position.y += 5
		flip += 1
	else: 
		flip -= 1


func _on_sprite_player_animation_changed():
	if sprite == null: return
	if sprite.animation == "walking_shooting" || sprite.animation == "player_gun_shoot":
		gun.set_frame(0)
		gun.animation = "shoot"
