# Helper functions for creating widgets.


static func float(label_text: String):
    var w := HBoxContainer.new()
    var label := Label.new()
    label.text = label_text
    w.add_child(label)
    var spin := SpinBox.new()
    w.add_child(spin)
    return w



static func vec3(label_text: String):
    var w := HBoxContainer.new()
    _append_float(w, "X")
    _append_float(w, "Y")
    _append_float(w, "Z")
    return _inject_optional_label(w, label_text)


static func vec2(label_text: String):
    var w := HBoxContainer.new()
    _append_float(w, "X")
    _append_float(w, "Y")
    return _inject_optional_label(w, label_text)


static func _append_float(root: Control, label_text):
    var label := Label.new()
    label.text = label_text
    root.add_child(label)
    var spin := SpinBox.new()
    root.add_child(spin)
    return spin


static func _inject_optional_label(w: Control, label_text: String):
    if label_text:
        w.name = label_text
        var top := VBoxContainer.new()
        var label := Label.new()
        label.text = label_text
        top.add_child(label)
        top.add_child(w)
        w = top
    return w
