# Helper functions for creating widgets.

static func _append_float(root: Control, label_text: String):
    var label := Label.new()
    label.text = label_text
    root.add_child(label)
    var spin := SpinBox.new()
    root.add_child(spin)
    return spin



class CommonControl extends HBoxContainer:

    func _ready():
        rect_size.x = 100
        rect_size.y = 50
        pass

    func add_empty_label() -> Label:
        var label := Label.new()
        add_child(label)
        move_child(label, 0)
        return label

    func add_label(label_text: String):
        #~ var spacing := add_empty_label()
        #~ spacing.rect_min_size.x = 10
        add_spacer(true)
        var label := add_empty_label()
        label.text = label_text
        add_child(label)
        move_child(label, 0)
        return self

    func add_to(parent):
        parent.add_child(self)
        return self

    static func _append_float(root: Control, label_text: String):
        var label := Label.new()
        label.text = label_text
        root.add_child(label)
        var spin := SpinBox.new()
        root.add_child(spin)
        return spin



class Float extends CommonControl:
    var val: SpinBox

    func _ready():
        val = SpinBox.new()
        self.add_child(val)

    func get_value():
        var txt := val.get_line_edit().text
        return float(txt)

    static func create(label_text, parent):
        var w := Float.new()
        parent.add_child(w)
        w.add_label(label_text)
        return w



class Vec2 extends CommonControl:
    var x : SpinBox
    var y : SpinBox

    func _ready():
        x = _append_float(self, "X")
        y = _append_float(self, "Y")

    static func create(label_text, parent):
        var w := Vec2.new()
        parent.add_child(w)
        w.add_label(label_text)
        return w


class Vec3 extends Vec2:
    var z : SpinBox

    func _ready():
        # parent._ready() is called automatically.
        z = _append_float(self, "Z")

    static func create(label_text, parent):
        var w := Vec3.new()
        parent.add_child(w)
        w.add_label(label_text)
        return w



static func _inject_optional_label(w: Control, label_text: String):
    var top := VBoxContainer.new()
    var label := Label.new()
    label.text = label_text
    top.add_child(label)
    top.add_child(w)
    w = top
    return w
