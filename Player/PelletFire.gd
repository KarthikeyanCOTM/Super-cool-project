extends Spatial

export(PackedScene) var Pellet

var can_shoot = true

func _ready():
	pass

func _process(delta):
	pass

func _shoot():
	if can_shoot:
		var new_pellet = Pellet.instance()
		new_pellet.global_transform = $Muzzle.global_transform
		var scene_root = get_tree().get_root().get_children()[0]
		scene_root.add_child(new_pellet)
		can_shoot = false
	
func _fire_reset():
	can_shoot = true
