extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var Bullet = get_parent().bullet_scene
onready var muzzle = $muzzle
onready var timer = get_node("../shoot_timer")
onready var fire_rate_secs = 1.0 / get_parent().fire_rate
onready var fire_speed = get_parent().fire_speed
onready var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  pass

func shoot(target_xy):
  if can_shoot:
    var bullet = Bullet.instance()
    bullet.init(target_xy, fire_speed)
    owner.add_child(bullet)
    owner.move_child(bullet, 0)
    bullet.global_transform = muzzle.global_transform
    can_shoot = false
    timer.wait_time = fire_rate_secs
    timer.start()
