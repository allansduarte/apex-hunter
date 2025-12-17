extends Node
class_name GameManager

# Singleton pattern
static var instance: GameManager

# Resources
var copper: int = 0
var tin: int = 0
var tools: int = 0

# Economy
var coins: int = 100

# Rank system
enum Rank { G_MINUS, G, G_PLUS }
var current_rank: Rank = Rank.G_MINUS
var rank_names: Dictionary = {
	Rank.G_MINUS: "G-",
	Rank.G: "G",
	Rank.G_PLUS: "G+"
}

# Player stats
var player_hp: int = 100
var player_max_hp: int = 100
var player_damage: int = 10
var player_defense: int = 5

# Enemy stats
var enemy_hp: int = 50
var enemy_max_hp: int = 50
var enemy_damage: int = 8
var enemy_defense: int = 3

# Combat state
var in_combat: bool = false
var combat_timer: float = 0.0
var combat_interval: float = 1.5  # Seconds between attacks

# Signals
signal resources_changed
signal combat_started
signal combat_ended
signal rank_changed
signal player_stats_changed
signal enemy_stats_changed

func _ready() -> void:
	instance = self

func _process(delta: float) -> void:
	if in_combat:
		combat_timer += delta
		if combat_timer >= combat_interval:
			combat_timer = 0.0
			process_combat_round()

# Resource collection
func collect_copper() -> void:
	copper += 1
	coins += 1
	resources_changed.emit()
	check_rank_progression()

func collect_tin() -> void:
	tin += 1
	coins += 2
	resources_changed.emit()
	check_rank_progression()

# Crafting system
func craft_tool() -> bool:
	if copper >= 2 and tin >= 1:
		copper -= 2
		tin -= 1
		tools += 1
		player_damage += 2  # Tools improve damage
		resources_changed.emit()
		player_stats_changed.emit()
		return true
	return false

# Combat system
func start_combat() -> void:
	if not in_combat:
		in_combat = true
		enemy_hp = enemy_max_hp
		combat_timer = 0.0
		combat_started.emit()
		enemy_stats_changed.emit()

func process_combat_round() -> void:
	if not in_combat:
		return
	
	# Player attacks enemy
	var player_attack: int = max(1, player_damage - enemy_defense)
	enemy_hp -= player_attack
	enemy_stats_changed.emit()
	
	if enemy_hp <= 0:
		end_combat(true)
		return
	
	# Enemy attacks player
	var enemy_attack: int = max(1, enemy_damage - player_defense)
	player_hp -= enemy_attack
	player_stats_changed.emit()
	
	if player_hp <= 0:
		end_combat(false)

func end_combat(player_won: bool) -> void:
	in_combat = false
	combat_timer = 0.0
	
	if player_won:
		# Reward player
		coins += 20
		copper += 2
		tin += 1
		resources_changed.emit()
		
		# Scale enemy for next fight
		enemy_max_hp += 10
		enemy_damage += 2
		enemy_defense += 1
	
	# Reset player HP
	player_hp = player_max_hp
	player_stats_changed.emit()
	combat_ended.emit()

# Rank progression
func check_rank_progression() -> void:
	var total_resources: int = copper + tin + tools
	
	if current_rank == Rank.G_MINUS and total_resources >= 10:
		current_rank = Rank.G
		player_max_hp += 20
		player_hp = player_max_hp
		player_damage += 5
		player_defense += 2
		rank_changed.emit()
		player_stats_changed.emit()
	elif current_rank == Rank.G and total_resources >= 30:
		current_rank = Rank.G_PLUS
		player_max_hp += 30
		player_hp = player_max_hp
		player_damage += 10
		player_defense += 5
		rank_changed.emit()
		player_stats_changed.emit()

func get_rank_name() -> String:
	return rank_names[current_rank]

# Shop system
func buy_health_upgrade() -> bool:
	var cost: int = 50
	if coins >= cost:
		coins -= cost
		player_max_hp += 20
		player_hp = player_max_hp
		resources_changed.emit()
		player_stats_changed.emit()
		return true
	return false

func buy_damage_upgrade() -> bool:
	var cost: int = 40
	if coins >= cost:
		coins -= cost
		player_damage += 5
		resources_changed.emit()
		player_stats_changed.emit()
		return true
	return false

func buy_defense_upgrade() -> bool:
	var cost: int = 35
	if coins >= cost:
		coins -= cost
		player_defense += 3
		resources_changed.emit()
		player_stats_changed.emit()
		return true
	return false
