extends Control

var selectedLevelIndex:int = 0
var highestLevelIndex:int = 2
var selectedPlaneIndex:int = 0
var highestPlaneIndex:int = 2

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/gameScenes/main_menu.tscn")

func _on_lets_go_pressed():
	get_tree().change_scene_to_file("res://Scenes/gameScenes/3d_scene.tscn")

func _on_button_plane_next_pressed():
	selectedPlaneIndex = selectedPlaneIndex + 1
	if selectedPlaneIndex > highestPlaneIndex:
		selectedPlaneIndex = 0

func _on_button_plane_previous_pressed():
	selectedPlaneIndex = selectedPlaneIndex - 1
	if selectedPlaneIndex < 0:
		selectedPlaneIndex = highestPlaneIndex

func _on_button_level_previous_pressed():
	selectedLevelIndex = selectedLevelIndex - 1
	if selectedLevelIndex < 0:
		selectedLevelIndex = highestLevelIndex

func _on_button_level_next_pressed():
	selectedLevelIndex = selectedLevelIndex + 1
	if selectedLevelIndex > highestLevelIndex:
		selectedLevelIndex = 0
		
func updatePlaneText():
	match selectedLevelIndex:
		1:
			print("1")
		2:
			print("2")
		3:
			print("3")
	
	
func updateLevelText():
	match selectedPlaneIndex:
		1:
			print("1")
		2:
			print("2")
		3:
			print("3")
