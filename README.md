# Apex Hunter - Idle Game Prototype

## Descrição

Apex Hunter é um protótipo funcional de jogo idle desenvolvido em Godot 4.5. O jogo apresenta mecânicas principais de coleta de recursos, criação de ferramentas, combate automático e progressão por ranks.

## Funcionalidades Implementadas

### 1. Sistema de Coleta
- **Cobre (Copper)**: Recurso básico que pode ser coletado (+1 moeda por coleta)
- **Estanho (Tin)**: Recurso avançado que pode ser coletado (+2 moedas por coleta)
- Interface com placeholders geométricos (retângulos coloridos)

### 2. Sistema de Criação
- **Ferramentas (Tools)**: Podem ser criadas combinando 2 Cobre + 1 Estanho
- Ferramentas aumentam o dano do jogador em +2
- Feedback visual sobre requisitos de criação

### 3. Sistema de Combate
- Combate automático em turnos
- Estatísticas do jogador: HP, Dano, Defesa
- Estatísticas do inimigo: HP, Dano, Defesa
- Inimigos ficam mais fortes após cada vitória
- Recompensas ao vencer: moedas e recursos

### 4. Sistema de Progressão (Ranks)
- **Rank G-**: Inicial (desbloqueado automaticamente)
- **Rank G**: Desbloqueado ao coletar 10 recursos totais
  - Bônus: +20 HP, +5 Dano, +2 Defesa
- **Rank G+**: Desbloqueado ao coletar 30 recursos totais
  - Bônus: +30 HP, +10 Dano, +5 Defesa

### 5. Sistema de Loja
- **Upgrade de HP**: +20 HP por 50 moedas
- **Upgrade de Dano**: +5 Dano por 40 moedas
- **Upgrade de Defesa**: +3 Defesa por 35 moedas

### 6. Classes de Personagem (Implementadas como base)
- **Guerreiro (Warrior)**: HP: 150, Dano: 12, Defesa: 8
- **Ranger**: HP: 100, Dano: 15, Defesa: 5
- **Mago (Mage)**: HP: 80, Dano: 20, Defesa: 3

## Estrutura do Projeto

```
apex-hunter/
├── .gitignore              # Ignora arquivos gerados pelo Godot
├── project.godot           # Arquivo de configuração do projeto Godot
├── icon.svg                # Ícone do projeto
├── scenes/
│   └── main.tscn          # Cena principal com a HUD
├── scripts/
│   ├── game_manager.gd    # Gerenciador principal do jogo
│   ├── main_hud.gd        # Controle da interface principal
│   ├── character_base.gd  # Classe base para personagens
│   ├── warrior.gd         # Classe Guerreiro
│   ├── ranger.gd          # Classe Ranger
│   └── mage.gd            # Classe Mago
└── resources/             # Pasta para recursos futuros
```

## Como Executar

1. Instale o [Godot Engine 4.3+](https://godotengine.org/download)
2. Abra o Godot Engine
3. Clique em "Import" e selecione o arquivo `project.godot`
4. Execute o projeto (F5) ou clique em "Run Project"

## Elementos de Placeholder

- **Recursos visuais**: Retângulos coloridos representam diferentes elementos
  - Laranja: Cobre
  - Cinza: Estanho
  - Verde: Jogador
  - Vermelho: Inimigo
- **Interface**: Layout com painéis coloridos para cada seção
  - Azul: Coleta
  - Verde: Criação
  - Vermelho: Combate
  - Roxo: Loja
  - Azul escuro: Progresso

## Próximas Iterações

- [ ] Adicionar sprites e arte visual
- [ ] Implementar sistema de save/load
- [ ] Adicionar mais tipos de recursos
- [ ] Expandir sistema de criação com mais receitas
- [ ] Adicionar mais inimigos e bosses
- [ ] Implementar sistema de conquistas
- [ ] Adicionar sistema de prestige
- [ ] Melhorar feedback visual e animações

## Tecnologias

- **Engine**: Godot 4.5
- **Linguagem**: GDScript
- **Padrões**: Singleton, Sinais (Signals), Componentes modulares

## Licença

Este é um projeto de protótipo educacional.