extends CanvasLayer

var countdown = 4
signal Start

func update_current_time(value):
	$MainContainer/MainVBoxContainer/CurrentContainer/current_time.text = str(value)


func update_lap_time(value):
	$MainContainer/MainVBoxContainer/LapTimeContainer/HBoxContainer/lap_time.text = str(value)
	

func update_best_time(value):
	$MainContainer/MainVBoxContainer/BestContainer/best_time.text = str(value)
	


func update_lap_count(value):
	$MainContainer/MainVBoxContainer/LapCountContainer/lap_count.text = str(value)
	
	

func update_dif_chrono(value):
	if value < 0:
		$MainContainer/MainVBoxContainer/DifContainer/Dif_chrono.add_color_override("font_color", Color(0,1,0))
		value = "-" + str(Global.print_time(value*-1))
	elif value > 0:
		$MainContainer/MainVBoxContainer/DifContainer/Dif_chrono.add_color_override("font_color", Color(1,0,0))
		value = "+" + str(Global.print_time(value))
		
	$MainContainer/MainVBoxContainer/DifContainer/Dif_chrono.text = str(value)


func show_message(text):
	$MainContainer/BeginCounterContainer/Begin_counter.text = str(text)
	$MainContainer/AnimationPlayer.play("Show_counter")
	
func update_aiguille(value):
	$MarginContainer/aiguille.set_rotation_degrees(value)


func _on_Timer_timeout():
	countdown -= 1
	if not countdown <= 0:
		show_message(countdown)
		$Timer.start()
	if countdown == 0:
		emit_signal("Start")


func show_timer():
	$MainContainer/AnimationPlayer.play_backwards("Dif_chrono")
	$MainContainer/AnimationPlayer.play("Dif_chrono")

