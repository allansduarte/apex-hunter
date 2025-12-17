# Apex Hunter - Referência Rápida

## 📋 Atalho de Comandos

### Recursos
| Recurso | Como Obter | Valor | Uso |
|---------|------------|-------|-----|
| 🟧 Cobre | Botão "Collect" | +1 moeda | Crafting (2x) |
| ⬜ Estanho | Botão "Collect" | +2 moedas | Crafting (1x) |
| ⬛ Ferramenta | Craft (2 Cu + 1 Sn) | +2 Dano | Aumenta poder |
| 💰 Moedas | Coleta / Combate | - | Comprar upgrades |

### Receitas de Crafting
```
🟧🟧 + ⬜ = ⬛
(2 Copper + 1 Tin = 1 Tool)
```

### Sistema de Combate
```
Jogador Ataca → Inimigo Perde HP
Inimigo Ataca → Jogador Perde HP
Repeat até alguém chegar a 0 HP
```

**Cálculo de Dano:**
```
Dano Real = max(1, Dano Atacante - Defesa Defensor)
```

### Progressão de Ranks

| Rank | Requisito | Bônus |
|------|-----------|-------|
| 🔰 G- | Inicial | Base: 100 HP, 10 ATK, 5 DEF |
| 🔷 G | 10 recursos | +20 HP, +5 ATK, +2 DEF |
| 💎 G+ | 30 recursos | +30 HP, +10 ATK, +5 DEF |

**Recursos totais** = Cobre + Estanho + Ferramentas

### Loja (Shop)

| Item | Custo | Efeito |
|------|-------|--------|
| ❤️ HP Upgrade | 50 💰 | +20 HP Máximo |
| ⚔️ Damage Upgrade | 40 💰 | +5 Dano |
| 🛡️ Defense Upgrade | 35 💰 | +3 Defesa |

## 🎮 Estratégias

### Início do Jogo (Rank G-)
1. Colete 2 Cobre + 1 Estanho
2. Crie sua primeira ferramenta
3. Continue coletando até ter 10 recursos totais
4. Avance para Rank G

### Meio do Jogo (Rank G)
1. Junte 50+ moedas
2. Compre upgrades da loja (priorize Dano)
3. Tente o primeiro combate
4. Continue até 30 recursos totais
5. Avance para Rank G+

### Final do Jogo (Rank G+)
1. Alterne entre combate e upgrades
2. Derrote inimigos progressivamente mais fortes
3. Maximize seus stats
4. Domine o protótipo!

## 💡 Dicas e Truques

### Economia
- ✅ Coletar Estanho dá mais moedas (2 vs 1)
- ✅ Vitórias em combate dão 20 moedas + recursos
- ✅ Ferramentas dão bônus permanente de dano
- ❌ Derrotas não dão penalidade, mas não dão recompensa

### Combate
- ✅ Compre upgrades antes de lutar
- ✅ Crie ferramentas para mais dano
- ✅ Inimigos ficam mais fortes após cada derrota
- ❌ Não é possível cancelar combate em andamento

### Progressão
- ✅ Ranks desbloqueiam bônus massivos
- ✅ Todos os bônus são permanentes
- ✅ Não há limite para compras da loja
- ✅ HP é restaurado após cada combate

### Ordem Recomendada de Upgrades
1. **Dano** (melhor custo-benefício)
2. **Defesa** (reduz dano recebido)
3. **HP** (mais caro, mas útil)

## 📊 Tabela de Referência de Stats

### Stats Base por Rank

| Rank | HP | ATK | DEF |
|------|----|----|-----|
| G- | 100 | 10 | 5 |
| G | 120 | 15 | 7 |
| G+ | 150 | 25 | 12 |

### Escalamento de Inimigos

| Vitórias | HP | ATK | DEF |
|----------|----|----|-----|
| 0 | 50 | 8 | 3 |
| 1 | 60 | 10 | 4 |
| 2 | 70 | 12 | 5 |
| 3 | 80 | 14 | 6 |
| +1 | +10 | +2 | +1 |

## 🔢 Fórmulas Importantes

### Cálculo de Dano
```
Dano_Real = max(1, ATK_atacante - DEF_defensor)
```
Dano mínimo é sempre 1, mesmo com defesa alta.

### Custo-Benefício de Upgrades

| Upgrade | Custo | Benefício | C/B |
|---------|-------|-----------|-----|
| Damage | 40 | +5 ATK | 8 moedas/ponto |
| Defense | 35 | +3 DEF | 11.67 moedas/ponto |
| HP | 50 | +20 HP | 2.5 moedas/ponto |

