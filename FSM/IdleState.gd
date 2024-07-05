extends Node

var player: CharacterBody2D = null
var anim_sprite: AnimatedSprite2D = null

func enter():
	player = get_parent().get_parent() as CharacterBody2D
	anim_sprite = player.get_node("AnimatedSprite2D")
	anim_sprite.play("idle")
	print("Entered Idle State")

func exit():
	print("Exited Idle State")

func update(delta):
	if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
		get_parent().set_state("MoveState")
	elif Input.is_action_just_pressed("jump"):
		get_parent().set_state("JumpState")
	elif Input.is_action_just_pressed("dash") and player.dash_count < player.max_dashes:
		get_parent().set_state("DashState")
