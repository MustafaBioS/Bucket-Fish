extends Node

const SAVE_PATH = "user://save.json"

var score = 0
var coins = 0
var paused = false
var health = 3
var take_dmg = false
var transitioning = false

enum BucketSkin { DEFAULT, GREEN, RED, PINK }
enum FishSkin { DEFAULT, GREEN, RED, PINK }

var bucket_skin: BucketSkin = BucketSkin.DEFAULT
var fish_skin: FishSkin = FishSkin.DEFAULT

var owned_buckets: Array = [BucketSkin.DEFAULT]
var owned_fish: Array = [FishSkin.DEFAULT]

var bucket_textures = {
	BucketSkin.DEFAULT: preload("res://Assets/Buckets/bucket-default.webp"),
	BucketSkin.GREEN: preload("res://Assets/Buckets/bucket-green.png"),
	BucketSkin.PINK: preload("res://Assets/Buckets/bucket-pink.png"),
	BucketSkin.RED: preload("res://Assets/Buckets/bucket-red.png"),
}

var fish_textures = {
	FishSkin.DEFAULT: preload("res://Assets/Fishs/fish-default.png"),
	FishSkin.GREEN: preload("res://Assets/Fishs/fish-green.png"),
	FishSkin.PINK: preload("res://Assets/Fishs/fish-pink.png"),
	FishSkin.RED: preload("res://Assets/Fishs/fish-red.png"),
}

func _ready() -> void:
	load_save()

func buy(skin, is_bucket: bool, cost: int) -> bool:
	var list = owned_buckets if is_bucket else owned_fish
	if coins >= cost and skin not in list:
		coins -= cost
		if is_bucket:
			owned_buckets.append(skin)
		else:
			owned_fish.append(skin)
		return true
	return false

func equip(skin, is_bucket: bool) -> void:
	var list = owned_buckets if is_bucket else owned_fish
	if skin in list:
		if is_bucket:
			bucket_skin = skin
		else:
			fish_skin = skin
		
func get_texture(is_bucket: bool) -> Texture2D:
	if is_bucket:
		return bucket_textures[bucket_skin]
	else:
		return fish_textures[fish_skin]

func save():
	var data = {
		"coins": coins,
		"owned_buckets": owned_buckets,
		"owned_fish": owned_fish,
		"bucket_skin": bucket_skin,
		"fish_skin": fish_skin,
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	
func load_save():
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	
	coins = int(data["coins"])
	owned_buckets = data["owned_buckets"].map(func(x): return int(x))
	owned_fish = data["owned_fish"].map(func(x): return int(x))
	bucket_skin = data["bucket_skin"]
	fish_skin = data["fish_skin"]
