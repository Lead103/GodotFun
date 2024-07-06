extends Node

var player: CharacterBody2D = null
var anim_sprite: AnimatedSprite2D = null
@export var move_speed: float = 200.0

func enter():
	player = get_parent().get_parent() as CharacterBody2D
	anim_sprite = player.get_node("AnimatedSprite2D")
	print("Entered Move State, playing Move Animation")
	anim_sprite.play("move")

func exit():
	print("Exited Move State, ending Move Animation")

func update(delta):
	var direction = 0
	if Input.is_action_pressed("move_right"):
		direction += 1
	if Input.is_action_pressed("move_left"):
		direction -= 1

	player.velocity.x = direction * move_speed
	print("Velocity:", player.velocity)  # Debugging line

	# Flip the sprite based on direction
	if direction != 0:
		anim_sprite.flip_h = direction < 0
		print("Animation Flipped: ", anim_sprite.flip_h)

# Check for state transitions
	if player.is_on_floor():
		if direction == 0:
			get_parent().set_state("IdleState")
		elif Input.is_action_just_pressed("jump"):
			get_parent().set_state("JumpState")
		elif Input.is_action_just_pressed("attack"):
			get_parent().set_state("AttackState")
		elif Input.is_action_just_pressed("dash") and player.dash_count < player.max_dashes:
			get_parent().set_state("DashState")
		else:
			# Ensure the move animation continues to play while moving
			if not anim_sprite.is_playing():
				anim_sprite.play("move")
	else:
		get_parent().set_state("AirState")
