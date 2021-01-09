extends CanvasLayer


var language_button
var unit_button
func _ready():
	language_button = $MainContainer/VBoxContainer/LanguageContainer/LanguageButton
	unit_button = $MainContainer/VBoxContainer/UnitContainer/UnitButton
	language_button.add_item("EN")
	language_button.add_item("FR")
	unit_button.add_item("KM/H")
	unit_button.add_item("MPH")
	
