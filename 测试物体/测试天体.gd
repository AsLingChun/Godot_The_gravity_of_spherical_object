extends CharacterBody3D

@export var target_node :CharacterBody3D 
@export var k :float =10000
@export var touch_node : Area3D
@export var camera_3d :Camera3D
@export var mouse_sensitivity_h = 0.15
@export var mouse_sensitivity_v = 0.15
@export var y_rot_pivot : Node3D 
@export var x_rot_pivot : Node3D 
@export var charactor_mover :Node3D 

var touch = false

var aux_dir = Vector3.ZERO
var current_speed : Vector3 = Vector3.ZERO

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		y_rot_pivot.rotate_y(-event.relative.x * mouse_sensitivity_h*0.05)
		x_rot_pivot.rotate_x(-event.relative.y * mouse_sensitivity_v*0.05)
		x_rot_pivot.rotation_degrees.x = clamp(x_rot_pivot.rotation_degrees.x,-90,90)

	
func _process(delta):

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

	if Input.is_action_just_pressed("fullscreen"):
		var fs = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
		if fs:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	var input_dir = Input.get_vector("move_left","move_right","move_forwards","move_backwards")
	var move_dir = (transform.basis * y_rot_pivot.transform.basis * charactor_mover.transform.basis * Vector3(input_dir.x,0,input_dir.y)).normalized()
	charactor_mover.set_move_dir(move_dir)


func _physics_process(delta: float) -> void:
	var direction_vector = target_node.global_position - global_position
	var normalized_direction = direction_vector.normalized()

	if touch_node.get_overlapping_bodies().has(target_node) :
		touch = true
		
	else:
		touch = false

	if touch == false :
		var distence = direction_vector.length()
		var direction = normalized_direction
		var a = k / distence
		var a_vector = direction * a * delta
		current_speed = velocity
		current_speed += a_vector

	else:
		current_speed = current_speed/1.2

	if normalized_direction.dot(Vector3.RIGHT) < 0.99999:
		aux_dir = Vector3.RIGHT
	else:
		aux_dir = Vector3.FORWARD
	var x_axis = aux_dir.cross(normalized_direction).normalized()
	var z_axis = normalized_direction.cross(x_axis).normalized()
	var new_basis = Basis(x_axis,-normalized_direction,z_axis)
	transform.basis = new_basis
	up_direction = transform.basis.y
	velocity = current_speed
	move_and_slide()
