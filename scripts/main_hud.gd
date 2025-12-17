extends Control

# References to UI elements
@onready var game_manager: GameManager = $GameManager

# Collection section
@onready var copper_label: Label = $MarginContainer/VBoxContainer/CollectionSection/CollectionContent/CopperRow/CopperLabel
@onready var tin_label: Label = $MarginContainer/VBoxContainer/CollectionSection/CollectionContent/TinRow/TinLabel
@onready var collect_copper_btn: Button = $MarginContainer/VBoxContainer/CollectionSection/CollectionContent/CopperRow/CollectCopperBtn
@onready var collect_tin_btn: Button = $MarginContainer/VBoxContainer/CollectionSection/CollectionContent/TinRow/CollectTinBtn

# Crafting section
@onready var tools_label: Label = $MarginContainer/VBoxContainer/CraftingSection/CraftingContent/ToolsRow/ToolsLabel
@onready var craft_tool_btn: Button = $MarginContainer/VBoxContainer/CraftingSection/CraftingContent/CraftToolBtn
@onready var craft_info_label: Label = $MarginContainer/VBoxContainer/CraftingSection/CraftingContent/CraftInfoLabel

# Combat section
@onready var player_hp_label: Label = $MarginContainer/VBoxContainer/CombatSection/CombatContent/PlayerRow/PlayerHPLabel
@onready var enemy_hp_label: Label = $MarginContainer/VBoxContainer/CombatSection/CombatContent/EnemyRow/EnemyHPLabel
@onready var start_combat_btn: Button = $MarginContainer/VBoxContainer/CombatSection/CombatContent/StartCombatBtn
@onready var combat_status_label: Label = $MarginContainer/VBoxContainer/CombatSection/CombatContent/CombatStatusLabel

# Shop section
@onready var coins_label: Label = $MarginContainer/VBoxContainer/ShopSection/ShopContent/CoinsLabel
@onready var buy_hp_btn: Button = $MarginContainer/VBoxContainer/ShopSection/ShopContent/BuyHPBtn
@onready var buy_damage_btn: Button = $MarginContainer/VBoxContainer/ShopSection/ShopContent/BuyDamageBtn
@onready var buy_defense_btn: Button = $MarginContainer/VBoxContainer/ShopSection/ShopContent/BuyDefenseBtn

# Progress section
@onready var rank_label: Label = $MarginContainer/VBoxContainer/ProgressSection/ProgressContent/RankLabel
@onready var stats_label: Label = $MarginContainer/VBoxContainer/ProgressSection/ProgressContent/StatsLabel

func _ready() -> void:
	# Connect signals
	game_manager.resources_changed.connect(_on_resources_changed)
	game_manager.combat_started.connect(_on_combat_started)
	game_manager.combat_ended.connect(_on_combat_ended)
	game_manager.rank_changed.connect(_on_rank_changed)
	game_manager.player_stats_changed.connect(_on_player_stats_changed)
	game_manager.enemy_stats_changed.connect(_on_enemy_stats_changed)
	
	# Connect buttons
	collect_copper_btn.pressed.connect(_on_collect_copper_pressed)
	collect_tin_btn.pressed.connect(_on_collect_tin_pressed)
	craft_tool_btn.pressed.connect(_on_craft_tool_pressed)
	start_combat_btn.pressed.connect(_on_start_combat_pressed)
	buy_hp_btn.pressed.connect(_on_buy_hp_pressed)
	buy_damage_btn.pressed.connect(_on_buy_damage_pressed)
	buy_defense_btn.pressed.connect(_on_buy_defense_pressed)
	
	# Initial update
	update_all_displays()

func update_all_displays() -> void:
	_on_resources_changed()
	_on_player_stats_changed()
	_on_enemy_stats_changed()
	_on_rank_changed()

# Button handlers
func _on_collect_copper_pressed() -> void:
	game_manager.collect_copper()

func _on_collect_tin_pressed() -> void:
	game_manager.collect_tin()

func _on_craft_tool_pressed() -> void:
	if game_manager.craft_tool():
		craft_info_label.text = "Tool crafted successfully!"
	else:
		craft_info_label.text = "Need 2 Copper + 1 Tin to craft"

func _on_start_combat_pressed() -> void:
	if not game_manager.in_combat:
		game_manager.start_combat()

func _on_buy_hp_pressed() -> void:
	# Purchase handled by game_manager, UI updates via signals
	game_manager.buy_health_upgrade()

func _on_buy_damage_pressed() -> void:
	# Purchase handled by game_manager, UI updates via signals
	game_manager.buy_damage_upgrade()

func _on_buy_defense_pressed() -> void:
	# Purchase handled by game_manager, UI updates via signals
	game_manager.buy_defense_upgrade()

# Signal handlers
func _on_resources_changed() -> void:
	copper_label.text = "Copper: %d" % game_manager.copper
	tin_label.text = "Tin: %d" % game_manager.tin
	tools_label.text = "Tools: %d" % game_manager.tools
	coins_label.text = "Coins: %d" % game_manager.coins

func _on_combat_started() -> void:
	start_combat_btn.disabled = true
	combat_status_label.text = "Combat in progress..."

func _on_combat_ended() -> void:
	start_combat_btn.disabled = false
	if game_manager.player_hp > 0:
		combat_status_label.text = "Victory! Gained rewards."
	else:
		combat_status_label.text = "Defeated. Try upgrading!"

func _on_rank_changed() -> void:
	rank_label.text = "Rank: %s" % game_manager.get_rank_name()
	update_stats_display()

func _on_player_stats_changed() -> void:
	player_hp_label.text = "Player HP: %d/%d" % [game_manager.player_hp, game_manager.player_max_hp]
	update_stats_display()

func _on_enemy_stats_changed() -> void:
	enemy_hp_label.text = "Enemy HP: %d/%d" % [game_manager.enemy_hp, game_manager.enemy_max_hp]

func update_stats_display() -> void:
	stats_label.text = "ATK: %d | DEF: %d | HP: %d" % [
		game_manager.player_damage,
		game_manager.player_defense,
		game_manager.player_max_hp
	]
