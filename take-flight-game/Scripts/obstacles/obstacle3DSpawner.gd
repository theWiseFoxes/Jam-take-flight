extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	loadAllObstacles()

func loadAllObstacles():
	for entry in ObstacleSpawningData.objectLocations:
		loadObstacle(entry)

func loadObstacle(obstacle):
	var inst = load(obstacle.objectPath3D)
	self.add_child(inst)
	inst.position = obstacle.locationV3
