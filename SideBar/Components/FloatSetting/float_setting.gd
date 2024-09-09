@tool
extends HBoxContainer

@export var label: String = "My Label":
	set(new_val):
		label = new_val
		(get_node("Label") as Label).text = label

@export var type: AuxTypes.FloatTypeEnum = AuxTypes.FloatTypeEnum.NONE:
	set(new_type):
		type = new_type
		var type_as_string=""
		
		match type:
			AuxTypes.FloatTypeEnum.CM:
				type_as_string = "cm"
			AuxTypes.FloatTypeEnum.DEG:
				type_as_string = "°"
			AuxTypes.FloatTypeEnum.NEWTON_METERS:
				type_as_string = "Nm"
			AuxTypes.FloatTypeEnum.PERCENT:
				type_as_string = "%"
			AuxTypes.FloatTypeEnum.RPM:
				type_as_string = "RPM"
			_:
				type_as_string = ""
		
		var unity_labels: Label = get_node("PanelContainer/MarginContainer/HBoxContainer/UnityLabel")
		
		if not unity_labels:
			return
		unity_labels.text = type_as_string

		var spin_boxes: SpinBox = get_node("PanelContainer/MarginContainer/HBoxContainer/SpinBoxX")
		

		match type:
			AuxTypes.FloatTypeEnum.CM:
				spin_boxes.allow_greater = true
				spin_boxes.allow_lesser = true
			AuxTypes.FloatTypeEnum.DEG:
				spin_boxes.allow_greater = false
				spin_boxes.allow_lesser = false
			_: 
				spin_boxes.allow_greater = true
				spin_boxes.allow_lesser = true

@export var default_value: float = 0:
	set(new_val):
		default_value = new_val
		(get_node("PanelContainer/MarginContainer/HBoxContainer/SpinBoxX") as SpinBox).value = new_val
