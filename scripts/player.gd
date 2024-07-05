extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var custom_animation_component: CustomAnimationComponent
@export var jump_componenent: JumpComponent


func _physics_process(delta: float) -> void:
			gravity_component.handle_gravity(self, delta)
			movement_component.handle_horizontal_movement(self,input_component.input_horizontal)
			custom_animation_component.handle_move_animation(input_component.input_horizontal)
			jump_componenent.handle_jump(self, input_component.get_jump_input())
			custom_animation_component.handle_jump_animation(jump_componenent.is_jumping, gravity_component.is_falling)
			move_and_slide()
		
		
