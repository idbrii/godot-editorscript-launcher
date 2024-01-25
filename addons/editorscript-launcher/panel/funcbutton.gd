extends Button

var target # EditorScript
var ed: EditorInterface
var ui_root: Control


func _ready():
	connect("pressed", _on_button_pressed)


func _on_button_pressed():
	var fn = target.new()
	fn.run_script(ed, ui_root)

