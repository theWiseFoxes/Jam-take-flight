extends Node

@export var obstacleList:Array[obstacleType]:
	get:
		return ObstacleSpawningData.obstacleTypes.values()
	set(newValue):
		for e in newValue:
			ObstacleSpawningData.obstacleTypes[e.name] = e

