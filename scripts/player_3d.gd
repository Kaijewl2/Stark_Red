extends RigidBody3D

var mouse_sense := 0.003
var twist_input := 0.0
var pitch_input := 0.0
var boss = null

var currentVel = Vector3.ZERO
var hp = 100

const PUSHBACK = 8.0
const DAMAGE = 5
const REACH = 2.0

@export var boss_path : NodePath

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	boss = get_node(boss_path)

func _process(delta: float):
	$HP_UI.text = "HP: " + str(hp)
	
	var input := Vector3.ZERO
	input.x = Input.get_axis("a", "d")
	input.z = Input.get_axis("w", "s")
	
	var aligned_force = twist_pivot.basis * input
	apply_central_force(aligned_force * 900.0 * delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		-1.5,
		1.5
	)
	
	twist_input = 0.0
	pitch_input = 0.0
	hit_boss(DAMAGE)
		
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sense
			pitch_input = - event.relative.y * mouse_sense

func hit(damage):
	hp -= damage

func hit_boss(damage):
	if boss_in_range():
		if Input.is_action_just_pressed("hit"):
			boss.hit(damage)
			boss

func boss_in_range():
	return global_position.distance_to(boss.global_position) < REACH
