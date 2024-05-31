class_name obstaclesData extends Resource

var location:Vector2:
    set(newValue):
        location = newValue
        location3D.x = location.x
        location3D.y = location.y
    get:
        location.x = location3D.x
        location.y = location3D.y
        return location

@export var type:obstacleType

@export var location3D:Vector3:
    set(newValue):
        location3D = newValue
        location.x = location3D.x
        location.y = location3D.y
    get:
        location3D.x = location.x
        location3D.y = location.y
        return location3D


func _init(oType:obstacleType):
    type = oType
    location3D = Vector3(0,0,0)
    location = Vector2(0,0)
