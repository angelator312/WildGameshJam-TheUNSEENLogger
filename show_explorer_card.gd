extends Area2D
@onready var end_card_layer: TileMapLayer = $"../Layers/ExplorerCardLayer"

func _on_body_entered(body: Node2D) -> void:
	end_card_layer.visible=true
