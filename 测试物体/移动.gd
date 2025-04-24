extends Node3D
@export var max_speed = 3
@export var move_accel = 8.0
@export var character_body :CharacterBody3D 
@export var area : Area3D

var move_dir :Vector3
func set_move_dir(new_move_dir:Vector3):
	move_dir = new_move_dir

func _physics_process(delta: float) -> void:

	var compare = character_body.velocity - (character_body.velocity.dot((character_body.target_node.global_position - character_body.global_position).normalized()))*(character_body.target_node.global_position - character_body.global_position).normalized()
	if compare.length() < max_speed:
		print(compare.length())
		character_body.velocity += move_accel * move_dir
		character_body.move_and_slide()

	
