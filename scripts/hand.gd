extends Node3D


var weapons = []
var selected_weapon = 0

func _ready() -> void:
	for i in self.get_children():
		weapons.append(i)
		i.visible = false
		i.anim.play("unequip")
	weapons[selected_weapon].visible = true
	weapons[selected_weapon].anim.play("equip")

func _process(delta):
	if Input.is_action_just_pressed("next_hotbar_item"):
		weapon_change(1)
	elif Input.is_action_just_pressed("previous_hotbar_item"):
		weapon_change(-1)
		
func weapon_change(direction):
	weapons[selected_weapon].anim.play("unequip")
	selected_weapon += direction
	
	if(selected_weapon < 0):
		selected_weapon += weapons.size()
	elif(selected_weapon >= weapons.size()):
		selected_weapon -= weapons.size()
	
	weapons[selected_weapon].visible = true
	weapons[selected_weapon].anim.play("equip")
