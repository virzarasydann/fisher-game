extends Node



var database_ikan = {
	"sampah": preload("res://scene/Entities/Player/sampah.tres"),
	"ikan_mas": preload("res://scene/Entities/Player/ikan_mas.tres"),
	"ikan_hijau": preload("res://scene/Entities/Player/ikan_hijau.tres"),
	"ikan_legendary": preload("res://scene/Entities/Player/ikan_legendary.tres")
}

var inventory: Array[Resource] = []

func add_item(item: Resource):

	inventory.append(item)

	print("Berhasil menambah: ", item.name)
	print("Isi tas sekarang: ", inventory.size())



func remove_item(item: Resource):

	if inventory.has(item):
		inventory.erase(item)


var coins: int = 0

signal uang_berubah(nilai_baru)

func jual_semua_ikan() -> int:
	var total_pendapatan = 0
	

	for item in inventory:
		if "price" in item:
			total_pendapatan += item.price
		else:
			total_pendapatan += 50 
	
	
	coins += total_pendapatan
	
	inventory.clear()
	emit_signal("uang_berubah", coins)
	
	print("Terjual! Dapat: ", total_pendapatan)
	return total_pendapatan
	
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
