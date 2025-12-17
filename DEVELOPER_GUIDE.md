# Apex Hunter - Guia do Desenvolvedor

## Configuração Inicial

### Requisitos
- Godot Engine 4.3 ou superior
- Git (para controle de versão)

### Primeiro Setup
1. Clone o repositório:
   ```bash
   git clone https://github.com/allansduarte/apex-hunter.git
   cd apex-hunter
   ```

2. Abra o Godot Engine

3. Clique em "Import" e selecione o arquivo `project.godot`

4. O projeto será importado e você pode começar a trabalhar

## Estrutura do Código

### GameManager (scripts/game_manager.gd)
Gerenciador central do jogo que contém:
- Estado dos recursos (copper, tin, tools, coins)
- Sistema de ranks
- Estatísticas do jogador e inimigo
- Lógica de combate
- Sistema de loja

**Principais Métodos:**
- `collect_copper()` / `collect_tin()`: Coleta de recursos
- `craft_tool()`: Criação de ferramentas
- `start_combat()`: Inicia combate automático
- `process_combat_round()`: Processa uma rodada de combate
- `buy_*_upgrade()`: Compra upgrades na loja

### MainHUD (scripts/main_hud.gd)
Controla toda a interface do usuário:
- Conecta sinais do GameManager
- Atualiza labels e displays
- Gerencia interações de botões

**Padrão de Atualização:**
```gdscript
# GameManager emite sinal
game_manager.resources_changed.emit()

# MainHUD recebe e atualiza UI
func _on_resources_changed() -> void:
    copper_label.text = "Copper: %d" % game_manager.copper
```

### Sistema de Classes

#### CharacterBase (scripts/character_base.gd)
Classe base abstrata para personagens com:
- Atributos básicos (HP, Dano, Defesa)
- Métodos de dano e cura
- Sistema de vida

#### Classes Específicas
- **Warrior** (scripts/warrior.gd): Tanque com alta defesa
- **Ranger** (scripts/ranger.gd): Balanceado
- **Mage** (scripts/mage.gd): Alto dano, baixa defesa

## Adicionando Novas Funcionalidades

### Adicionar Novo Recurso

1. **No GameManager:**
```gdscript
# Adicione a variável
var novo_recurso: int = 0

# Adicione método de coleta
func collect_novo_recurso() -> void:
    novo_recurso += 1
    resources_changed.emit()
```

2. **No MainHUD:**
```gdscript
# Adicione referência ao label
@onready var novo_recurso_label: Label = $Path/To/Label

# Atualize no signal handler
func _on_resources_changed() -> void:
    novo_recurso_label.text = "Novo: %d" % game_manager.novo_recurso
```

3. **Na Scene (main.tscn):**
- Adicione UI elements no editor Godot
- Configure os node paths corretamente

### Adicionar Nova Receita de Craft

```gdscript
func craft_novo_item() -> bool:
    var custo_recurso1: int = 3
    var custo_recurso2: int = 2
    
    if recurso1 >= custo_recurso1 and recurso2 >= custo_recurso2:
        recurso1 -= custo_recurso1
        recurso2 -= custo_recurso2
        novo_item += 1
        resources_changed.emit()
        return true
    return false
```

### Adicionar Novo Rank

```gdscript
# Adicione ao enum
enum Rank { G_MINUS, G, G_PLUS, S_MINUS }

# Adicione ao dicionário de nomes
var rank_names: Dictionary = {
    Rank.G_MINUS: "G-",
    Rank.G: "G",
    Rank.G_PLUS: "G+",
    Rank.S_MINUS: "S-"
}

# Adicione lógica de progressão
func check_rank_progression() -> void:
    # ... código existente ...
    elif current_rank == Rank.G_PLUS and total_resources >= 60:
        current_rank = Rank.S_MINUS
        # Bônus...
        rank_changed.emit()
```

## Sistema de Sinais

### Sinais Disponíveis no GameManager

| Sinal | Quando é Emitido | Uso |
|-------|------------------|-----|
| `resources_changed` | Recursos ou moedas mudam | Atualizar UI de recursos |
| `combat_started` | Combate começa | Desabilitar botão, mostrar status |
| `combat_ended` | Combate termina | Habilitar botão, mostrar resultado |
| `rank_changed` | Rank aumenta | Mostrar notificação, atualizar display |
| `player_stats_changed` | Stats do jogador mudam | Atualizar displays de stats |
| `enemy_stats_changed` | Stats do inimigo mudam | Atualizar HP do inimigo |

