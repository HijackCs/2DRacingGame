extends KinematicBody2D

# Movement Var
var wheel_base = 70 # Distance entre les roues avant et arrieres
var steering_angle = 15 # Angle de braquage

var speed = 800
# Acceleration Var
var engine_power = speed #force de l'acceleration

# Friction/Drag
var friction = -0.9 # Force appliquée par le sol ++ -> Sable -- -> Glace
var drag = -0.001 # Force de résistance dans l'air

# Brake/Reverse
var braking = -450 # Force du freinage
var max_speed_reverse = speed / 4 # Vitesse max en marche arriere

# Drift/Slide
var slip_speed = 400 # Vitesse à partir de laquelle la traction diminue
var traction_fast = 0.1 # Traction à haute vitesse
var traction_slow = 0.7 # Traction à basse vitesse

var acceleration = Vector2.ZERO
var velocity = Vector2.ZERO
var steer_direction

onready var trail1 = $TrailPos1/Trail
onready var trail2 = $TrailPos2/Trail
onready var trails = [trail1,trail2]

var current_time = 0.0
var lap_time = 0.0
var previous_lap_time = 0.0
var print_lap_time

export var lim_lap = 2
var lap_count = 0

var times_list = []
var best_time = 9999

var Start_game = false
var Start_counter = false
var display = false
var end_screen = false

var aiguille = -90

func _ready():
	var stop_animation = get_tree().get_root().find_node("World", true, false)
	stop_animation.connect("stop_animation", self, "stop")
	var Starting =  get_tree().get_root().find_node("HUD", true, false)
	Starting.connect("Start", self, "Starting_game")


func _physics_process(delta):
	acceleration = Vector2.ZERO
	if Start_game == false:
		pass
	else:
		get_input()
		apply_friction()
		calculate_steering(delta)
		velocity += acceleration * delta
		velocity = move_and_slide(velocity)
		if Start_counter:
			current_time += delta
		if lap_count == lim_lap + 1:
			lap_count -= 1
			Start_game = false
			end_screen = true
			
#			voir : https://www.reddit.com/r/godot/comments/5iyfng/help_how_do_i_know_what_tile_my_player_is_sitting/
#		var collidingWith = get_collision_pos()
		var tile = get_node("/root/World/Node2D/Track")
		var tile_pos = tile.world_to_map(position)
		var tile_value = tile.get_cellv(tile_pos)
		if (tile_value == -1):
			friction = -4
		else:
			friction = -0.9
#		print("position :"+String(tile_pos) + " tile :"+ String(tile_value) )
		aiguille = (round((velocity.length()*180)/700))-90


func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
		
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	
	acceleration += drag_force + friction_force


func get_input():
	var turn = 0
	
	if Input.is_action_pressed("steer_right"):
		turn += 1
		
	if Input.is_action_pressed("steer_left"):
		turn -= 1
		
	steer_direction = turn * deg2rad(steering_angle)
	
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power
		
	if Input.is_action_pressed("brake"):
		acceleration = transform.x * braking

	if Input.is_action_pressed("drift"):
		traction_fast = 0
		for trail in trails:
			trail.leave_tracks = true
	else:
		traction_fast = 0.1
		for trail in trails:
			trail.leave_tracks = false


func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base/2.0
	var front_wheel = position + transform.x * wheel_base/2.0
	
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	
	if velocity.length() > slip_speed:
		traction = traction_fast
		
	var d = new_heading.dot(velocity.normalized())
	
	if d > 0:
		velocity = velocity.linear_interpolate(new_heading * velocity.length(), traction)
		
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
		
	rotation = new_heading.angle()


func _on_FinishLine_body_entered(body):

	display = true
	previous_lap_time = lap_time
	lap_time = current_time
	current_time = 0

	Start_counter = true
	print_lap_time = Global.print_time(lap_time)
	times_list.append(print_lap_time)
	if lap_time < best_time and lap_time != 0:
		best_time = lap_time


	lap_count += 1 


func Starting_game():
	Start_game = true

func stop():
	display = false
