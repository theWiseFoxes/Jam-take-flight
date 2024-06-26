extends Node

# spawn obstacles from the global ObstacleSpawningData.objectLocations object, almost the exact same as the 2d verision
var loadedTypes: Dictionary
# in meters
@export var cellSize = Vector3(1, 1, 1)
# in number of cells
@export var backgroundSize = Vector2(23, 12)

# Called when the node enters the scene tree for the first time.
func _ready():

    ObsSpawnData.gridSize = backgroundSize
    loadAllObstacles()

func loadAllObstacles():
    for obs in get_children():
        if !ObsSpawnData.objLocs.has(floor(obs.position) / cellSize):
            obs.set_meta("gridLoc", floor(obs.position) / cellSize)
            var data = obstaclesData.new(obs.name, obs.get_meta("gridLoc"), obs.get_meta("spriteFor2D"), obs.get_meta("version3D"))
            ObsSpawnData.objLocs[obs.get_meta("gridLoc")] = data

    for entry in ObsSpawnData.objLocs.values():
        loadObstacle(entry)

func loadObstacle(obstacle):
    var instance = find_child(obstacle.name, false)

    if instance == null:
        instance = ObsSpawnData.getLoadedType(obstacle.version3D)
        self.add_child(instance)
        
    instance.name = obstacle.name
    instance.position = obstacle.location * cellSize
    instance.set_meta("version3D", obstacle.version3D)
    instance.set_meta("spriteFor2D", obstacle.spriteFor2D)
    instance.set_meta("gridLoc", obstacle.location)