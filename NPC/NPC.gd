extends KinematicBody

#movement values
export var speed : float = 20
export var acceleration : float = 15
export var air_acceleration : float = 5
export var gravity : float = 0.98
export var max_terminal_velocity : float = 54
export var move_direction : int = 0

var velocity : Vector3
var y_velocity : float
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	$Timer.start()

func _physics_process(delta):
	handel_movement(delta)
	
func handel_movement(delta):
	var direction : Vector3
	
	if move_direction == 0:
		direction -= transform.basis.z
	if move_direction == 1:
		direction += transform.basis.z
	if move_direction == 2:
		direction -= transform.basis.x
	if move_direction == 3:
		direction += transform.basis.x
	
	if is_on_floor():
		y_velocity = -0.01
	else:
		y_velocity = clamp(y_velocity - gravity, -max_terminal_velocity, max_terminal_velocity)
		
	velocity.y = y_velocity
	velocity = move_and_slide(velocity, Vector3.UP)


func _on_Timer_timeout():
	var direction : Vector3
	
	if move_direction == 0:
		direction -= transform.basis.z
	if move_direction == 1:
		direction += transform.basis.z
	if move_direction == 2:
		direction -= transform.basis.x
	if move_direction == 3:
		direction += transform.basis.x
	
	if is_on_floor():
		y_velocity = -0.01
	else:
		y_velocity = clamp(y_velocity - gravity, -max_terminal_velocity, max_terminal_velocity)
		
	velocity.y = y_velocity
	velocity = move_and_slide(velocity, Vector3.UP)
	move_direction = rng.randi_range(0, 4)
