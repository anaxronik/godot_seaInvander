extends Spatial

export var horRotateSpeed = 90
export var verRotateSpeed = 90
export var maxVertAngle = 85
export var minVertAngle = -15
export var minHorAngle = -170
export var maxHorAngle = 170
export var angleAccuracy = 0.1
export var targetPosition =  Vector3(100,100,400)
export var moveSpeed = 3.0



var base
var gun1
var gun2
var time = 0
var curHorAngle
var curVerAngle
var autoTargeting = false
var curPosition
var angleToTarget = {}
var target


func _ready():
	base = $Base
	gun1 = $Base/Gun1
	
func _physics_process(delta):
	time += delta
	curHorAngle = base.rotation_degrees.y
	curVerAngle = gun1.rotation_degrees.z
	curPosition = translation 
	$selfPosition.text = 'selfPosition: ' + str(curPosition)
	
	
	
	if autoTargeting:
		rotateOn()
		angleToTarget = calculateTargetAngle()
		rotateOn(45, 45)
	
	if Input.is_action_pressed('ui_w'):
		self.translation.z -= delta*moveSpeed
	
	if Input.is_action_pressed('ui_s'):
		self.translation.z += delta*moveSpeed
	
	if Input.is_action_pressed('ui_a'):
		self.translation.x -= delta*moveSpeed
	
	if Input.is_action_pressed('ui_d'):
		self.translation.x += delta*moveSpeed
	
	if Input.is_action_pressed('ui_left'):
		rotateLeft()
		
	if Input.is_action_pressed('ui_right'):
		rotateRight()
		
	if Input.is_action_pressed('ui_up'):
		rotateUp()
		
	if Input.is_action_pressed("ui_down"):
		rotateDown()
		
	if Input.is_action_just_pressed("ui_select"):
		print("ui_select")
		print("curPosition", curPosition)
		
	if Input.is_action_just_pressed("ui_cancel"):
		print("ui_cancel")
		autoTargeting = !autoTargeting
		$autoTargeting.text = 'autoTargeting: ' + str(autoTargeting)

func rotateLeft():
	if curHorAngle < maxHorAngle:
		base.rotate_y(deg2rad(horRotateSpeed*2)*get_process_delta_time())

func rotateRight():
	if curHorAngle > minHorAngle:
		base.rotate_y(-deg2rad(horRotateSpeed*2)*get_process_delta_time())

func rotateUp():
	if curVerAngle < maxVertAngle:
			gun1.rotate_z(deg2rad(verRotateSpeed*2)*get_process_delta_time())

func rotateDown():
	if curVerAngle > minVertAngle:
			gun1.rotate_z(-deg2rad(verRotateSpeed*2)*get_process_delta_time())

func rotateOn(horAngle = 0, vertAngle = 0):
	#horizontal rotate
	if (abs(horAngle - curHorAngle))>angleAccuracy:
		if horAngle > curHorAngle:
			rotateLeft()
		if horAngle < curHorAngle:
			rotateRight()
		
	#vertical rotate
	if (abs(vertAngle - curVerAngle))>angleAccuracy:
		if vertAngle < curVerAngle:
			rotateDown()
		if vertAngle > curVerAngle:
			rotateUp()

		
func calculateTargetAngle():
	var xLenght = targetPosition.x - curPosition.x
	var yLenght = targetPosition.y - curPosition.y
	var zLenght = targetPosition.z - curPosition.z
	$targetPosition.text = 'Target position: ' + str(targetPosition)
	
	var yAngle = rad2deg(atan(zLenght/xLenght))
	var zAngle = rad2deg(atan(yLenght/xLenght))
	$yAngle.text = str('yAngle = ' + str(yAngle))
	$zAngle.text = str('zAngle = ' + str(zAngle))
	return {'y': yAngle, 'z':zAngle}
