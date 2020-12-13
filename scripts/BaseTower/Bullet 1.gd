extends Node2D
var _speed
var _target_xy

func _ready():
	pass # Replace with function body.

func init(target_xy, speed):
	_target_xy = target_xy
	_speed = speed

func _physics_process(delta):
	position += transform.x * _speed * delta

#TODO: remove bullets when out of map, or out of range
func _on_Bullet_1_body_entered(body):
	if body.is_in_group("bugs"):
		body.queue.free()
	queue_free()
