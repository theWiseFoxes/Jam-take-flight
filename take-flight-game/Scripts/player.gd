extends RigidBody3D

signal plane_collided

@export var placementScene: String

@export var upwardForceValue: float = 15
@export var rotationalSpeedDeg: float = 30
@export var startSpeed: Vector3 = Vector3(2, 0, 0)
@export var maxAngle: float = 20.0
@export var minAngle: float = -20.0

@export var areaScale: Vector3 = Vector3(1, 4, 1)
@export var drag_coefficient: Vector3 = Vector3(0, 1.5, 0)
@export var airDensity: float = 1.204

@onready var bodyShape: Shape3D = $playerCollision.shape
@onready var planeMesh: MeshInstance3D = $playerMesh
@onready var rotationalSpeedRad: float = deg_to_rad(rotationalSpeedDeg)
var dragForce: Vector3 = Vector3(0, 0, 0)
var cutoff: float = 0.0001
var area: Vector3 = Vector3(0.01, 0.01, 0.01)
var stopped = false

func roundMinToZero(vec: Vector3, minimum: float):
    var result: Vector3 = Vector3()
    result.x = vec.x if abs(vec.x) >= minimum else 0.0
    result.y = vec.y if abs(vec.y) >= minimum else 0.0
    result.z = vec.z if abs(vec.z) >= minimum else 0.0
    return result

# Called when the node enters the scene tree for the first time.
func _ready():
    area.z = planeMesh.mesh.size.x * planeMesh.mesh.size.y
    area.x = planeMesh.mesh.size.z * planeMesh.mesh.size.y
    area.y = planeMesh.mesh.size.x * planeMesh.mesh.size.z
    area *= areaScale
    linear_velocity = startSpeed
            
func _physics_process(_delta):
    var temp_velocity = roundMinToZero(linear_velocity, cutoff)
    dragForce = (temp_velocity * temp_velocity) * 0.5 * drag_coefficient * airDensity * area
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

func _on_body_entered(body: Node):
    
    print("entered body" + body.name)
    print("could be floor")
    
    if body.is_in_group("floor"):
        print("floors")
        if not stopped:
            stopped = true
            plane_collided.emit()
            gotoPlacement()
        # dead
    elif body.is_in_group("goal"):
        # win
        print("goal")
        gotoPlacement()
    elif body.is_in_group("obstacle"):
        # win
        print("hit")
        if not stopped:
            stopped = true
            plane_collided.emit()
        
func applyFlies():
    print("flies on")
    mass += 0.3

func gotoPlacement():
    get_tree().change_scene_to_file(placementScene)
