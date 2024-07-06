extends Node

var player: CharacterBody2D = null
var anim_sprite: AnimatedSprite2D = null
@export var attack_duration: float = 0.5  # Duration of the attack animation
var attack_timer: float = 0.0

func enter():
	player = get_parent().get_parent() as CharacterBody2D
	anim_sprite = player.get_node("AnimatedSprite2D")
	print("Entered Attack State, playing Attack Animation")
	anim_sprite.play("attack")
	attack_timer = attack_duration

func exit():
	print("Exited Attack State, ending Attack Animation")

func update(delta):
	attack_timer -= delta
	if attack_timer <= 0:
		# Reset velocity after the attack
		player.velocity = Vector2.ZERO
		if player.is_on_floor():
			get_parent().set_state("IdleState")
		else:
			get_parent().set_state("AirState")

	# Optional: Handle attack mechanics here, such as dealing damage

	print("Attack timer:", attack_timer)
