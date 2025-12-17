# Apex Hunter - Layout da Interface

## Visão Geral da Interface

A interface está organizada em seções com placeholders de cores geométricas para identificação visual.

```
┌─────────────────────────────────────────────────────────────────────┐
│                    APEX HUNTER - Prototype                          │
├─────────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────┬─────────────────────────┐             │
│  │     COLLECTION          │       CRAFTING          │             │
│  │   (Azul - #2D4D66)      │   (Verde - #4D664D)     │             │
│  ├─────────────────────────┼─────────────────────────┤             │
│  │ [🟧] Copper: 0          │ [⬛] Tools: 0            │             │
│  │      [Collect]          │                         │             │
│  │                         │ Recipe: 2 Copper + 1 Tin│             │
│  │ [⬜] Tin: 0             │                         │             │
│  │      [Collect]          │    [Craft Tool]         │             │
│  └─────────────────────────┴─────────────────────────┘             │
│  ┌─────────────────────────┬─────────────────────────┐             │
│  │       COMBAT            │         SHOP            │             │
│  │   (Vermelho - #663333)  │   (Roxo - #664D80)      │             │
│  ├─────────────────────────┼─────────────────────────┤             │
│  │ [🟩] Player HP: 100/100 │    Coins: 100           │             │
│  │                         │                         │             │
│  │ [🟥] Enemy HP: 50/50    │ [Buy HP Upgrade]        │             │
│  │                         │     (50 coins)          │             │
│  │ Status: Ready to fight! │                         │             │
│  │                         │ [Buy Damage Upgrade]    │             │
│  │   [Start Combat]        │     (40 coins)          │             │
│  │                         │                         │             │
│  │                         │ [Buy Defense Upgrade]   │             │
│  │                         │     (35 coins)          │             │
│  └─────────────────────────┴─────────────────────────┘             │
│  ┌───────────────────────────────────────────────────┐             │
│  │                    PROGRESS                        │             │
│  │                 (Azul escuro - #4D4D80)            │             │
│  ├───────────────────────────────────────────────────┤             │
│  │                   Rank: G-                         │             │
│  │           ATK: 10 | DEF: 5 | HP: 100              │             │
│  └───────────────────────────────────────────────────┘             │
└─────────────────────────────────────────────────────────────────────┘
```

## Seções da Interface

### 1. Cabeçalho
- **Título**: "APEX HUNTER - Prototype"
- Fonte grande (32px) centralizada

