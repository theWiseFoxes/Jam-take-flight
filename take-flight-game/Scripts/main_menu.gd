extends Control





func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/gameScenes/level_select.tscn")


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/gameScenes/credits_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
