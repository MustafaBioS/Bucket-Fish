extends Panel

@onready var bucket_tab = $BtnContainer/Bucket
@onready var fish_tab = $BtnContainer/Fish
@onready var bucket_con = $BucketContainer
@onready var fish_con = $FishCon
@onready var current_coins = $CurrentCoins

@onready var bucket_items_nodes = [
	$BucketContainer/ShopItem,
	$BucketContainer/ShopItem2,
	$BucketContainer/ShopItem3,
	$BucketContainer/ShopItem4,
]
@onready var fish_items_nodes = [
	$FishCon/ShopItem,
	$FishCon/ShopItem2,
	$FishCon/ShopItem3,
	$FishCon/ShopItem4,
]

var bucket_data = [
	[State.BucketSkin.DEFAULT, 0],
	[State.BucketSkin.GREEN,   1],
	[State.BucketSkin.PINK,    2],
	[State.BucketSkin.RED,     3],
]
var fish_data = [
	[State.FishSkin.DEFAULT, 0],
	[State.FishSkin.GREEN,   1],
	[State.FishSkin.PINK,    2],
	[State.FishSkin.RED,     3],
]

var costs = [0, 1, 2, 3]

func _ready() -> void:
	
	print(State.owned_buckets)
	print(State.bucket_skin)
	
	for i in 4:
		var bi = bucket_items_nodes[i]
		var fi = fish_items_nodes[i]
		var bskin = bucket_data[i][0]
		var fskin = fish_data[i][0]
		var bcost = bucket_data[i][1]
		var fcost = fish_data[i][1]
		bi.get_node("BtnContainer/Equip").pressed.connect(func(): State.equip(bskin, true); _refresh(); State.save() )
		bi.get_node("BtnContainer/Purchase").pressed.connect(func(): State.buy(bskin, true, bcost); _refresh(); State.save() )
		fi.get_node("BtnContainer/Equip").pressed.connect(func(): State.equip(fskin, false); _refresh(); State.save() )
		fi.get_node("BtnContainer/Purchase").pressed.connect(func(): State.buy(fskin, false, fcost); _refresh(); State.save())

	_refresh()

func _process(delta: float) -> void:
	current_coins.text = str(State.coins) + " [img=50x50]res://Assets/coin.png[/img]"

func _refresh():
	for i in 4:
		_update_card(bucket_items_nodes[i], bucket_data[i][0], bucket_data[i][1], true)
		_update_card(fish_items_nodes[i],   fish_data[i][0],   fish_data[i][1],   false)

func _update_card(node, skin, cost, is_bucket: bool):
	var owned = State.owned_buckets if is_bucket else State.owned_fish
	var equipped = State.bucket_skin if is_bucket else State.fish_skin
	var textures = State.bucket_textures if is_bucket else State.fish_textures
	var is_owned = skin in owned

	node.get_node("Item").texture = textures[skin]
	node.get_node("BtnContainer/Equip").visible = is_owned and skin != equipped
	node.get_node("BtnContainer/Equipped").visible = is_owned and skin == equipped
	node.get_node("BtnContainer/Purchase").visible = not is_owned
