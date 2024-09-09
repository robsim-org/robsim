@tool
extends PanelContainer

var float_setting_res = preload("res://SideBar/Components/FloatSetting/float_setting.tscn")
var check_box_setting_res = preload("res://SideBar/Components/CheckBoxSetting/check_box_setting.tscn")

@export var settings_labels: Array[String]:
	set(new_val):
		settings_labels = new_val
		create_childs()

## [b]OBRIGATORY[/b] [br][br]
## [color=green]Global.SettingsTypeEnum[/color] [br][br]
## Attention, all the arrays must have the same size even if you want to fill with null
@export var settings_types: Array[Global.SettingsTypeEnum]:
	set(new_val):
		settings_types = new_val
		create_childs()


## [b]OBRIGATORY[/b] [br][br]
## * FLOAT_INPUT: [color=green]float[/color] [br]
## * CHECK_BOX_INPUT: [color=green]bool[/color] [br][br]
## Attention, all the arrays must have the same size even if you want to fill with null
@export var settings_default_vals: Array:
	set(new_val):
		settings_default_vals = new_val
		create_childs()



## [b]OBRIGATORY[/b] [br][br]
## Types for the float settings, such as cm, °, RPM...[br][br]
## Attention, all the arrays must have the same size even if you want to fill with NONE
@export var settings_float_type: Array[AuxTypes.FloatTypeEnum]:
	set(new_val):
		settings_float_type = new_val
		create_childs()

func create_childs():
	if settings_labels.size() == settings_types.size() and settings_labels.size() == settings_labels.size() and settings_labels.size() == settings_float_type.size():
		var settings_v_box = get_node("VBoxContainer/MarginContainer/SettingsVBox")
		
		for child in settings_v_box.get_children():
			child.queue_free()
		
		for index in settings_types.size():
			var setting_type = settings_types[index]
			var setting_label = settings_labels[index]
			var setting_default_val = settings_default_vals[index]
			var setting_float_type = settings_float_type[index]
			
			if setting_type == Global.SettingsTypeEnum.FLOAT_INPUT:
				var c_instance = float_setting_res.instantiate()
				c_instance.name = setting_label
				c_instance.label = setting_label
				c_instance.type = setting_float_type
				settings_v_box.add_child(c_instance)
				c_instance.owner = self
				if setting_default_val is float:
					c_instance.default_value = setting_default_val
			if setting_type == Global.SettingsTypeEnum.CHECK_BOX_INPUT:
				var c_instance = check_box_setting_res.instantiate()
				c_instance.name = setting_label
				c_instance.label = setting_label
				settings_v_box.add_child(c_instance)
				c_instance.owner = self
				if setting_default_val is bool:
					c_instance.default_value = setting_default_val
