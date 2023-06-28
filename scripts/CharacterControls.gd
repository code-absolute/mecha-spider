extends CharacterBody3D

@export_category("Movement Properties")
@export var _MOVEMENT_SPEED: float = 5.0
@export var _ROTATION_ANGLE: float = 1.0
@export var _JUMP_VELOCITY: float = 4.5

var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var _axis: Vector3 = Vector3.RIGHT

func _physics_process(delta: float):
	_add_gravity(delta)
	_handle_jump()
	_handle_movement(delta)
	move_and_slide()

func _add_gravity(delta: float):
	if not is_on_floor():
		velocity.y -= _gravity * delta

func _handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = _JUMP_VELOCITY

func _handle_movement(delta: float):
	var move_input = Input.get_axis("ui_down", "ui_up")
	var direction = -transform.basis.z * move_input * _MOVEMENT_SPEED
	velocity = Vector3(direction.x, velocity.y, direction.z)
	
	if velocity.z == 0:
		var rotation_direction = Input.get_axis("ui_left", "ui_right")
		rotation.y -= rotation_direction * _ROTATION_ANGLE * delta

#
#func _handle_movement(delta: float):
#	if Input.is_action_pressed("ui_left"):
#		transform.basis = transform.basis.rotated(transform.basis.y, _ROTATION_ANGLE * delta)
#	elif Input.is_action_pressed("ui_right"):
#		transform.basis = transform.basis.rotated(transform.basis.y, -_ROTATION_ANGLE * delta)
#	elif Input.is_action_pressed("ui_up"):
#		velocity = transform.basis.z * -_MOVEMENT_SPEED
#	elif Input.is_action_pressed("ui_down"):
#		velocity = transform.basis.z * _MOVEMENT_SPEED
#	elif Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down"):
#		velocity = transform.basis.z * 0
