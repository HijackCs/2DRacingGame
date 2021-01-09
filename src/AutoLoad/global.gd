extends Node

var file_path = "res://Keybinds.ini"
var config_file
var keybinds = {}


func _ready():
	config_file = ConfigFile.new()
	if config_file.load(file_path) == OK:
		for key in config_file.get_section_keys("keybinds"):
			var key_value = config_file.get_value("keybinds", key)
			print(key, " : ", key_value)
			
			keybinds[key] = key_value
	else:
		print("CONFIG FILE NOT FOUND")
		get_tree().quit()
	set_game_binds()

func set_game_binds():
	for key in keybinds.keys():
		var value = keybinds[key]
		var actionlist = InputMap.get_action_list(key)
		
		if !actionlist.empty():
			InputMap.action_erase_event(key, actionlist[0])

		if value != null:
			var new_key = InputEventKey.new()
			new_key.set_scancode(value)
			InputMap.action_add_event(key, new_key)

func write_config():
	for key in keybinds.keys():
		var key_value = keybinds[key]
		if key_value != null:
			config_file.set_value("keybinds", key, key_value)
		else:
			config_file.set_value("keybinds", key, "")
	config_file.save(file_path)




func print_time(time):
	var time_ms = time
	var time_sec = int(time)
	var time_min = int(time / 60)
	time_ms = stepify((10*(time_ms - time_sec)), 1)
	if time_sec >= 60:
		time_sec -= 60	
	var print_time = str(time_min).pad_zeros(2) + ":" + str(time_sec).pad_zeros(2) + ":" + str(time_ms).pad_zeros(2)
	return print_time
