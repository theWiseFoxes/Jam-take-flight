extends Control

var selectedLevelIndex = 0
var highestLevelIndex = 2
var selectedPlaneIndex = 0
var highestPlaneIndex = 2

var level_label
var plane_label

func _ready():
	level_label = get_node("Level Name")  
	plane_label = get_node("Plane Name")  





func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/gameScenes/main_menu.tscn")

func _on_lets_go_pressed():
	get_tree().change_scene_to_file("res://Scenes/gameScenes/3d_scene.tscn")

func _on_button_plane_next_pressed():
	print("next plane")
	selectedPlaneIndex = selectedPlaneIndex + 1
	if selectedPlaneIndex > highestPlaneIndex:
		selectedPlaneIndex = 0
	updatePlaneText()

func _on_button_plane_previous_pressed():
	print("previous plane")
	selectedPlaneIndex = selectedPlaneIndex - 1
	if selectedPlaneIndex < 0:
		selectedPlaneIndex = highestPlaneIndex
	updatePlaneText()

func _on_button_level_previous_pressed():
	print("previous level")
	selectedLevelIndex = selectedLevelIndex - 1
	if selectedLevelIndex < 0:
		selectedLevelIndex = highestLevelIndex
	updateLevelText()

func _on_button_level_next_pressed():
	print("next level")
	selectedLevelIndex = selectedLevelIndex + 1
	if selectedLevelIndex > highestLevelIndex:
		selectedLevelIndex = 0
	updateLevelText()
		
func updatePlaneText():
	match selectedPlaneIndex:
		0:
			plane_label.text = "Slow"
		1:
			plane_label.text = "Medium"
		2:
			plane_label.text = "Fast"
	
	
func updateLevelText():
	match selectedLevelIndex:
		0:
			level_label.text = "Bedroom"
		1:
			level_label.text = "Living Room"
		2:
			level_label.text = "Kitchen"
