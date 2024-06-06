extends Node

# global Dictionary for sycing obstacles across 2d and 3d
# dictionary should store obstacle names as the keys, and an obstaclesData instance as the values
# any variables in this script will be global because it's specified as an autoload in the project settings
var objLocs: Dictionary

# the width and height of the background in meters
var gridSize = Vector2(23, 12)

func flatten(vec: Vector3):
    return vec.x + (vec.y + 1) * vec.x

func getCell(vec: Vector3):
    return objLocs[floor(vec.x + (vec.y + 1) * vec.x)]

func setCell(vec: Vector3, data):
    objLocs[floor(vec.x + (vec.y) * vec.x)] = data

func checkPos(vec: Vector3):
    return objLocs.has(floor(vec.x + (vec.y) * vec.x))