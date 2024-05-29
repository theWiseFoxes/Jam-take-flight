extends RigidBody3D

@export var upwardForceValue:float
@export var bodyShape:BoxShape3D
@export var rotationalSpeedDeg:float
@export var maxAngle = 20.0
@export var minAngle = -20.0

@export var areaScale = Vector3(1,4,1)
@export var drag_coefficient = Vector3(0, 1.5, 0)
@export var airDensity = 1.204
@onready var planeMesh:Node3D = get_node("NewBoxMesh")
@onready var rotationalSpeedRad = deg_to_rad(rotationalSpeedDeg)
var dragForce = Vector3()
var cutoff = 0.0001
var area = Vector3(0.01,0.01,0.01)



func roundMinToZero(vec: Vector3, minimum: float):
	var result: Vector3 = Vector3()
	result.x = vec.x if abs(vec.x) >= minimum else 0.0
	result.y = vec.y if abs(vec.y) >= minimum else 0.0
	result.z = vec.z if abs(vec.z) >= minimum else 0.0
	return result

# Called when the node enters the scene tree for the first time.
func _ready():
	area.z = bodyShape.size.x * bodyShape.size.y
	area.x = bodyShape.size.z * bodyShape.size.y
	area.y = bodyShape.size.x * bodyShape.size.z
	area *= areaScale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("FanButton"):
		apply_central_force((Vector3.UP * upwardForceValue * mass))
		if (planeMesh.rotation_degrees.z < maxAngle):
			planeMesh.rotate_z(rotationalSpeedRad*delta)
	else:
		if (planeMesh.rotation_degrees.z > minAngle):
			planeMesh.rotate_z(-rotationalSpeedRad*delta)
			
func _physics_process (_delta ):
	var temp_velocity = roundMinToZero(linear_velocity, cutoff)
	dragForce = (temp_velocity * temp_velocity) * 0.5 * drag_coefficient *  airDensity * area
	dragForce = dragForce * (-linear_velocity.sign())
	apply_central_force(dragForce)


