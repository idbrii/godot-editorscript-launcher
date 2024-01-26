# Helper functions for creating widgets.

class CommonControl extends HBoxContainer:

	func _ready():
		size.x = 100
		size.y = 50
		pass

	func add_empty_label() -> Label:
		var label := Label.new()
		add_child(label)
		move_child(label, 0)
		return label

	func add_label(label_text: String):
		if label_text.length() == 0:
			# Skip label if empty.
			return self
		# Fixed space because add_spacer pushes values to the far right.
		var spacing := add_empty_label()
		spacing.custom_minimum_size.x = 10
		var label := add_empty_label()
		label.text = label_text
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
		spin.step = 0.01
		spin.rounded = false
		root.add_child(spin)
		return spin



class Choice extends CommonControl:
	var val: OptionButton
	var choices

	func populate_choices(choice_enum):
		val = OptionButton.new()
		choices = choice_enum
		var choice_names = choices.keys()
		assert(choices[choice_names[0]] == 0, "Input enum must be indexed 0,1,2,...")
		for name in choice_names:
			var idx = choices[name]
			val.add_item(name.capitalize(), idx)
		add_child(val)

	static func create(label_text, choice_enum, parent):
		var w = Choice.new()
		w.populate_choices(choice_enum)
		parent.add_child(w)
		w.add_label(label_text)
		return w

	func get_selected_name():
		return choices.keys()[val.get_selected_id()]

	func get_selected_value():
		return val.get_selected_id()



class Boolean extends CommonControl:
	var val: CheckBox

	func _ready():
		val = CheckBox.new()
		self.add_child(val)

	static func create(label_text, parent):
		var w := Boolean.new()
		parent.add_child(w)
		w.add_label(label_text)
		return w



class Float extends CommonControl:
	var val: SpinBox

	func _ready():
		val = SpinBox.new()
		val.step = 0.01
		val.rounded = false
		self.add_child(val)

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

	func get_value():
		return Vector2(
			x.get_value(),
			y.get_value())

	func set_value(v):
		x.set_value(v.x)
		y.set_value(v.y)

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

	func get_value():
		return Vector3(
			x.get_value(),
			y.get_value(),
			z.get_value())

	func set_value(v):
		z.set_value(v.x)
		z.set_value(v.y)
		z.set_value(v.z)


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
