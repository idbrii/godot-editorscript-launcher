tool
extends EditorPlugin

const bar_scene = preload("res://addons/editor-script-bar/panel/scriptbar.tscn")
export var script_path := "res://code/editor/"

var bar
var bar_btn: ToolButton


func _enter_tree():
    bar = bar_scene.instance()
    bar.plugin = self
    bar.load_from_path(script_path, get_editor_interface())
    bar_btn = add_control_to_bottom_panel(bar, "Script Bar")


func _exit_tree():
    if bar:
        remove_control_from_bottom_panel(bar)
        bar.queue_free()
