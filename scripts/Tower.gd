extends Node2D

#extract the bullet into a json list of bullets, for on-the-fly bullet upgrades
var range_min
var range_max
var bullet_scene
var fire_rate
var fire_speed
onready var gun = $Gun


func _init():
	range_min = 60
	range_max = 500	
	bullet_scene = preload("res://scenes/Bullet_1.tscn")
	fire_rate = 10
	fire_speed = 150
	gun = $Gun


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_location = _get_target_xy()
	if _target_within_range(target_location):
		gun.look_at(target_location)
		gun.shoot(target_location)

func _get_target_xy():
	# using mouse for now
	return get_global_mouse_position()

func _target_within_range(target_location):
	var distance = self.position.distance_to(target_location)
	if range_max > distance && distance > range_min:
		return true
	return false
