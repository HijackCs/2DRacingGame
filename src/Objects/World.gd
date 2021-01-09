extends Node2D

export(String) var main_track_path

var difference = 0
signal stop_animation

func _ready():
#	var main_track=load("res://Assets/Tracks/track0.tscn").instance()
	var main_track=load(main_track_path).instance()
	add_child_below_node($Track,main_track,true)
	$ScoreBoard.get_child(0).hide()
	
func _process(delta):
	var current_time = $car.get("current_time")
	var lap_time = $car.get("lap_time")
	var previous_lap_time = $car.get("previous_lap_time")
	var display = $car.get("display")
	var lap_count = $car.get("lap_count")
	var lim_lap = $car.get("lim_lap")
	var best_time = $car.get("best_time")
	var print_lap_time = Global.print_time(lap_time)
	var print_current_time = Global.print_time(current_time)
	var print_best_time = Global.print_time(best_time)
	var print_lap_count = str(lap_count) + "/" + str(lim_lap)
	var speed = $car.get("aiguille")


	var end_screen = $car.get("end_screen")
	var time_list = $car.get("times_list")
	
	if end_screen == true:
		$ScoreBoard.update(time_list, best_time)

		
	
	difference = lap_time - previous_lap_time
	difference = stepify(difference, 0.1)
	
	if best_time == 9999:
		print_best_time = Global.print_time(0)
	$HUD.update_dif_chrono(difference)
	$HUD.update_current_time(print_current_time)
	$HUD.update_lap_time(print_lap_time)
	$HUD.update_lap_count(print_lap_count)
	$HUD.update_best_time(print_best_time)
	$HUD.update_aiguille(speed)
	

	if display == true:
		display = false
		emit_signal("stop_animation")
		$HUD.show_timer()


func counter(text):
	$HUD.show_message(text)
	
