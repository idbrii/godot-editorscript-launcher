tool
extends EditorPlugin

const ScriptBar = preload("res://addons/editor-script-bar/panel/scriptbar.gd")
const bar_scene = preload("res://addons/editor-script-bar/panel/scriptbar.tscn")
export var script_path := "res://code/editor/"

var bar: ScriptBar
var bar_btn: ToolButton


# TODO(dbriscoe): pass get_editor_interface into called things instead and make
# them static. They can setup a skeleton run_script(ed: EditorInterface)



func _enter_tree():
    bar = bar_scene.instance()
    bar.plugin = self
    bar.load_from_path(script_path, get_editor_interface())
    bar_btn = add_control_to_bottom_panel(bar, "Script Bar")


func _exit_tree():
    remove_control_from_bottom_panel(bar)
    bar.queue_free()
