extends Node3D

@export var speed:float
@onready var player:RigidBody3D = get_node("player")
@onready var car = get_node("CameraAndCar")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.linear_velocity.x = speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	car.position.x = player.position.x
