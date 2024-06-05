extends Node

# spawn obstacles from the global ObstacleSpawningData.objectLocations object, almost the exact same as the 3d verision
var baseObs = preload ("res://Scenes/obstacles/obstacleBase2D.tscn")
var loadedTypes: Dictionary

@onready var scaleHeight = %tempBackground.get_rect().size.y
@onready var cellSize = Vector2( %gridNode.cellWidth, %gridNode.cellHeight)
@onready var spriteScale = %tempBackground.scale

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
    var vec2d = (Vector2(vec3d.x, vec3d.y)) * cellSize
    vec2d.y = (scaleHeight * spriteScale.y) - vec2d.y
    return vec2d

func scale2Dto3D(vec2d: Vector2):
    vec2d.y = (scaleHeight * spriteScale.y)  - vec2d.y
    vec2d = vec2d / cellSize
    return Vector3(vec2d.x, vec2d.y, 0)
