extends Button

@onready var _rect: = $LegalRect as CanvasItem
@onready var _text: = $LegalText as CanvasItem
@onready var _close_text: = $CloseButton as CanvasItem

func _show() -> void:
	_rect.visible = true
	_text.visible = true
	_close_text.visible = true

func _close() -> void:
	_rect.visible = false
	_text.visible = false
	_close_text.visible = false
