extends Node3D


@onready var player = get_tree().get_first_node_in_group("player")
var offset
var ray:RayCast3D
var stopped = false

func _ready():
	offset = self.position.x - player.position.x
	ray = get_child(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not stopped:
		if not ray.is_colliding():
			self.position.x = player.position.x + offset
		else:
			stopped = true

func stopCar():
	print("stop")
	stopped = true
