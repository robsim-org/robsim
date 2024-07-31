extends JoltHingeJoint3D


class CustomData extends BaseData:
	var mass: float
	var torque: float
	var max_rpm: float
	
	var radius: float
	var width: float

var data = CustomData.new()


