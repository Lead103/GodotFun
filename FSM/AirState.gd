extends Node

var player: CharacterBody2D = null
var anim_sprite: AnimatedSprite2D = null
@export var gravity: float = 500.0
@export var move_speed: float = 200.0

func enter():
	player = get_parent().get_parent() as CharacterBody2D
	anim_sprite = player.get_node("AnimatedSprite2D")
	print("Entered Air State")
	anim_sprite.play("air")  # Optionally play an air animation

func exit():
	print("Exited Air State")

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

	# Check if player has landed
	if player.is_on_floor():
		get_parent().set_state("IdleState")
	elif Input.is_action_just_pressed("jump") and player.jump_count < player.max_jumps:
		get_parent().set_state("JumpState")
	elif Input.is_action_just_pressed("dash") and player.dash_count < player.max_dashes:
		get_parent().set_state("DashState")
	elif Input.is_action_just_pressed("attack"):
		get_parent().set_state("AttackState")
