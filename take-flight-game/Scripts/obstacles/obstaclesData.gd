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

@export var objectPath3D:String
@export var objectPath2D:String

@export var location3D:Vector3:
    set(newValue):
        location3D = newValue
        location.x = location3D.x
        location.y = location3D.y
    get:
        location3D.x = location.x
        location3D.y = location.y
        return location3D


func _init(path3D:String, path2D:String):
    objectPath3D = path3D
    objectPath2D = path2D

    location3D = Vector3(0,0,0)
    location = Vector2(0,0)
