extends RichTextLabel

const _just_seconds: String = "SS.T"
const _seconds_minutes: String = "MM:SS.T"
const _all_three: String = "H:MM:SS.T"

@onready var main: = $"/root/Main" as Main

func _physics_process(_delta) -> void:
	if Main.is_playing:
		var tenths_of_seconds: String = str(roundi(main.time_played * 10))
		text = tenths_of_seconds.insert(tenths_of_seconds.length() - 1, '.')
