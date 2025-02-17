extends Control

# Declare member variables here. Examples:
onready var hud1 = $MarginContainer/Panel/MarginContainer/GridContainer/Panel/MarginContainer/HUD1
onready var hud2 = $MarginContainer/Panel/MarginContainer/GridContainer/Panel2/MarginContainer/HUD2
onready var hud3 = $MarginContainer/Panel/MarginContainer/GridContainer/Panel3/MarginContainer/HUD3

onready var hud_to_id = [hud1, hud2, hud3]

var sensor_to_class = null
var sensor_descriptions = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var globals = get_node('/root/Globals')
	globals.show_joystick()
	
	if not globals.debug_mode:
		$MarginContainer/Panel/DebugTools.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sensor_to_class != null:
		for i in range(min(len(sensor_to_class), len(hud_to_id))):
			var sclass = sensor_to_class[i]
			
			var hud = hud_to_id[i]
				
			var texture = sclass.render_view()
			if texture != null:
				_render_texture_to_hud(texture, hud)
			
			if sensor_descriptions != null:
				var sdesc = sensor_descriptions[i]
				hud.set_text(sdesc)

func set_sensor_classes(mapping):
	sensor_to_class = mapping
	
func set_sensor_descriptions(descrp):
	sensor_descriptions = descrp

func _render_texture_to_hud(texture, hud):
	var image = texture.get_data()
	var width = hud.rect_size[0]
	var height = hud.rect_size[1]
	image.resize(width, height)
	var itex = ImageTexture.new()
	itex.create_from_image(image)
	
	hud.set_render_target(itex)

func _on_toggle_background_button(button):
	var bg = $MarginContainer/Panel/Background
	bg.visible = button

func _on_ToggleHuds_toggled(button_pressed):
	$MarginContainer/Panel/MarginContainer.visible = button_pressed
