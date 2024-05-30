
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


