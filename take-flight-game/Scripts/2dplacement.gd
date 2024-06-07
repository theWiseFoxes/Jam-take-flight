extends Sprite2D

var locked = false
var moving = false
@onready var spawner: Node2D = $"/root/2dGameScene/Spawner2D"
@onready var grid: Node2D = $"/root/2dGameScene/gridNode"
@onready var picker = $"/root/2dGameScene/obstaclePicker"

func _ready():
    if get_parent() == spawner:
        locked = true
    else:
        locked = picker.locked&& not moving

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if locked:
        return
    
    locked = picker.locked&& not moving
    if Input.is_action_just_pressed("select_sprite"):
        if not moving:
            if get_rect().has_point(to_local(get_viewport().get_mouse_position())):
                moving = true
                picker.locked = true
                get_parent().remove_child(self)
                picker.get_parent().add_child(self)
        else:
            if spawner.give_child(self):
                moving = false
    if moving:
        var cellPos = grid.grid_snap(get_viewport().get_mouse_position())
        global_position = cellPos
