extends CharacterBody2D

@export var gravity: float = 500.0
var jump_count: int = 0
var max_jumps: int = 2  # Allow double jump
var dash_count: int = 0
var max_dashes: int = 1  # Allow one dash in the air

func _ready():
	print("Setting initial state to IdleState")
	$FSM.set_state("IdleState")

func _physics_process(delta):
	velocity.y += gravity * delta
	$FSM.update_state(delta)
	move_and_slide()

	# Reset jump and dash count when on the ground
	if is_on_floor():
		jump_count = 0
		dash_count = 0
