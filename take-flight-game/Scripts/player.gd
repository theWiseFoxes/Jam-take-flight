extends RigidBody3D

@export var upwardForceValue:float
@export var bodyShape:BoxShape3D
@export var rotationalSpeedDeg:float
@export var startSpeed:Vector3
@export var maxAngle:float = 20.0
@export var minAngle:float = -20.0

@export var areaScale:Vector3 = Vector3(1,4,1)
@export var drag_coefficient:Vector3 = Vector3(0, 1.5, 0)
@export var airDensity:float = 1.204
@onready var planeMesh:Node3D = get_node("NewBoxMesh")
@onready var rotationalSpeedRad:float = deg_to_rad(rotationalSpeedDeg)
var dragForce:Vector3 = Vector3(0,0,0)
var cutoff:float = 0.0001
var area:Vector3 = Vector3(0.01,0.01,0.01)
var stopped:bool = false


func roundMinToZero(vec: Vector3, minimum: float):
	var result: Vector3 = Vector3()
	result.x = vec.x if abs(vec.x) >= minimum else 0.0
	result.y = vec.y if abs(vec.y) >= minimum else 0.0
	result.z = vec.z if abs(vec.z) >= minimum else 0.0
	return result

# Called when the node enters the scene tree for the first time.
func _ready():
	stopped = true
	sleeping = true
	freeze = true
	area.z = bodyShape.size.x * bodyShape.size.y
	area.x = bodyShape.size.z * bodyShape.size.y
	area.y = bodyShape.size.x * bodyShape.size.z
	area *= areaScale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if stopped:
		if Input.is_action_pressed("FanButton"):
			sleeping = false
			stopped = false
			freeze = false
			applyUpward()
			linear_velocity = startSpeed
			print("launch")

			
func _physics_process (_delta ):
		
	var temp_velocity = roundMinToZero(linear_velocity, cutoff)
	dragForce = (temp_velocity * temp_velocity) * 0.5 * drag_coefficient *  airDensity * area
	dragForce = dragForce * (-linear_velocity.sign())
	apply_central_force(dragForce)

	if not stopped:
		if Input.is_action_pressed("FanButton"):
			applyUpward()
		else:
			applyDownward()


func applyUpward():
	apply_central_force((Vector3.UP * upwardForceValue * mass))
	if (rotation.z < deg_to_rad(maxAngle)):
		angular_velocity.z = rotationalSpeedRad
	else:
		angular_velocity.z = 0

func applyDownward():
	if (rotation.z > deg_to_rad(minAngle)):
		angular_velocity.z = -rotationalSpeedRad
	else:
		angular_velocity.z = 0



func _on_body_entered(body:Node):
	
	print("entered body"+body.name)
	stopped = true
	print("could be floor")
	if body.is_in_group("floor"):
		print("floors")
		# dead
	elif body.is_in_group("goal"):
		# win
		print("goal")
		
		
		
func applyFlies():
	print("flies on")
	mass += 0.3
	
	

