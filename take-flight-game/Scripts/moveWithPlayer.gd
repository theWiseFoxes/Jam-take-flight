extends Node3D


@onready var player:RigidBody3D = get_node("../player")
var offset

func _ready():
	offset = self.position.x - player.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.position.x = player.position.x + offset
