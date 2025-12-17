# Apex Hunter - Arquitetura do Sistema

## 📐 Diagrama de Arquitetura

```
┌─────────────────────────────────────────────────────────────────┐
│                         Main Scene (Control)                     │
│                         [main_hud.gd]                           │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                    GameManager (Node)                     │  │
│  │                  [game_manager.gd]                        │  │
│  │                                                           │  │
│  │  Resources:  [copper] [tin] [tools] [coins]              │  │
│  │  Player:     [hp] [damage] [defense]                     │  │
│  │  Enemy:      [hp] [damage] [defense]                     │  │
│  │  Rank:       [G-] [G] [G+]                               │  │
│  │                                                           │  │
│  │  Methods:                                                 │  │
│  │  • collect_copper() / collect_tin()                      │  │
│  │  • craft_tool()                                          │  │
│  │  • start_combat() / process_combat_round()              │  │
│  │  • buy_*_upgrade()                                       │  │
│  │  • check_rank_progression()                             │  │
│  │                                                           │  │
│  │  Signals:                                                 │  │
│  │  • resources_changed                                      │  │
│  │  • combat_started / combat_ended                         │  │
│  │  • rank_changed                                          │  │
│  │  • player_stats_changed / enemy_stats_changed           │  │
│  └──────────────────────────────────────────────────────────┘  │
│                              ↕                                   │
│                      [Signals Communication]                     │
│                              ↕                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                      UI Components                        │  │
│  │                                                           │  │
│  │  Collection:  [CopperBtn] [TinBtn] [Labels]             │  │
│  │  Crafting:    [CraftBtn] [ToolLabel] [InfoLabel]        │  │
│  │  Combat:      [StartBtn] [HPLabels] [StatusLabel]       │  │
│  │  Shop:        [BuyHPBtn] [BuyATKBtn] [BuyDEFBtn]        │  │
│  │  Progress:    [RankLabel] [StatsLabel]                  │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

## 🔄 Fluxo de Dados

### 1. Ação do Usuário → GameManager
```
User Click Button
      ↓
Button.pressed signal
      ↓
MainHUD._on_button_pressed()
      ↓
GameManager.action()
      ↓
Update internal state
      ↓
Emit signal
```

### 2. GameManager → UI Update
```
GameManager changes state
      ↓
Emit signal (e.g., resources_changed)
      ↓
MainHUD._on_signal()
      ↓
Update UI labels/displays
      ↓
User sees new values
```

## 📊 Diagrama de Fluxo de Jogo

```
┌─────────────┐
│  START      │
└──────┬──────┘
       │
       ↓
┌─────────────────┐
│ Collect         │ → Cobre (+1 coin) ou Estanho (+2 coins)
│ Resources       │
└──────┬──────────┘
       │
       ↓
┌─────────────────┐
│ Check Rank      │ → 10 recursos = Rank G
│ Progression     │    30 recursos = Rank G+
└──────┬──────────┘
       │
       ↓
┌─────────────────┐
│ Craft Tools?    │ → Yes: 2 Cu + 1 Sn = 1 Tool (+2 DMG)
└──────┬──────────┘
       │
       ↓
┌─────────────────┐
│ Buy Upgrades?   │ → HP (50c), ATK (40c), DEF (35c)
└──────┬──────────┘
       │
       ↓
┌─────────────────┐
│ Start Combat?   │ → Auto-combat every 1.5s
└──────┬──────────┘
       │
       ↓
┌─────────────────┐
│ Combat Loop     │ → Player attacks → Enemy attacks
│                 │    Check if anyone dead
└──────┬──────────┘
       │
       ↓
┌─────────────────┐
│ Victory?        │ → Yes: +20 coins, +2 Cu, +1 Sn
│                 │    Enemy gets stronger
│                 │ → No: No rewards, try again
└──────┬──────────┘
       │
       ↓
    [Loop back to Collect Resources]
```

## 🏗️ Estrutura de Classes

```
Node
├── GameManager (Singleton)
│   ├── Resource Management
│   ├── Combat System
│   ├── Rank System
│   └── Economy System
│
└── CharacterBase (Abstract)
    ├── Warrior
    ├── Ranger
    └── Mage
```

### Herança de CharacterBase

```
CharacterBase
│
├─ Properties:
│  • max_hp: int
│  • current_hp: int
│  • base_damage: int
│  • base_defense: int
│  • character_name: String
│
├─ Methods:
│  • take_damage(damage: int)
│  • heal(amount: int)
│  • is_alive() -> bool
│  • reset_hp()
│
└─ Children:
   ├─ Warrior (HP: 150, ATK: 12, DEF: 8)
   ├─ Ranger  (HP: 100, ATK: 15, DEF: 5)
   └─ Mage    (HP: 80,  ATK: 20, DEF: 3)
