extends RichTextLabel

func _ready() -> void:
	
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
		 + "I am in no way endorsed by or related to any of these copyrights holders.\n\n"\
		 + "Godot Game Engine - MIT License\n\n" + Engine.get_license_text()\
		 + "\n\nFor other assets used:\n\n" + other_licenses\
		 + "\n\nAnd now, the copyright info of every component used in Godot:\n\n" + form_copyright_info\
		 + "\n\nIf you wanted to see the licenses to those components, here it is:\n\n" + form_license_info