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
var target_xy
var accuracy
var math = load("res://scripts/bugbotlib/AngleMath.gd")
onready var gun = $Gun

func _init():
  bullet_scene = preload("res://scenes/bullets/Bullet_1.tscn")
  range_min = 60 # Minimum range a tower can fire
  range_max = 500 # Maximum range a tower can fire
  fire_rate = 10 # Number of bullets shot per second
  fire_speed = 150 # Speed of bullet - px/sec
  rotation_speed = 3 # [1..10] Speed tower turns towards target
  accuracy =  0.1 # angle difference between current tower angle and perfect angle towards target

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  find_target()

  if target_within_range():
    var rotation_difference = aim_towards_target()
    if rotation_difference < accuracy: 
      gun.shoot(target_xy)

# func _input(event):
#   # Click anywhere on the screen to output debug information for the tower.
#   if event is InputEventMouseButton:
#    debug()

func _on_shoot_timer_timeout():
  gun.can_shoot = true

func find_target():
  # using mouse for now
  # Eventually find bugs, if none found- return nothing
  target_xy = get_global_mouse_position()

func aim_towards_target():
  var goto_rotation = (target_xy - gun.global_position).normalized().angle()
  var lerp_speed = float(rotation_speed) * (precision * 0.01)

  gun.rotation = fmod(lerp_angle(gun.rotation, goto_rotation, lerp_speed), TAU)
  return math.angle_difference(gun.rotation, goto_rotation)

func target_within_range():
  if target_xy == null:
    return false

  var distance = position.distance_to(target_xy)

  return distance < range_max && distance > range_min

func debug():
  var mouse_loc = get_global_mouse_position()
  var goto_rotation = (target_xy - gun.global_position).normalized().angle()
  var rotation_difference = math.angle_difference(gun.rotation, goto_rotation)

  print(
    "\n Mouse.x: " + str(mouse_loc.x) +
    "\n Mouse.y: " + str(mouse_loc.y) +
    "\n target_xy: " + str(target_xy) +
    "\n target_within_range: " + str(target_within_range()) +
    "\n gun.rotation: " + str(gun.rotation) +
    "\n goto_rotation: " + str(goto_rotation) +
    "\n rotation_difference: " + str(rotation_difference) +
    "\n can_shoot: " + str(gun.can_shoot)
  )
