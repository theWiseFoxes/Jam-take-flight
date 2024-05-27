extends RigidBody3D


@export var airDensity = 1.204
@export var drag_coefficient = Vector3(0.45, 0.25, 0.1)
@export var bodyShape:BoxShape3D
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var temp_velocity = roundMinToZero(linear_velocity, cutoff)
	print(temp_velocity)

	
	dragForce = (temp_velocity * temp_velocity) * 0.5 * drag_coefficient *  airDensity * area
	print(dragForce)
	dragForce = dragForce * (-linear_velocity.sign())
	print(dragForce)
	print()
	apply_central_force(dragForce)




