extends Node

# spawn obstacles from the global ObstacleSpawningData.objectLocations object, almost the exact same as the 3d verision
var baseObs = preload ("res://Scenes/obstacles/obstacleBase2D.tscn")

@onready var scaleHeight = %tempBackground.get_rect().size.y
@onready var cellSize = %gridNode.cellSize
@onready var spriteScale = %tempBackground.scale
@onready var picker = $"../obstaclePicker"

# Called when the node enters the scene tree for the first time.
func _ready():
    loadAllObstacles()

func loadAllObstacles():
    for obs in get_children():
            obs.queue_free()

    for entry in ObsSpawnData.objLocs.values():
        loadObstacle(entry)

func loadObstacle(obstacle):
    var instance = find_child(obstacle.name, false)
    if instance == null:
        instance = baseObs.instantiate()
        instance.name = obstacle.name
        self.add_child(instance)
    
    instance.texture = picker.getObsSprite(obstacle.spriteFor2D)
    instance.position = scale3Dto2D(obstacle.location)
    instance.set_meta("version3D", obstacle.version3D)
    instance.set_meta("gridLoc", obstacle.location)

func give_child(newChild):
    if not %gridNode.in_grid(newChild.position):
        return false
    var gridCoords = scale2Dto3D(newChild.position)
    if ObsSpawnData.objLocs.has(gridCoords):
        return false
    newChild.get_parent().remove_child(newChild)
    add_child(newChild)

    newChild.set_meta("gridLoc", gridCoords)
    for obs in get_children():
        updateData(obs)
    newChild.position = scale3Dto2D(newChild.get_meta("gridLoc"))

    get_tree().change_scene_to_file("res://Scenes/gameScenes/3d_scene.tscn")
    return true

func scale3Dto2D(vec3d: Vector3):
    var vec2d = (Vector2(vec3d.x, vec3d.y + 1)) * cellSize
    vec2d.y = ((scaleHeight * spriteScale.y) - vec2d.y)
    vec2d = vec2d + %tempBackground.position
    return %gridNode.grid_snap(vec2d)

func scale2Dto3D(vec2d: Vector2):
    vec2d -= %tempBackground.position
    vec2d.y = ((scaleHeight * spriteScale.y) - vec2d.y)
    vec2d = vec2d / cellSize
    return floor(Vector3(vec2d.x, vec2d.y - 1, 0))

func updateData(obs):
    var gridCoord = obs.get_meta("gridLoc")
    var data = obstaclesData.new(obs.name, gridCoord, obs.texture.resource_path, obs.get_meta("version3D"))
    ObsSpawnData.objLocs[gridCoord] = data
