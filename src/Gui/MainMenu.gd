extends CanvasLayer

func _ready()->void:
	pass


func _on_Play_pressed():
	SceneChanger.change_scene("res://src/Objects/World.tscn")
#	get_tree().change_scene_to(game)


func _on_Options_pressed():
	SceneChanger.change_scene("res://src/Gui/Options/General.tscn")


func _on_Exit_pressed():
	get_tree().quit()
