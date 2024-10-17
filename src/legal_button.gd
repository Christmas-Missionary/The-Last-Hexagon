extends Button

@onready var _rect: = $LegalRect as CanvasItem

func _show() -> void:
	_rect.visible = true

func _close() -> void:
	_rect.visible = false
