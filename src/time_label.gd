extends RichTextLabel

func _physics_process(_delta) -> void:
	if Main.is_playing:
		var tenths_of_seconds: String = str(roundi(Main.time_played * 10))
		text = tenths_of_seconds.insert(tenths_of_seconds.length() - 1, '.')
