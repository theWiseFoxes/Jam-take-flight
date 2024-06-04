
# most of this script is so you can edit the mesh and collision box from outside of the packed scene (packed scenes are like prefabs from unity)
# only the stuff at the bottom is usefull
@tool
extends Node3D

@export var currMesh:Mesh:
	set (newMesh):
		if isMeshNode():
			currMesh = newMesh
			meshNode.mesh = newMesh
	get:
		if isMeshNode():
			currMesh = meshNode.mesh
			return meshNode.mesh
		return null

@export var currShape:Shape3D:
	set (newShape):
		if isShapeNode():
			currShape = newShape
			shapeNode.shape = newShape
	get:
		if isShapeNode():
			currShape = shapeNode.shape
			return shapeNode.shape
		return null

@onready var meshNode:MeshInstance3D = get_node("MeshInstance3D")

@onready var shapeNode:CollisionShape3D = get_node("CollisionShape3D")


func isShapeNode():
	if shapeNode == null:
		shapeNode = get_node("CollisionShape3D")
	return shapeNode != null

func isMeshNode():
	if meshNode == null:
		meshNode = get_node("MeshInstance3D")
	return meshNode != null




# a script that adds the obstacle to a the global ObstacleSpawningData.objectLocations list
# also ensures its type to the ObstacleSpawningData.obstacleTypes dictionary
@export var type:obstacleType

func _ready():
	if not Engine.is_editor_hint():
		if not ObstacleSpawningData.obstacleTypes.has(type.name):
			ObstacleSpawningData.obstacleTypes[type.name] = type

		var data = obstaclesData.new(ObstacleSpawningData.obstacleTypes[type.name])
		data.location3D = position
		ObstacleSpawningData.objectLocations.append(data)


func _on_area_3d_body_entered(body):
	
	pass # Replace with function body.
