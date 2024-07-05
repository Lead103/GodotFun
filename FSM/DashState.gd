extends Node

var player: CharacterBody2D = null
var anim_sprite: AnimatedSprite2D = null
@export var dash_speed: float = 500.0
@export var dash_duration: float = 0.2
var dash_timer: float = 0.0

func enter():
	player = get_parent().get_parent() as CharacterBody2D
	anim_sprite = player.get_node("AnimatedSprite2D")
	print("Entered Dash State, playing Dash Animation")
	anim_sprite.play("dash")
	
	# Determine dash direction based on input
	var direction = 0
	if Input.is_action_pressed("move_right"):
		direction = 1
	elif Input.is_action_pressed("move_left"):
		direction = -1
	
	player.velocity.x = direction * dash_speed
	dash_timer = dash_duration
	player.dash_count += 1

	# Flip the sprite based on direction
	anim_sprite.flip_h = direction < 0

func exit():
	player.velocity.x = 0
	print("Exited Dash State, ending Dash Animation")

func update(delta):
	dash_timer -= delta
	if dash_timer <= 0:
		if player.is_on_floor():
			get_parent().set_state("IdleState")
		else:
			get_parent().set_state("JumpState")

	# Apply gravity during dash
	player.velocity.y += player.gravity * delta
	print("Velocity during Dash:", player.velocity)
