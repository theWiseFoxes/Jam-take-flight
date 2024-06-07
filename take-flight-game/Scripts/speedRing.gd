extends Area3D

@export var speedChange: float = 1

func _on_body_entered(body: Node3D):
    if body.has_method("apply_central_impulse"):
        var direction = (find_child("point").global_position - position).normalized()
        print(direction)
        body.apply_central_impulse(direction * speedChange)
