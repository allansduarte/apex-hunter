# Apex Hunter - Design de Sistemas

## Visão Geral

Apex Hunter é um jogo idle com foco em coleta de recursos, criação de itens, combate automático e progressão incremental através de um sistema de ranks.

## Fluxo Principal do Jogo

1. **Coleta** → Obter recursos básicos (Cobre e Estanho)
2. **Criação** → Combinar recursos para criar Ferramentas
3. **Combate** → Lutar contra inimigos para ganhar recompensas
4. **Loja** → Gastar moedas em upgrades permanentes
5. **Progressão** → Avançar através dos ranks desbloqueando melhorias

## Sistema de Recursos

### Recursos Básicos

#### Cobre (Copper)
- Obtido através do botão "Collect" na seção de Collection
- Gera +1 moeda por coleta
- Usado na criação de ferramentas (2 unidades necessárias)

#### Estanho (Tin)
- Obtido através do botão "Collect" na seção de Collection
- Gera +2 moedas por coleta
- Usado na criação de ferramentas (1 unidade necessária)

#### Moedas (Coins)
- Moeda principal do jogo
- Obtidas através de:
  - Coleta de Cobre (+1)
  - Coleta de Estanho (+2)
  - Vitória em combate (+20)
- Usadas para comprar upgrades na loja

### Recursos Avançados

#### Ferramentas (Tools)
- Criadas combinando 2 Cobre + 1 Estanho
- Cada ferramenta aumenta o dano do jogador em +2
- Contam para a progressão de rank

## Sistema de Combate

### Mecânica de Combate
- Combate automático em turnos
- Intervalo de 1.5 segundos entre ataques
- Turnos alternados: Jogador ataca → Inimigo ataca

### Cálculo de Dano
```
Dano Real = max(1, Dano Base do Atacante - Defesa do Defensor)
```

### Vitória e Derrota
- **Vitória**: Jogador reduz HP do inimigo a 0
  - Recompensas: +20 moedas, +2 Cobre, +1 Estanho
  - Inimigo fica mais forte: +10 HP, +2 Dano, +1 Defesa
- **Derrota**: Inimigo reduz HP do jogador a 0
  - Sem penalidades, mas sem recompensas
- HP do jogador é restaurado ao máximo após cada combate

### Escalamento de Inimigos
Os inimigos se tornam progressivamente mais fortes após cada derrota:
- HP Base: 50 → Cresce +10 por derrota
- Dano Base: 8 → Cresce +2 por derrota
- Defesa Base: 3 → Cresce +1 por derrota

## Sistema de Ranks

### Progressão
Os ranks são desbloqueados baseado no total de recursos coletados:

#### Rank G- (Inicial)
- Disponível desde o início
- Estatísticas base:
  - HP: 100
  - Dano: 10
  - Defesa: 5

#### Rank G
- Requisito: 10 recursos totais (Cobre + Estanho + Ferramentas)
- Bônus ao desbloquear:
  - +20 HP (Total: 120)
  - +5 Dano (Total: 15)
  - +2 Defesa (Total: 7)

#### Rank G+
- Requisito: 30 recursos totais (Cobre + Estanho + Ferramentas)
- Bônus ao desbloquear:
  - +30 HP (Total: 150)
  - +10 Dano (Total: 25)
  - +5 Defesa (Total: 12)

### Bônus Permanentes
Os bônus de rank são permanentes e se acumulam com:
- Ferramentas criadas (+2 Dano cada)
- Upgrades da loja

## Sistema de Loja

### Upgrades Disponíveis

#### Upgrade de HP
- Custo: 50 moedas
- Efeito: +20 HP máximo
- HP atual é restaurado ao máximo após compra

#### Upgrade de Dano
- Custo: 40 moedas
- Efeito: +5 Dano

#### Upgrade de Defesa
- Custo: 35 moedas
- Efeito: +3 Defesa

### Estratégia de Compra
- Upgrades são permanentes e não têm limite
- Podem ser comprados múltiplas vezes
- O custo não aumenta (para o protótipo)

## Classes de Personagem

### Implementação Atual
As classes estão implementadas como código base mas não são selecionáveis no protótipo. Elas servem como fundação para futuras iterações.

#### Guerreiro (Warrior)
- Especialização: Tanque
- HP: 150 (Alto)
- Dano: 12 (Médio)
- Defesa: 8 (Alta)

#### Ranger
- Especialização: Balanceado
- HP: 100 (Médio)
- Dano: 15 (Alto)
- Defesa: 5 (Média)

#### Mago (Mage)
- Especialização: Vidro Canhão
- HP: 80 (Baixo)
- Dano: 20 (Muito Alto)
- Defesa: 3 (Baixa)

## Arquitetura Técnica

### Padrão Singleton
O `GameManager` usa o padrão Singleton para ser acessível globalmente:
```gdscript
static var instance: GameManager
```

### Sistema de Sinais (Signals)
O jogo usa sinais para comunicação desacoplada entre sistemas:
- `resources_changed`: Emitido quando recursos mudam
- `combat_started`: Emitido ao iniciar combate
- `combat_ended`: Emitido ao terminar combate
- `rank_changed`: Emitido quando o rank aumenta
- `player_stats_changed`: Emitido quando stats do jogador mudam
- `enemy_stats_changed`: Emitido quando stats do inimigo mudam

### Estrutura Modular
- `GameManager`: Lógica central do jogo
- `MainHUD`: Controle da interface
- `CharacterBase`: Classe base para personagens
- Classes de personagem herdam de `CharacterBase`

## Balanceamento

### Economia
- Coleta de recursos é gratuita e instantânea
- Criação consome recursos mas aumenta poder
- Combate é arriscado mas dá melhores recompensas
- Loja oferece progressão garantida mas cara

### Curva de Progressão
1. **Início (Rank G-)**: Coletar recursos e criar primeira ferramenta
2. **Meio (Rank G)**: Começar a combater e comprar primeiro upgrade
3. **Final (Rank G+)**: Combater inimigos escalados e acumular recursos

### Loops de Gameplay
- **Loop Curto**: Coletar → Criar → Melhorar
- **Loop Médio**: Combater → Ganhar moedas → Comprar upgrades
- **Loop Longo**: Acumular recursos → Subir rank → Desbloquear poder

## Futuras Expansões

### Mecânicas Planejadas
- Sistema de save/load automático
- Mais tipos de recursos e receitas
- Sistema de conquistas
- Prestige com bônus permanentes
- Mais inimigos e bosses
- Sistema de equipamentos
- Árvore de habilidades

### Melhorias de UI
- Animações de feedback
- Efeitos visuais para combate
- Barra de progresso para ranks
- Notificações de desbloqueios
- Sons e música

### Balanceamento Avançado
- Custos crescentes para upgrades
- Multiplicadores idle
- Eventos aleatórios
- Sistema de raridade para drops
