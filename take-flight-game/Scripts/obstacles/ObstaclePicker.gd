extends HBoxContainer

var locked = false

@export var Obstaclelist: Array[String]

func _ready():
	ObsSpawnData.obstacleAssets = Obstaclelist
	var spacer = Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND
	add_child(spacer)

	for obsName in Obstaclelist:
		var option = ObsSpawnData.getLoadedType(obsName)

		var optionHolder = MarginContainer.new()
		optionHolder.add_child(option)
		optionHolder.custom_minimum_size = option.get_rect().size
		add_child(optionHolder)

		spacer = Control.new()
		spacer.size_flags_horizontal = Control.SIZE_EXPAND
		add_child(spacer)