### Como Conectar Sinais

```gdscript
# No _ready() do receptor
game_manager.seu_sinal.connect(_on_seu_sinal)

# Método handler
func _on_seu_sinal() -> void:
    # Sua lógica aqui
    pass
```

## Debugging

### Mensagens de Debug

```gdscript
# Adicione prints para debug
func collect_copper() -> void:
    copper += 1
    print("Copper coletado: ", copper)  # Debug
    resources_changed.emit()
```

### Console do Godot
- Use F3 para abrir/fechar o console durante execução
- Pressione F4 para pausar/despausar o jogo
- Pressione F5 para executar o projeto

### Breakpoints
- Clique na margem esquerda do editor de código para adicionar breakpoint
- Execute em modo debug (F6) para parar em breakpoints

## Convenções de Código

### Nomenclatura
- **Variáveis**: snake_case (ex: `player_hp`, `enemy_damage`)
- **Funções**: snake_case (ex: `collect_copper()`, `start_combat()`)
- **Classes**: PascalCase (ex: `GameManager`, `CharacterBase`)
- **Constantes**: SCREAMING_SNAKE_CASE (ex: `MAX_LEVEL`, `BASE_COST`)
- **Sinais**: snake_case (ex: `resources_changed`, `combat_ended`)

### Tipagem
Sempre use tipagem explícita:
```gdscript
# ✓ Correto
var copper: int = 0
func get_damage() -> int:
    return player_damage

# ✗ Evite
var copper = 0
func get_damage():
    return player_damage
```

### Comentários
```gdscript
# Comentário de uma linha

## Comentário de seção importante

func exemplo() -> void:
    # Explique lógica complexa
    var resultado: int = calculo_complexo()
```

## Testando Mudanças

### Checklist de Teste
- [ ] O código compila sem erros
- [ ] Todas as funcionalidades principais funcionam
- [ ] UI atualiza corretamente
- [ ] Sinais são emitidos quando esperado
- [ ] Não há erros no console
- [ ] Performance está adequada

### Teste Manual Básico
1. Colete recursos (Cobre e Estanho)
2. Crie uma ferramenta
3. Inicie um combate
4. Verifique progressão de rank
5. Compre um upgrade na loja
6. Verifique se todas as labels atualizam

## Build e Export

### Configuração de Export (Futuro)
1. Vá em Project → Export
2. Adicione preset para sua plataforma
3. Configure opções de export
4. Clique em Export Project

### Plataformas Suportadas
- Windows
- Linux
- macOS
- Web (HTML5)
- Android
- iOS

## Troubleshooting

### Problema: Sinais não funcionam
**Solução:** Verifique se:
- O sinal foi declarado com `signal nome_do_sinal`
- A conexão foi feita no `_ready()`
- O método handler existe e tem o nome correto

### Problema: UI não atualiza
**Solução:** Verifique se:
- O sinal correto está sendo emitido
- O handler está conectado
- Os node paths (@onready) estão corretos
- A scene está estruturada como esperado

### Problema: Erro "Invalid get index"
**Solução:** Verifique se:
- Os node paths estão corretos
- Os nós existem na scene
- A hierarquia de nós não mudou

### Problema: Combate não funciona
**Solução:** Verifique se:
- `in_combat` está sendo setado corretamente
- O timer está acumulando no `_process()`
- As estatísticas de combate estão inicializadas

## Recursos Úteis

### Documentação Oficial
- [Godot Docs](https://docs.godotengine.org/)
- [GDScript Reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
- [Best Practices](https://docs.godotengine.org/en/stable/tutorials/best_practices/)

### Comunidade
- [Godot Forums](https://forum.godotengine.org/)
- [Reddit r/godot](https://reddit.com/r/godot)
- [Discord da Godot](https://discord.gg/zH7NUgz)

## Próximos Passos

Para expandir o projeto, considere implementar:

1. **Sistema de Save/Load**
   - Use `ConfigFile` ou JSON
   - Salve estado do jogo periodicamente

2. **Mais Conteúdo**
   - Novos recursos e receitas
   - Mais ranks e progressão
   - Diferentes tipos de inimigos

3. **Melhorias de UI**
   - Sprites e arte visual
   - Animações e efeitos
   - Sons e música

4. **Sistemas Avançados**
   - Idle gains (ganhos offline)
   - Prestige system
   - Conquistas

5. **Polimento**
   - Balanceamento
   - Feedback do jogador
   - Tutorial in-game
