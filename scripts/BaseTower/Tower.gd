extends Node2D

#extract the bullet into a json list of bullets, for on-the-fly bullet upgrades
var range_min
var range_max
var bullet_scene
var fire_rate
var fire_speed
var rotation_speed
var precision
var turret_range
onready var gun = $Gun

func _init():
  range_min = 60
  range_max = 500
  bullet_scene = preload("res://scenes/Bullet_1.tscn")
  fire_rate = 10
  fire_speed = 150
  rotation_speed = 5  # between 1 and 10
  precision =  5
  gun = $Gun

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  var target_location = _get_target_xy()
  if _target_within_range(target_location):

    var goto_rotation = (target_location - gun.global_position).normalized().angle()
    var lerp_speed = float(rotation_speed) * (precision * 0.01)
    gun.rotation = lerp_angle(gun.rotation, goto_rotation, lerp_speed)

    var rotation_difference = abs(gun.rotation - goto_rotation)
    #TODO: add check for targets, otherwise this fires like my piano
    if abs(gun.rotation - goto_rotation) < 0.1:
      gun.shoot(target_location)

func _get_target_xy():
  # using mouse for now
  return get_global_mouse_position()

func _target_within_range(target_location):
  var distance = self.position.distance_to(target_location)
  if range_max > distance && distance > range_min:
    return true
  return false
