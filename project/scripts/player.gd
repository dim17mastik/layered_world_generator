extends Camera3D
class_name Player

@onready var _voxel_viewer := $VoxelViewer as VoxelViewer

var sensitivity := 3.0
var speed := 30.0

var view_distance: int : get = _get_view_distance, set = _set_view_distance

func _get_view_distance() -> int:
	return _voxel_viewer.view_distance

func _set_view_distance(value: int) -> void:
	_voxel_viewer.view_distance = value

func _rotate(relative: Vector2) -> void:
	var width := get_viewport().size.x as float
	rotation.x = clampf(rotation.x - relative.y / width * sensitivity, -PI / 2.0, PI / 2.0)
	rotation.y = wrapf(rotation.y - relative.x / width * sensitivity, -PI, PI)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		_rotate(event.relative)
	elif event is InputEventScreenDrag:
		_rotate(event.relative)

func _process(delta: float) -> void:
	var input := Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_up") - Input.get_action_strength("move_down"),
		Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	).normalized()
	translate(input * speed * delta)
