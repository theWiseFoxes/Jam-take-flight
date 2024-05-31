extends Node

# spawn obstacles from the global ObstacleSpawningData.objectLocations object, almost the exact same as the 3d verision
var loadedTypes:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	loadAllObstacles()

func loadAllObstacles():
	for entry in ObstacleSpawningData.objectLocations:
		loadObstacle(entry)

func loadObstacle(obstacle):
	if not loadedTypes.has(obstacle.type.name):
			loadedTypes[obstacle.type.name] = load(obstacle.type.objectPath2D)

	var inst = loadedTypes[obstacle.type.objectPath2D].instance()
	self.add_child(inst)
	inst.position = obstacle.location

