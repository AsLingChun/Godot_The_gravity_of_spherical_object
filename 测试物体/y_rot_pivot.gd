extends Node3D

func _input(event):
	#如果事件是鼠标移动，则转动角色或相机
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x *0.001)