```

## 🔔 Sistema de Signals

### Signal Flow Chart

```
GameManager                          MainHUD
    │                                   │
    │  collect_copper()                 │
    ├──────────────────────────────────>│
    │  copper++, coins++                │
    │  resources_changed.emit()         │
    ├──────────────────────────────────>│
    │                                   │ _on_resources_changed()
    │                                   │ Update labels
    │                                   │
    │  start_combat()                   │
    ├──────────────────────────────────>│
    │  in_combat = true                 │
    │  combat_started.emit()            │
    ├──────────────────────────────────>│
    │                                   │ _on_combat_started()
    │                                   │ Disable button
    │                                   │
    │  [Combat Loop in _process()]      │
    │  process_combat_round()           │
    │  player_stats_changed.emit()      │
    ├──────────────────────────────────>│
    │                                   │ _on_player_stats_changed()
    │                                   │ Update HP label
    │                                   │
    │  end_combat()                     │
    │  combat_ended.emit()              │
    ├──────────────────────────────────>│
    │                                   │ _on_combat_ended()
    │                                   │ Enable button, show result
```

### Signals Table

| Signal | Emitter | Receivers | Purpose |
|--------|---------|-----------|---------|
| `resources_changed` | GameManager | MainHUD | Update resource displays |
| `combat_started` | GameManager | MainHUD | Disable combat button |
| `combat_ended` | GameManager | MainHUD | Enable button, show result |
| `rank_changed` | GameManager | MainHUD | Update rank display |
| `player_stats_changed` | GameManager | MainHUD | Update player stats |
| `enemy_stats_changed` | GameManager | MainHUD | Update enemy stats |

## 🎮 Game Loop

### Main Game Loop (60 FPS)
```
_process(delta):
    │
    ├─ Is in_combat?
    │  └─ Yes:
    │     ├─ combat_timer += delta
    │     └─ combat_timer >= 1.5s?
    │        └─ Yes:
    │           ├─ combat_timer = 0
    │           └─ process_combat_round()
    │
    └─ Continue
```

### Combat Round Flow
```
process_combat_round():
    │
    ├─ Calculate player_attack
    │  └─ max(MIN_DAMAGE, player_damage - enemy_defense)
    │
    ├─ Apply damage to enemy
    │  └─ enemy_hp -= player_attack
    │
    ├─ Check if enemy dead
    │  └─ Yes: end_combat(true) → RETURN
    │
    ├─ Calculate enemy_attack
    │  └─ max(MIN_DAMAGE, enemy_damage - player_defense)
    │
    ├─ Apply damage to player
    │  └─ player_hp -= enemy_attack
    │
    └─ Check if player dead
       └─ Yes: end_combat(false)
```

## 🎯 System Interactions

### Resource Collection → Rank Progression
```
collect_copper() or collect_tin()
    ↓
copper++ or tin++
    ↓
check_rank_progression()
    ↓
total_resources = copper + tin + tools
    ↓
if total >= threshold:
    ↓
    Increase rank
    Apply bonuses
    Emit rank_changed
```

### Crafting → Player Power
```
craft_tool()
    ↓
Check: copper >= 2 AND tin >= 1?
    ↓
Yes: 
    copper -= 2
    tin -= 1
    tools += 1
    player_damage += 2  ← Direct power increase
    Emit resources_changed
    Emit player_stats_changed
```

### Combat → Economy
```
Combat Victory
    ↓
coins += 20
copper += 2
tin += 1
    ↓
Emit resources_changed
    ↓
Player can buy upgrades with coins
```

## 🔐 Data Flow Security

### State Management
- ✅ All game state in GameManager (single source of truth)
- ✅ UI never modifies state directly
- ✅ All changes through GameManager methods
- ✅ Validation in GameManager before state changes

### Example: Shop Purchase
```
User clicks "Buy HP Upgrade"
    ↓
MainHUD._on_buy_hp_pressed()
    ↓
GameManager.buy_health_upgrade()
    ↓
Validate: coins >= cost?
    ↓
    Yes: 
        coins -= cost
        player_max_hp += 20
        Emit signals
        Return true
    No:
        Do nothing
        Return false
```

## 📦 Module Dependencies

```
project.godot (Root)
    │
    ├─ scenes/main.tscn
    │   └─ Uses: scripts/main_hud.gd
    │
    ├─ scripts/main_hud.gd
    │   └─ Depends on: scripts/game_manager.gd
    │
    ├─ scripts/game_manager.gd
    │   └─ Independent (No dependencies)
    │
    └─ scripts/character_*.gd
        └─ Depends on: scripts/character_base.gd
```

### Dependency Graph
```
character_base.gd (Base)
    ↑
    ├─ warrior.gd
    ├─ ranger.gd
    └─ mage.gd

game_manager.gd (Independent)
    ↑
    └─ main_hud.gd
        ↑
        └─ main.tscn
