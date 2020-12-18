extends Node2D

# Boid rules:
# 1. Separation Steer away from other Boids
#  * Have circle of vision within certain distance- don't see behind
# 2. Alignment
# 3. Cohesion

# Pathfinding:
# Apply Boid rules as #1 priority
# Past rules, apply weighted pathfinding towards destination (castle)
# Pathfinding is grid based, despite the bugs not following a perfect grid.

var range_min

func _init():
  range_min = 1

# Called when the node enters the scene tree for the first time.
func _ready():
  set_process(true)

func _process(delta):
  rotation += 0.01
  update()

func _input(event):
  # Click anywhere on the screen to output debug information for the tower.
  if event is InputEventMouseButton:
   debug()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func _physics_process(delta):
  var space_state = get_world_2d().direct_space_state
  var result = space_state.intersect_ray(Vector2(0, 0), Vector2(0, -100))
  if result:
    print("Hit: " + result.position)

func _draw():
  draw_line(Vector2(0, 0), Vector2(0, -100), Color(1, 1, 0))

func debug():
  var mouse_loc = get_global_mouse_position()

  print(
    "\n Mouse.x: " + str(mouse_loc.x) +
    "\n Mouse.y: " + str(mouse_loc.y) +
    "\n bug.trans: " + str(transform) +
    "\n bug.gtrans: " + str(global_transform) +
    "\n bug.pos: " + str(position) +
    "\n bug.gpos: " + str(global_position) +
    "\n bug.rot: " + str(rotation) +
    "\n bug.grot: " + str(global_rotation)   # Global rotation is local_rotation % TAU
  )
