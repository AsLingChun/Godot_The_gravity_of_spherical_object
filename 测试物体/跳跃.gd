extends Node3D
@export var player :CharacterBody3D
@export var touch_node : Area3D
@export var junp_force :float = 15
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("junp") and player.touch == true:
		print( "press junp")
		player.touch = false
		player.velocity += -(player.target_node.global_position - player.global_position).normalized() * junp_force
	player.move_and_slide()