```

## 🔄 Extensibility Points

### Adding New Resource
1. Add variable in GameManager
2. Add collect method
3. Add UI elements in main.tscn
4. Add references in MainHUD
5. Connect to resources_changed signal

### Adding New Craft Recipe
1. Add method in GameManager (e.g., `craft_armor()`)
2. Define resource costs
3. Define resulting item and bonuses
4. Add UI button and label
5. Connect to existing signals

### Adding New Rank
1. Add to Rank enum
2. Add to rank_names dictionary
3. Add condition in check_rank_progression()
4. Define bonuses

### Adding New Enemy Type
1. Create enemy struct/class
2. Add enemy selection logic
3. Modify combat_started to set enemy type
4. Adjust rewards based on enemy type

## 🎨 UI-GameManager Binding

### Collection Section
```
UI Element           →  GameManager Property
────────────────────────────────────────────
CopperLabel         ←   copper
TinLabel            ←   tin
CollectCopperBtn    →   collect_copper()
CollectTinBtn       →   collect_tin()
```

### Crafting Section
```
UI Element           →  GameManager Property
────────────────────────────────────────────
ToolsLabel          ←   tools
CraftToolBtn        →   craft_tool()
```

### Combat Section
```
UI Element           →  GameManager Property
────────────────────────────────────────────
PlayerHPLabel       ←   player_hp, player_max_hp
EnemyHPLabel        ←   enemy_hp, enemy_max_hp
StartCombatBtn      →   start_combat()
CombatStatusLabel   ←   in_combat, combat result
```

### Shop Section
```
UI Element           →  GameManager Property
────────────────────────────────────────────
CoinsLabel          ←   coins
BuyHPBtn            →   buy_health_upgrade()
BuyDamageBtn        →   buy_damage_upgrade()
BuyDefenseBtn       →   buy_defense_upgrade()
```

### Progress Section
```
UI Element           →  GameManager Property
────────────────────────────────────────────
RankLabel           ←   current_rank
StatsLabel          ←   player_damage, player_defense, player_max_hp
```

## 🧩 Component Diagram

```
┌─────────────────────────────────────────────────┐
│              Apex Hunter Game                   │
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌──────────────────┐  ┌──────────────────┐   │
│  │  GameManager     │  │  MainHUD         │   │
│  │  (Logic Layer)   │←→│  (View Layer)    │   │
│  └──────────────────┘  └──────────────────┘   │
│          ↕                      ↕               │
│  ┌──────────────────┐  ┌──────────────────┐   │
│  │  Resource Sys    │  │  UI Components   │   │
│  │  Crafting Sys    │  │  - Buttons       │   │
│  │  Combat Sys      │  │  - Labels        │   │
│  │  Rank Sys        │  │  - Panels        │   │
│  │  Economy Sys     │  │  - Placeholders  │   │
│  └──────────────────┘  └──────────────────┘   │
│          ↕                                      │
│  ┌──────────────────────────────────────┐     │
│  │  Character System (Optional)          │     │
│  │  - CharacterBase                      │     │
│  │  - Warrior, Ranger, Mage             │     │
│  └──────────────────────────────────────┘     │
│                                                 │
└─────────────────────────────────────────────────┘
```

## 📝 Key Design Decisions

### 1. Singleton Pattern for GameManager
**Why**: 
- Single source of truth for game state
- Easy access from any script
- Prevents state duplication

**Trade-offs**:
- Global state (careful with testing)
- Tightly coupled to Godot's lifecycle

### 2. Signal-Based Communication
**Why**:
- Decoupled components
- Easy to extend
- Native Godot pattern

**Trade-offs**:
- Can be harder to trace flow
- Need to manage connections

### 3. Character Classes (Not Active in Prototype)
**Why**:
- Future extensibility
- Demonstrates OOP principles
- Easy to add class selection later

**Trade-offs**:
- Currently unused code
- Could be refactored if not needed

### 4. Placeholder UI
**Why**:
- Focus on functionality first
- Easy to replace with real art
- Quick to iterate

**Trade-offs**:
- Not visually polished
- Requires art pass later

## 🔍 Code Organization Principles

1. **Separation of Concerns**
   - GameManager = Logic
   - MainHUD = View
   - CharacterBase = Data Model

2. **Single Responsibility**
   - Each script has one main purpose
   - Methods are focused and short

3. **DRY (Don't Repeat Yourself)**
   - Reusable functions
   - Constants instead of magic numbers
   - Signal-based updates (one place)

4. **KISS (Keep It Simple)**
   - No over-engineering
   - Clear variable names
   - Straightforward logic

5. **Godot Best Practices**
   - Use node tree hierarchy
   - Leverage signals
   - Type hints everywhere
   - @onready for node references

---

**Document Version**: 1.0  
**Last Updated**: December 2024  
**For**: Apex Hunter Prototype v1.0
