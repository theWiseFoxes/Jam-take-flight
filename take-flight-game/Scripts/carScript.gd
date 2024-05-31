extends Node3D


@onready var player:RigidBody3D = get_node("../player")
var offset
var ray:RayCast3D

func _ready():
    offset = self.position.x - player.position.x
    ray = get_child(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if not ray.is_colliding():
        self.position.x = player.position.x + offset