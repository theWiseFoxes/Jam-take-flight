extends Node2D



# a script that adds the obstacle to a the global ObstacleSpawningData.objectLocations list
# also ensures its type to the ObstacleSpawningData.obstacleTypes dictionary
@export var type:obstacleType

func ready():
    if not ObstacleSpawningData.obstacleTypes.has(type.name):
        ObstacleSpawningData.obstacleTypes[type.name] = type
    var data = obstaclesData.new(ObstacleSpawningData.obstacleTypes[type.name])
    data.location = position
    ObstacleSpawningData.objectLocations.append(data)
