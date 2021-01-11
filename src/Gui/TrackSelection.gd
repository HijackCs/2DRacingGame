extends CanvasLayer


func _ready():
	pass # Replace with function body.


func _on_Track1Select_pressed():
	Global.curren_track="res://src/Tracks/track1.tscn"
	SceneChanger.change_scene("res://src/Objects/World.tscn")


func _on_Track2Select_pressed():
	Global.curren_track="res://src/Tracks/track2.tscn"
	SceneChanger.change_scene("res://src/Objects/World.tscn")
