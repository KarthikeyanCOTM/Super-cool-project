extends KinematicBody

onready var PelletFire = $PelletFire

#movement values
export var speed : float = 20
export var acceleration : float = 15
export var air_acceleration : float = 5
export var gravity : float = 0.98
export var max_terminal_velocity : float = 54
export var jump_power : float = 20

#camera values
export(float, 0.1, 1) var mouse_sensitivity : float = 0.3
export(float, -90, 0) var min_pitch : float = -90
export(float, 0, 90) var max_pitch : float = 90

var velocity : Vector3
var y_velocity : float
onready var rof_timer = $Timer
export var time_between_shoots = 100.0

#set referances to other nodes(for easier access
onready var camera_pivot = $CameraPivot
onready var camera = $CameraPivot/SpringArm/Camera
#captures mouse so it isn't visible
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	rof_timer.wait_time = time_between_shoots/1000
	
#releases the mouse if escape is pressed
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
#moves the camera
func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		camera_pivot.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, min_pitch, max_pitch)
		
func _physics_process(delta):
	handel_movement(delta)
	if Input.is_action_pressed("attack"):
		PelletFire._shoot()
		rof_timer.start()

#handle's player movement
func handel_movement(delta):
	var direction : Vector3
	
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_back"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
		
	direction = direction.normalized()
	
	var accel = acceleration if is_on_floor() else air_acceleration
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	
	if is_on_floor():
		y_velocity = -0.01
	else:
		y_velocity = clamp(y_velocity - gravity, -max_terminal_velocity, max_terminal_velocity)
		
	if Input.is_action_pressed("jump") and is_on_floor():
		y_velocity = jump_power
		
	velocity.y = y_velocity
	velocity = move_and_slide(velocity, Vector3.UP)

func _on_Timer_timeout():
	PelletFire._fire_reset()
