extends RichTextLabel

const _just_seconds: String = "SS.T"
const _seconds_minutes: String = "MM:SS.T"
const _all_three: String = "H:MM:SS.T"

@onready var main: = $"/root/Main" as Main

func _physics_process(_delta) -> void:
	# optimize this block
	if Main.is_playing:
		var tenths_of_seconds: int = roundi(main.time_played * 10)
		if tenths_of_seconds < 10: # under 1 second
			text = "0." + str(tenths_of_seconds)
		elif tenths_of_seconds < 100: # under 10 seconds
			text = str(tenths_of_seconds).insert(1, '.')
		elif tenths_of_seconds < 600: # under 1 minute
			text = str(tenths_of_seconds).insert(2, '.')
		elif tenths_of_seconds < 36000: # under 1 hour
			@warning_ignore("integer_division")
			var minutes: int = tenths_of_seconds / 600
			tenths_of_seconds -= minutes * 600
			var str_of_tenth_secs: String = str(tenths_of_seconds)
			if str_of_tenth_secs.length() == 2:
				str_of_tenth_secs = "0" + str_of_tenth_secs
			text = str(minutes) + ":" + (str_of_tenth_secs.insert(2, '.'))
		#elif tenths_of_seconds < 36000: # under 1 hour
			#@warning_ignore("integer_division")
			#var minutes: int = tenths_of_seconds / 600
			#text = str(minutes) + ":" + (str(tenths_of_seconds).insert(2, '.'))
		else: # at least 1 hour
			pass 
		
