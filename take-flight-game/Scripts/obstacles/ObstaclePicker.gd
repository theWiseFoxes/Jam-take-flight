extends HBoxContainer

var baseObs = preload ("res://Scenes/obstacles/obstacleBase2D.tscn")
var locked = false

var loadedTypes: Dictionary
@export var Obstaclelist: Array[obstacleMap]

func getObsSprite(path):
    if not loadedTypes.has(path):
            loadedTypes[path] = load(path)
    return loadedTypes[path]

func _ready():
    ObsSpawnData.obstacleAssets = Obstaclelist
    var spacer = Control.new()
    spacer.size_flags_horizontal = Control.SIZE_EXPAND
    add_child(spacer)

    for obs in Obstaclelist:
        var option = baseObs.instantiate()
        option.texture = getObsSprite(obs.asset2d)
        option.set_meta("version3D", obs.asset3d)

        var optionHolder = MarginContainer.new()
        optionHolder.add_child(option)
        optionHolder.custom_minimum_size = option.get_rect().size
        add_child(optionHolder)

        spacer = Control.new()
        spacer.size_flags_horizontal = Control.SIZE_EXPAND
        add_child(spacer)
