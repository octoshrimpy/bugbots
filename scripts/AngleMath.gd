extends Node

static func angle_difference(angle1, angle2):
  angle1 = fmod(angle1, TAU)
  if angle1 < 0:
    angle1 += TAU
  angle2 = fmod(angle2, TAU)
  if angle2 < 0:
    angle2 += TAU

  return abs(angle2 - angle1)