**Observação**: Dano tem melhor C/B para combate ofensivo!

### Tempo Aproximado de Combate

Assumindo stats balanceadas:
```
Turnos = ceil(HP_inimigo / Dano_Real_jogador)
Tempo ≈ Turnos × 1.5 segundos
```

Exemplo: 50 HP inimigo vs 5 de dano real = 10 turnos = 15 segundos

## 🎯 Objetivos do Protótipo

### Curto Prazo
- [ ] Coletar 10 recursos
- [ ] Craftar primeira ferramenta
- [ ] Atingir Rank G
- [ ] Comprar primeiro upgrade
- [ ] Vencer primeiro combate

### Médio Prazo
- [ ] Coletar 30 recursos
- [ ] Craftar 5 ferramentas
- [ ] Atingir Rank G+
- [ ] Comprar todos os tipos de upgrade
- [ ] Vencer 3 combates seguidos

### Longo Prazo
- [ ] Acumular 500+ moedas
- [ ] Craftar 10+ ferramentas
- [ ] Vencer 10+ combates
- [ ] Maximizar stats (comprar múltiplos upgrades)
- [ ] Dominar o sistema de progressão

## ⚠️ Avisos Importantes

### O Que NÃO Fazer
- ❌ Não tente combate sem upgrades (difícil no início)
- ❌ Não ignore a criação de ferramentas (bônus permanente)
- ❌ Não gaste todas as moedas sem planejar
- ❌ Não subestime o escalamento de inimigos

### O Que SEMPRE Fazer
- ✅ Colete recursos consistentemente
- ✅ Crie ferramentas quando possível
- ✅ Compre upgrades antes de combates difíceis
- ✅ Monitore seus stats na seção Progress
- ✅ Planeje sua progressão

## 🔄 Loop Ideal do Jogo

```
1. Coleta (Cobre/Estanho)
   ↓
2. Criação (Ferramentas)
   ↓
3. Compra (Upgrades)
   ↓
4. Combate (Vitória = Recompensas)
   ↓
5. Progressão (Rank Up)
   ↓
(Volta para 1)
```

## 📱 Atalhos de Teclado (Futuro)

*Atualmente não implementado no protótipo*

Sugestões para implementação futura:
- `C` - Coletar Cobre
- `T` - Coletar Estanho
- `F` - Craftar Ferramenta
- `Space` - Iniciar Combate
- `1/2/3` - Comprar upgrades na loja

## 🐛 Comportamentos Conhecidos

### Esperados
- Combate não pode ser cancelado após iniciar
- HP restaura completamente após combate
- Inimigos ficam permanentemente mais fortes
- Não há limite de recursos ou moedas

### Limitações do Protótipo
- Sem sistema de save/load
- Sem animações ou efeitos visuais avançados
- Sem sons ou música
- Interface placeholder (formas geométricas)
- Classes de personagem implementadas mas não selecionáveis

## 📈 Registro de Progressão

Use esta tabela para acompanhar seu progresso:

| Milestone | Concluído | Tempo |
|-----------|-----------|-------|
| Primeira coleta | ☐ | ___ |
| Primeiro craft | ☐ | ___ |
| Rank G | ☐ | ___ |
| Primeiro upgrade | ☐ | ___ |
| Primeiro combate vencido | ☐ | ___ |
| Rank G+ | ☐ | ___ |
| 10 combates vencidos | ☐ | ___ |
| 500 moedas acumuladas | ☐ | ___ |

## 🎓 Glossário

| Termo | Significado |
|-------|-------------|
| **Idle Game** | Jogo que progride mesmo com pouca interação |
| **Crafting** | Sistema de criação de itens |
| **Placeholder** | Elemento temporário visual |
| **Rank** | Nível de progressão do jogador |
| **Stats** | Estatísticas (HP, ATK, DEF) |
| **Upgrade** | Melhoria permanente |
| **Escalamento** | Aumento progressivo de dificuldade |
| **C/B** | Custo-Benefício |

## 🔗 Links Úteis

- [README.md](README.md) - Visão geral do projeto
- [GAME_DESIGN.md](GAME_DESIGN.md) - Design detalhado dos sistemas
- [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md) - Guia técnico para desenvolvedores
- [UI_LAYOUT.md](UI_LAYOUT.md) - Layout e estrutura da interface

---

**Versão do Protótipo**: 1.0  
**Engine**: Godot 4.5  
**Última Atualização**: Dezembro 2024
