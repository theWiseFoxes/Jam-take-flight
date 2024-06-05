extends Node2D

signal state_updated

@export var lineColor: Color = Color.BLACK
@export var cellWidth: float = 1 / ObstacleSpawningData.backgroundScale3D
@export var cellHeight: float = 1 / ObstacleSpawningData.backgroundScale3D
@onready var screen = %tempBackground.get_rect()
@onready var rows = screen.size.y / cellHeight
@onready var columns = screen.size.x / cellWidth
@export var placingObject: Node2D
 
func _draw():
	screen = %tempBackground.get_rect()
	var start = Vector2(0, 0)
	var end = Vector2(0, screen.size.y)

	rows = screen.size.y / cellHeight
	columns = screen.size.x / cellWidth
	var cellInc = Vector2(cellWidth, 0)
	for rowNum in range(columns + 1):

		draw_line(start, end, lineColor, 3.0)
		start += cellInc
		end += cellInc
	
	start = Vector2(0, 0)
	end = Vector2(screen.size.x, 0)
	cellInc = Vector2(0, cellHeight)

	for colNum in range(rows + 1):
		draw_line(start, end, lineColor, 3.0)
		start += cellInc
		end += cellInc

func _unhandled_input(event):
	if placingObject != null:
		if event is InputEventMouse:
			var cellPos = (event.position - Vector2(cellWidth / 2, cellHeight / 2)).snapped(Vector2(cellWidth, cellHeight))
			print(cellPos)
			placingObject.position = cellPos
			if event.button_mask&MOUSE_BUTTON_MASK_LEFT != 0:
				placingObject = null
				state_updated.emit()
