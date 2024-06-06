extends Node

# spawn obstacles from the global ObstacleSpawningData.objectLocations object, almost the exact same as the 2d verision
var loadedTypes: Dictionary
@export var obstacleSize: float = 1.0
@onready var backgroundSize = %backgroundLayer.region_rect.size

# Called when the node enters the scene tree for the first time.
func _ready():
    ObsSpawnData.gridSize = (backgroundSize / obstacleSize) * %backgroundLayer.pixel_size
    loadAllObstacles()

func loadAllObstacles():
    for obs in get_children():
        if !ObsSpawnData.objLocs.has(floor(obs.position)):
            obs.set_meta("gridLoc", floor(obs.position))
            var data = obstaclesData.new(obs.name, obs.get_meta("gridLoc"), obs.get_meta("spriteFor2D"), obs.get_meta("version3D"))
            ObsSpawnData.objLocs[obs.get_meta("gridLoc")] = data

    for entry in ObsSpawnData.objLocs.values():
        loadObstacle(entry)

func loadObstacle(obstacle):
    var instance = find_child(obstacle.name, false)

    if instance == null:
        if not loadedTypes.has(obstacle.version3D):
            loadedTypes[obstacle.version3D] = load(obstacle.version3D)
        instance = loadedTypes[obstacle.version3D].instantiate()
        instance.name = obstacle.name
        self.add_child(instance)

    instance.position = obstacle.location
    instance.set_meta("version3D", obstacle.version3D)
    instance.set_meta("spriteFor2D", obstacle.spriteFor2D)
    instance.set_meta("gridLoc", obstacle.location)

func updateGlobal():
    for obs in get_children():
        var data = obstaclesData.new(obs.name, obs.get_meta("gridLoc"), obs.get_meta("spriteFor2D"), obs.get_meta("version3D"))
        ObsSpawnData.objLocs[obs.get_meta("gridLoc")] = data
