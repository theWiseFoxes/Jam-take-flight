extends Node3D

var initial_height_offset = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_global_position ( Vector3(global_position.x,global_position.y+initial_height_offset,global_position.z) )

