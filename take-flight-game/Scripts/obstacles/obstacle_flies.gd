extends Area3D

func _on_body_entered(body):
	if body.name == "player":
		print("entered flies")
		body.applyFlies()
		pass # Replace with function body.
