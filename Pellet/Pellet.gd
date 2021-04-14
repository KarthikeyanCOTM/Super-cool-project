extends Spatial

export var speed = 30

const KILL_TIME = 2
var timer = 0

func _ready():
	pass

func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * speed * delta)
	
	timer += delta
	if timer > KILL_TIME:
		queue_free()
