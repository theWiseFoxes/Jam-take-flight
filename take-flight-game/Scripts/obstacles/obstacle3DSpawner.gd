extends Node

# spawn obstacles from the global ObstacleSpawningData.objectLocations object, almost the exact same as the 2d verision
var loadedTypes: Dictionary

func setupScale():
    ObstacleSpawningData.backgroundScale3D = %backgroundLayer.pixel_size

# Called when the node enters the scene tree for the first time.
func _ready():
    setupScale()
    loadAllObstacles()

func loadAllObstacles():
    for obs in get_children():
        if !ObstacleSpawningData.objectLocations.has(obs.name):
            var data = obstaclesData.new(obs.name, obs.position, obs.get_meta("spriteFor2D"), obs.get_meta("version3D"))
            ObstacleSpawningData.objectLocations[obs.name] = data

    for entry in ObstacleSpawningData.objectLocations.values():
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

func updateGlobal():
    for obs in get_children():
        var data = obstaclesData.new(obs.name, obs.position, obs.get_meta("spriteFor2D"), obs.get_meta("version3D"))
        ObstacleSpawningData.objectLocations[obs.name] = data
