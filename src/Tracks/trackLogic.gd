extends Node2D


func _ready():
	$Objects/FinishLine.connect("body_entered",$"../car","_on_FinishLine_body_entered")
	
	var car = get_node("/root/World/car")
	car.position = $Objects/CarSpawn.position
	
