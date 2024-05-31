extends Node3D

@export var topOffset:float
@export var bottomOffset:float

var player:RigidBody3D
var offset:float

func _ready():
	player = get_node("../player")
	offset = self.position.x - player.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.position.x = player.position.x + offset

	var change =  (self.position.y - player.position.y)
	if change > topOffset:
		self.position.y -= change - topOffset
	if change < bottomOffset:
		self.position.y -= change - bottomOffset



