extends CharacterBody3D
@export var atmosphere : Area3D
@export var tianti :CharacterBody3D
@export var r_speed : float = 0.5
@export var universe : Node3D
func _physics_process(delta: float) -> void:
	pass
	#rotation.y += r_speed * delta