### 2. Seção de Coleta (Collection) - Superior Esquerda
**Cor de fundo**: Azul (#2D4D66)

**Elementos:**
- 🟧 **Placeholder Cobre**: Retângulo laranja (40x40px)
  - Label: "Copper: X"
  - Botão: "Collect"
  
- ⬜ **Placeholder Estanho**: Retângulo cinza claro (40x40px)
  - Label: "Tin: X"
  - Botão: "Collect"

**Função**: Coletar recursos básicos do jogo

### 3. Seção de Criação (Crafting) - Superior Direita
**Cor de fundo**: Verde (#4D664D)

**Elementos:**
- ⬛ **Placeholder Ferramenta**: Retângulo cinza (40x40px)
  - Label: "Tools: X"
  
- Label informativo: "Recipe: 2 Copper + 1 Tin"
- Botão: "Craft Tool"

**Função**: Combinar recursos para criar ferramentas

### 4. Seção de Combate (Combat) - Meio Esquerda
**Cor de fundo**: Vermelho escuro (#663333)

**Elementos:**
- 🟩 **Placeholder Jogador**: Retângulo verde (40x40px)
  - Label: "Player HP: X/X"
  
- 🟥 **Placeholder Inimigo**: Retângulo vermelho (40x40px)
  - Label: "Enemy HP: X/X"
  
- Label de status: "Ready to fight!" / "Combat in progress..." / "Victory!" / "Defeated."
- Botão: "Start Combat" (desabilitado durante combate)

**Função**: Sistema de combate automático

### 5. Seção de Loja (Shop) - Meio Direita
**Cor de fundo**: Roxo (#664D80)

**Elementos:**
- Label: "Coins: X"
- Botão: "Buy HP Upgrade (50 coins)"
  - Efeito: +20 HP máximo
- Botão: "Buy Damage Upgrade (40 coins)"
  - Efeito: +5 Dano
- Botão: "Buy Defense Upgrade (35 coins)"
  - Efeito: +3 Defesa

**Função**: Gastar moedas em upgrades permanentes

### 6. Seção de Progresso (Progress) - Inferior
**Cor de fundo**: Azul escuro (#4D4D80)

**Elementos:**
- Label grande: "Rank: X" (G-, G, ou G+)
- Label de estatísticas: "ATK: X | DEF: X | HP: X"

**Função**: Mostrar progressão e estatísticas atuais do jogador

## Hierarquia de Nós (Scene Tree)

```
Main (Control)
├── GameManager (Node)
├── ColorRect (Background)
└── MarginContainer
    └── VBoxContainer
        ├── TitleLabel
        ├── HSeparator
        ├── GridContainer (2 columns)
        │   ├── CollectionSection (PanelContainer)
        │   │   └── CollectionContent (VBoxContainer)
        │   │       ├── CollectionTitle
        │   │       ├── CopperRow (HBoxContainer)
        │   │       │   ├── CopperPlaceholder (ColorRect)
        │   │       │   ├── CopperLabel
        │   │       │   └── CollectCopperBtn
        │   │       └── TinRow (HBoxContainer)
        │   │           ├── TinPlaceholder (ColorRect)
        │   │           ├── TinLabel
        │   │           └── CollectTinBtn
        │   │
        │   ├── CraftingSection (PanelContainer)
        │   │   └── CraftingContent (VBoxContainer)
        │   │       ├── CraftingTitle
        │   │       ├── ToolsRow (HBoxContainer)
        │   │       │   ├── ToolPlaceholder (ColorRect)
        │   │       │   └── ToolsLabel
        │   │       ├── CraftInfoLabel
        │   │       └── CraftToolBtn
        │   │
        │   ├── CombatSection (PanelContainer)
        │   │   └── CombatContent (VBoxContainer)
        │   │       ├── CombatTitle
        │   │       ├── PlayerRow (HBoxContainer)
        │   │       │   ├── PlayerPlaceholder (ColorRect)
        │   │       │   └── PlayerHPLabel
        │   │       ├── EnemyRow (HBoxContainer)
        │   │       │   ├── EnemyPlaceholder (ColorRect)
        │   │       │   └── EnemyHPLabel
        │   │       ├── CombatStatusLabel
        │   │       └── StartCombatBtn
        │   │
        │   └── ShopSection (PanelContainer)
        │       └── ShopContent (VBoxContainer)
        │           ├── ShopTitle
        │           ├── CoinsLabel
        │           ├── BuyHPBtn
        │           ├── BuyDamageBtn
        │           └── BuyDefenseBtn
        │
        └── ProgressSection (PanelContainer)
            └── ProgressContent (VBoxContainer)
                ├── ProgressTitle
                ├── RankLabel
                └── StatsLabel
```

## Paleta de Cores

### Cores de Fundo das Seções
| Seção | Cor | Hex | Representação |
|-------|-----|-----|---------------|
| Collection | Azul | #334D66 | Recursos naturais |
| Crafting | Verde | #4D664D | Crescimento/Criação |
| Combat | Vermelho | #663333 | Perigo/Ação |
| Shop | Roxo | #664D80 | Comércio/Premium |
| Progress | Azul Escuro | #4D4D80 | Evolução |

### Cores dos Placeholders
| Elemento | Cor | Hex | Representação |
|----------|-----|-----|---------------|
| Cobre | Laranja | #CC8033 | Metal cobre |
| Estanho | Cinza Claro | #999999 | Metal estanho |
| Ferramenta | Cinza | #808080 | Metal trabalhado |
| Jogador | Verde | #33CC33 | Aliado/Vida |
| Inimigo | Vermelho | #CC3333 | Hostil/Perigo |

### Fundo Principal
| Elemento | Cor | Hex |
|----------|-----|-----|
| Background | Cinza Escuro | #262633 |

## Responsividade

A interface usa containers do Godot para responsividade:
- **MarginContainer**: Adiciona margens de 20px em todos os lados
- **VBoxContainer**: Organiza elementos verticalmente
- **HBoxContainer**: Organiza elementos horizontalmente
- **GridContainer**: Grade 2x2 para as seções principais
- **size_flags**: Elementos se expandem para preencher espaço

## Fontes e Tamanhos

| Elemento | Tamanho | Uso |
|----------|---------|-----|
| Título Principal | 32px | "APEX HUNTER - Prototype" |
| Títulos de Seção | 24px | "COLLECTION", "CRAFTING", etc. |
| Labels de Status | 20px | Rank display |
| Labels de Recursos | 18px | Contadores de recursos |
| Labels Informativos | 16px | Stats display |
| Labels Pequenos | 14px | Informações de receitas |

## Interatividade

### Botões
Todos os botões usam o estilo padrão do Godot:
- **Normal**: Fundo cinza claro
- **Hover**: Fundo cinza mais claro
- **Pressed**: Fundo cinza escuro
- **Disabled**: Fundo cinza transparente com texto cinza

### Feedback Visual
- Labels atualizam instantaneamente ao mudar valores
- Botões desabilitam durante estados inválidos
- Mensagens de status aparecem em labels dedicadas

## Acessibilidade

### Contraste
- Texto branco em fundos escuros
- Placeholders coloridos com cores distintas
- Separadores visuais entre seções

### Hierarquia
- Títulos maiores que conteúdo
- Agrupamento lógico de elementos
- Espaçamento consistente (10-15px)

## Expansão Futura

### Sugestões de Melhoria
1. **Animações**
   - Transição suave de valores
   - Efeitos de clique em botões
   - Feedback de combate animado

2. **Sprites**
   - Substituir ColorRect por Sprites
   - Adicionar ícones aos botões
   - Background decorativo

3. **Partículas**
   - Efeitos ao coletar recursos
   - Efeitos de combate
   - Efeitos de level up

4. **Sons**
   - SFX para clicks
   - SFX para coleta
   - SFX para combate
   - Música de fundo

5. **Notificações**
   - Toast notifications para eventos
   - Highlight em upgrades desbloqueados
   - Animação de rank up
