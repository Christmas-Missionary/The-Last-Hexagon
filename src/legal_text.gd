extends RichTextLabel

func _ready() -> void:
	const seperator: String = "\n----------------------------------------------------------\n"
	
	# For other licenses from assests I use
	var file: FileAccess = FileAccess.open("res://other_copyrights/FOR_THIS_PROJECT.txt", FileAccess.READ)
	var other_licenses: String = file.get_as_text()
	file.close()
	
	# Copyrights to every Godot component
	var info: Array[Dictionary] = Engine.get_copyright_info()
	var form_copyright_info: String = ""
	for entry: Dictionary in info:
		form_copyright_info += str(entry) + "\n\n"
	form_copyright_info += '\n'
	
	# Every 3rd party license used for Godot
	var license_texts: Dictionary = Engine.get_license_info()
	var form_license_info: String = ""
	for license: Variant in license_texts.values():
		form_license_info += "\n/////\n\n" + str(license)
	form_license_info += '\n'
	
	# Set as text, includes Godot License in first line
	text = "Here's to every license and copyright listed below:\n" \
		 + "I am in no way endorsed by or related to any of these copyrights holders."\
		 + seperator + Engine.get_license_text()\
		 + seperator + other_licenses\
		 + seperator + form_copyright_info\
		 + seperator + form_license_info
