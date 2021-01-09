extends CanvasLayer

onready var Score_container = get_node("Panel/VBoxContainer")
var test
var lap_count = 0

var hbox = HBoxContainer.new()
var separation = HBoxContainer.new()
var separation2 = HBoxContainer.new()
var score_label = Label.new()
var lap_count_label = Label.new()
var best_time_label = Label.new()

func update(time_list, best_time):
#	$Panel/AnimationPlayer.play("ShowScoreboard")
	hbox.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	separation.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	separation2.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	lap_count_label.text = "Lap"
	score_label.text = "Times : "
	
	hbox.set("custom_constants/separation", 50)
	hbox.add_child(lap_count_label)
	hbox.add_child(separation)
	hbox.add_child(score_label)
	hbox.add_child(separation2)
	Score_container.add_child(hbox)
	
	for score in time_list:
		hbox = HBoxContainer.new()
		separation = HBoxContainer.new()
		separation2 = HBoxContainer.new()
		score_label = Label.new()
		lap_count_label = Label.new()
		
		lap_count += 1
		hbox.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		separation.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		separation2.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		lap_count_label.text = str(lap_count)
		score_label.text = str(score)
		hbox.set("custom_constants/separation", 50)
		hbox.add_child(lap_count_label)
		hbox.add_child(separation)
		hbox.add_child(score_label)
		hbox.add_child(separation2)
		Score_container.add_child(hbox)

	hbox = HBoxContainer.new()
	separation = HBoxContainer.new()
	separation2 = HBoxContainer.new()
	hbox.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	separation.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	separation2.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	lap_count_label.text = "Lap"
	score_label.text = "best Time : "
	
	hbox.set("custom_constants/separation", 50)
	hbox.add_child(lap_count_label)
	hbox.add_child(separation)
	hbox.add_child(score_label)
	hbox.add_child(separation2)
	Score_container.add_child(hbox)


	hbox = HBoxContainer.new()
	hbox.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	hbox.set_alignment(1)
	best_time_label.text = str(best_time)
	hbox.add_child(best_time_label)
	Score_container.add_child(hbox)
	
func _ready():
	update(["00:24:23", "00:23:54"], "00:34:35")
