extends Node3D
func _input(event):

	if event is InputEventMouseMotion:

		rotate_x(-event.relative.y *0.001)
		rotation_degrees.x = clamp(rotation_degrees.x,-90,90)
