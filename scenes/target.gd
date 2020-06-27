extends MeshInstance

var direction = 1

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	self.translation.x += delta * direction
	if self.translation.x > 5 || self.translation.x < -5:
		direction *= -1
		
	$"../GunTower".targetPosition = self.translation
