tool
extends EditorPlugin

const bar_scene = preload("res://addons/editorscript-launcher/panel/launchpad.tscn")
var script_path := "res://code/editor/"

var bar
var bar_btn: ToolButton


func _enter_tree():
    bar = bar_scene.instance()
    bar.plugin = self
    bar.load_from_path(script_path, get_editor_interface())
    bar_btn = add_control_to_bottom_panel(bar, "Script Launcher")
    # Need extra space to push above toolbar buttons. Bottom margin didn't work.
    bar.rect_min_size.y = bar.rect_size.y + 50


func _exit_tree():
    if bar:
        remove_control_from_bottom_panel(bar)
        bar.queue_free()
