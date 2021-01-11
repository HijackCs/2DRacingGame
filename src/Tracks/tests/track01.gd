extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var l := Line2D.new()   
	l.default_color = Color(1,1,1,1)  
	l.width = 20  
	for point in $Path2D.curve.get_baked_points():  
		l.add_point(point + $Path2D.position)
		
	add_child(l)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
