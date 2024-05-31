
# a class to store data (location and type) about a specific obstacle in the game
class_name obstaclesData extends Resource

# the obstacle type
@export var type:obstacleType


var location:Vector2

@export var location3D:Vector3:
	set(newValue):
		location3D = newValue
		location.x = newValue.x
		location.y = newValue.y
	get:
		return Vector3 (location.x, location.y, location3D.z)


func _init(oType:obstacleType):
	type = oType
	location3D = Vector3(0,0,0)
