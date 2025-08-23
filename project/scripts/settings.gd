extends GridContainer
class_name Settings

@onready var _player := $"../Player" as Player
@onready var _virtual_joystick := $"../VirtualJoystick" as VirtualJoystick
@onready var _sensitivity_box := $SensitivityBox as SpinBox
@onready var _speed_box := $SpeedBox as SpinBox
@onready var _joystick_box := $JoystickBox as CheckBox
@onready var _view_distance_box := $ViewDistanceBox as SpinBox

func _ready() -> void:
	_sensitivity_box.value = _player.sensitivity
	_speed_box.value = _player.speed
	_joystick_box.button_pressed = _virtual_joystick.visible
	_view_distance_box.value = _player.view_distance
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("lock_mouse"):
		Input.mouse_mode = (
			Input.MOUSE_MODE_CAPTURED
			if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE
			else Input.MOUSE_MODE_VISIBLE
		)

func _on_sensitivity_box_value_changed(value: float) -> void:
	_player.sensitivity = value

func _on_speed_box_value_changed(value: float) -> void:
	_player.speed = value

func _on_joystick_box_toggled(toggled_on: bool) -> void:
	_virtual_joystick.visible = toggled_on

func _on_view_distance_box_value_changed(value: float) -> void:
	_player.view_distance = value as int
