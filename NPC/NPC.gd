extends KinematicBody

#movement values
export var speed : float = 20
export var acceleration : float = 15
export var air_acceleration : float = 5
export var gravity : float = 0.98
export var max_terminal_velocity : float = 54
export var jump_power : float = 20

var velocity : Vector3
var y_velocity : float

func _physics_process(delta):
	handel_movement(delta)
	
func handel_movement(delta):
	var direction : Vector3
	
	
	if is_on_floor():
		y_velocity = -0.01
	else:
		y_velocity = clamp(y_velocity - gravity, -max_terminal_velocity, max_terminal_velocity)
		
	velocity.y = y_velocity
	velocity = move_and_slide(velocity, Vector3.UP)
