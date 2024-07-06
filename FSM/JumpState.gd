extends Node

var player: CharacterBody2D = null
var anim_sprite: AnimatedSprite2D = null
@export var jump_speed: float = -250.0  # Negative because y-axis is downward
@export var gravity: float = 500.0
@export var move_speed: float = 200.0
@export var air_timeout: float = 0.7  # Time before switching to AirState
@export var max_jump_time: float = 0.2  # Maximum time the jump can be held to reach max height

var air_timer: float = 0.0
var jump_initiated: bool = false
var jump_timer: float = 0.0  # Timer to track how long jump button is held

func enter():
	player = get_parent().get_parent() as CharacterBody2D
	anim_sprite = player.get_node("AnimatedSprite2D")
	print("Entered Jump State, playing Jump Animation")
	anim_sprite.play("jump")

	if not jump_initiated:
		player.velocity.y = jump_speed
		player.jump_count += 1
		jump_initiated = true
		jump_timer = 0.0  # Reset the jump timer
		print("Jump Count:", player.jump_count)

	air_timer = 0.0

func exit():
	print("Exited Jump State, ending Jump Animation")
	jump_initiated = false

func update(delta):
	# Apply gravity
	player.velocity.y += gravity * delta
	print("Velocity:", player.velocity)

	# Allow horizontal movement control in the air
	var direction = 0
	if Input.is_action_pressed("move_right"):
		direction += 1
	if Input.is_action_pressed("move_left"):
		direction -= 1

	player.velocity.x = direction * move_speed
	print("Horizontal Velocity:", player.velocity.x)

	# Flip the sprite based on direction
	if direction != 0:
		anim_sprite.flip_h = direction < 0
		print("Animation Flipped:", anim_sprite.flip_h)

	# Handle variable jump height
	if Input.is_action_pressed("jump") and jump_timer < max_jump_time:
		player.velocity.y = jump_speed
		jump_timer += delta
	else:
		player.velocity.y += gravity * delta  # Apply gravity after jump button is released

	# Increment air timer
	air_timer += delta

	# Check if player has landed
	if player.is_on_floor():
		get_parent().set_state("IdleState")
	elif Input.is_action_just_pressed("jump") and player.jump_count < player.max_jumps:
		get_parent().set_state("JumpState")
		air_timer = 0.0  # Reset air timer on jump
	elif Input.is_action_just_pressed("dash") and player.dash_count < player.max_dashes:
		get_parent().set_state("DashState")
	elif Input.is_action_just_pressed("attack"):
		get_parent().set_state("AttackState")
	elif air_timer >= air_timeout:
		get_parent().set_state("AirState")
