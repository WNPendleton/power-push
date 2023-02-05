extends Control

var music_volume = 5
var sound_effects_volume = 5
var visual_effects_intensity = 5

onready var camera = get_tree().get_current_scene().get_node("World/Camera")

func _ready():
	load_settings()

func load_settings():
	var user_settings = File.new()
	if !user_settings.file_exists("user://usersettings.save"):
		save_settings()
	user_settings.open("user://usersettings.save", File.READ)
	var i  = 0
	while !user_settings.eof_reached() and i < 3:
		var setting_from_save = user_settings.get_line()
		if i == 0:
			music_volume = setting_from_save
		elif i == 1:
			sound_effects_volume = setting_from_save
		elif i == 2:
			visual_effects_intensity = setting_from_save
		i+=1
	user_settings.close()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 0 - ((10 - int(music_volume)) * 8))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), 0 - ((10 - int(sound_effects_volume)) * 8))
	$VBoxContainer/HBoxContainer/MusicSlider.value = int(music_volume)
	$VBoxContainer/HBoxContainer2/SFXSlider.value = int(sound_effects_volume)
	$VBoxContainer/HBoxContainer3/VFXSlider.value = int(visual_effects_intensity)

func save_settings():
	var user_settings = File.new()
	user_settings.open("user://usersettings.save", File.WRITE)
	user_settings.store_line(str(music_volume))
	user_settings.store_line(str(sound_effects_volume))
	user_settings.store_line(str(visual_effects_intensity))
	user_settings.close()

func _on_MusicSlider_value_changed(value):
	music_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 0 - ((10 - music_volume) * 8))

func _on_SFXSlider_value_changed(value):
	sound_effects_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), 0 - ((10 - sound_effects_volume) * 8))

func _on_VFXSlider_value_changed(value):
	visual_effects_intensity = value
	Globals.vfx_level = visual_effects_intensity
	camera.do_camera_shake(0.16, 0.4)
