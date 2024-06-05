extends Node

# spawn obstacles from the global ObstacleSpawningData.objectLocations object, almost the exact same as the 3d verision
var baseObs = preload ("res://Scenes/obstacles/obstacleBase2D.tscn")
var loadedTypes: Dictionary

@onready var scaleHeight = %gridNode.screen.size.y
@onready var cellScale = %gridNode.cellHeight

# Called when the node enters the scene tree for the first time.
func _ready():
    loadAllObstacles()

func loadAllObstacles():
    for obs in get_children():
        if !ObstacleSpawningData.objectLocations.has(obs.name):
            var data = obstaclesData.new(obs.name, scale2Dto3D(obs.position), obs.texture.resource_path, obs.get_meta("version3D"))
            ObstacleSpawningData.objectLocations[obs.name] = data

    for entry in ObstacleSpawningData.objectLocations.values():
        loadObstacle(entry)

func loadObstacle(obstacle):
    var instance = find_child(obstacle.name, false)
    if instance == null:
        instance = baseObs.instantiate()
        instance.name = obstacle.name
        self.add_child(instance)
    
    if not loadedTypes.has(obstacle.spriteFor2D):
            loadedTypes[obstacle.spriteFor2D] = load(obstacle.spriteFor2D)

    instance.texture = loadedTypes[obstacle.spriteFor2D]
    instance.position = scale3Dto2D(obstacle.location)
    instance.set_meta("version3D", obstacle.version3D)

func updateGlobal():
    for obs in get_children():
       var data = obstaclesData.new(obs.name, scale2Dto3D(obs.position), obs.texture.resource_path, obs.get_meta("version3D"))
       ObstacleSpawningData.objectLocations[obs.name] = data
    get_tree().change_scene_to_file("res://Scenes/gameScenes/3d_scene.tscn")

func scale3Dto2D(vec3d: Vector3):
    var vec2d = (Vector2(vec3d.x, vec3d.y)) * cellScale
    vec2d.y = scaleHeight - vec2d.y
    return vec2d

func scale2Dto3D(vec2d: Vector2):
    var vec3d = Vector3(vec2d.x, vec2d.y, 0) / cellScale
    vec3d.y = scaleHeight - vec3d.y
    return vec3d
