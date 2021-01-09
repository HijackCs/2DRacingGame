extends CanvasLayer

var fullscreen_button
var borderless_button
var resolution_button

func _ready():
	resolution_button = $MainContainer/VBoxContainer/HBoxContainer/OptionButton
	fullscreen_button = $MainContainer/VBoxContainer/FullscreenContainer/FullscreenCheck
	borderless_button = $MainContainer/VBoxContainer/BorderlessContainer/BorderlessCheck

