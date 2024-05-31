extends Node2D


@export var type:obstacleType
    

func ready():
    if not ObstacleSpawningData.obstacleTypes.has(type.name):
        ObstacleSpawningData.obstacleTypes[type.name] = type
    var data = obstaclesData.new(ObstacleSpawningData.obstacleTypes[type.name])
    data.location = position
    ObstacleSpawningData.objectLocations.append(data)
