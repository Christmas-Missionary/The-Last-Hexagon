extends Area2D

func _figure_out_impact(area: Area2D) -> void:
	if area is Bullet:
		(area as Bullet).bounce(name)
