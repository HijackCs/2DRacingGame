extends CanvasLayer

func _ready():
	pass


func _on_Return_pressed():
	queue_free()
	SceneChanger.change_scene("res://src/Gui/MainMenu.tscn")
	


func _on_General_pressed():
	assert(get_tree().change_scene("res://src/Gui/Options/General.tscn") == OK)


func _on_Graphics_pressed():
	assert(get_tree().change_scene("res://src/Gui/Options/Graphics.tscn") == OK)


func _on_Control_pressed():
	assert(get_tree().change_scene("res://src/Gui/Options/ControlsMenu.tscn") == OK)
