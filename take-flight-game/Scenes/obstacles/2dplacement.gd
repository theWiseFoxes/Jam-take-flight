extends Sprite2D

var moving = false
var notChosen = false
@onready var spawner: Node2D = $"../Spawner2D"

func _ready():
    if get_parent() == spawner:
        notChosen = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if not notChosen:
        if Input.is_action_just_pressed("select_sprite"):
            if not moving:
                if get_rect().has_point(to_local(get_viewport().get_mouse_position())):
                    moving = true
                else:
                    notChosen = true
            else:
                if spawner.give_child(self):
                    moving = false
        if moving:
            var cellPos = %gridNode.grid_snap(get_viewport().get_mouse_position())
            position = cellPos
