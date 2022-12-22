extends Button

var target # EditorScript
var ed: EditorInterface


func _ready():
    connect("pressed", self, "_on_button_pressed")
    printt(name, "_ready")


func _on_button_pressed():
    printt(name, "_on_button_pressed")
    var fn = target.new()
    fn.run_script(ed)
    #~ if target.has_method("get_mesh"):
    #~     return target.get_mesh()

