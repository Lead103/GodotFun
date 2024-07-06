extends Node2D

@export var initial_state: String = "IdleState"

var current_state: Node = null

func _ready():
	set_state(initial_state)

func set_state(state_name: String):
	if current_state != null:
		print("Exiting state:", current_state.name)
		current_state.call("exit")
	
	var new_state = get_node(state_name)
	if new_state != null:
		current_state = new_state
		print("Switching to state:", state_name)
		current_state.call("enter")
	else:
		print("State not found:", state_name)

func update_state(delta):
	if current_state:
		current_state.call("update", delta)
