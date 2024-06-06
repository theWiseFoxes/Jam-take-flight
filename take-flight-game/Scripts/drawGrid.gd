extends Node2D

@export var lineColor: Color = Color.BLACK

@onready var screenSize = %tempBackground.get_rect().size * %tempBackground.scale
@onready var gridSize = ObsSpawnData.gridSize
@onready var cellSize = (screenSize / gridSize)
@onready var startPos = %tempBackground.position
 
func _draw():
    var start = startPos
    var end = start + Vector2(0, screenSize.y)

    var cellInc = Vector2(cellSize.x, 0)
    for rowNum in range(gridSize.x + 1):

        draw_line(start, end, lineColor, 3.0)
        start += cellInc
        end += cellInc
    
    start = startPos
    end = start + Vector2(screenSize.x, 0)
    cellInc = Vector2(0, cellSize.y)

    for colNum in range(gridSize.y + 1):
        draw_line(start, end, lineColor, 3.0)
        start += cellInc
        end += cellInc

func grid_snap(mousePos):
    var gridPosition = mousePos - (startPos + (cellSize / 2))
    return startPos + (gridPosition).snapped(cellSize)

func in_grid(pos: Vector2):
    var gridRect = Rect2(startPos, screenSize)
    return gridRect.has_point(pos)