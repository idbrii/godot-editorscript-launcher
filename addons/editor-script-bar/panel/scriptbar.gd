tool
extends Control

const FuncButton = preload("res://addons/editor-script-bar/panel/funcbutton.gd")

var plugin: EditorPlugin


func get_files_in_dir(path: String) -> Array:
    var files := []
    var dir := Directory.new()
    var err := dir.open(path)
    if err == OK:
        dir.list_dir_begin()
        var file_name := dir.get_next()
        while file_name != "":
            if not dir.current_is_dir():
                files.append(file_name)
            file_name = dir.get_next()
    elif err == ERR_INVALID_PARAMETER:
        print("Error. Path doesn't exist: ", path)
    else:
        print("Error ", err, " occurred when trying to access the path: ", path)

    return files


func load_from_path(path: String, ed: EditorInterface):
    var files := get_files_in_dir(path)
    for f in files:
        if not f.ends_with(".gd"):
            continue

        var fullpath = path.plus_file(f)

        var btn := FuncButton.new()
        btn.target = load(fullpath)
        assert(btn.target, "Failed to load script %s" % fullpath)
        btn.ed = ed
        #~ assert(btn.target.has_method("run_script"), "Scripts must have a run_script: %s" % fullpath)
        btn.text = f.get_basename()
        btn.set_size(Vector2(80,20))
        btn.show()
        $"%ButtonRoot".add_child(btn)


func _ready():
    var script_path := "res://code/editor/"
    load_from_path(script_path, plugin.get_editor_interface())

