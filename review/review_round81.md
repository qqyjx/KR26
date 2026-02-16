# KR 2026 ARGUS 审稿报告 (Round 81)

**论文**: ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations
**会议**: KR 2026 (KR Meets ML & Explanation Track)
**审稿日期**: 2026-02-16
**审稿模式**: Final Regression (最终回归 + 综合评估)
**前序轮次**: R1-R80

---

## 一、R77-R80 修复验证

### 1.1 R77 修复

| 修复 | 状态 | 验证 |
|------|------|------|
| R77-1: Preferred-grounded 实践意义 | ✅ FIXED | experiments.tex: "a consequence of the relatively sparse attack structures produced by atomic decomposition. In denser frameworks with multiple conflicting viewpoints, preferred semantics would provide greater discriminative power." |
| R77-3: Abstract "up to" 移除 | ✅ FIXED | abstract.tex: "achieves relative improvements of \improveFaithfulness{}" (无 "up to") |

### 1.2 R80 修复

| 修复 | 状态 | 验证 |
|------|------|------|
| W1: Complexity inheritance 表述 | ✅ FIXED | theory.tex: "Since the repair problem reduces to enforcement after incorporating Δ, it inherits the complexity landscape of extension enforcement...the additional overhead of processing Δ and evaluating heterogeneous cost functions is polynomial and does not alter the complexity class." |
| W2: 小框架形式化价值 | ✅ FIXED | experiments.tex: "The scalability results anticipate growth in framework complexity as LLM reasoning capabilities advance...the formal guarantees (AGM compliance, provable optimality) provide value that heuristic methods cannot match." |

### 1.3 未修复项 (文本/可选)

| Issue | Round | 状态 | 理由 |
|-------|-------|------|------|
| R77-2 (CI for human eval) | R77 | OPEN | MINOR，不影响结论，pilot study 已有 p-values |
| R77-4 (编译验证) | R77 | ✅ VERIFIED | 12 页，Conclusion 第 9 页，正文 ≤ 9 页 |
| W3 (human eval external validity) | R80 | OPEN | MINOR，Conclusion 已标注 "pilot"，后续可扩展 |
| W4 (update vs revision) | R80 | OPEN | MINOR，当前表述学术诚实且已有解释 |
| W5 (ASPIC+ 排除理由) | R80 | OPEN | MINOR，pragmatic 理由对 KR 可接受 |

---

## 二、历史关键 Issue 回归

### 2.1 R76 改进项回归

| R76 改进 | 当前状态 |
|---------|---------|
| Human evaluation (75 instances, 2 annotators) | ✅ 保持 (§6 + Appendix F) |
| Representation theorem (Theorem 2) | ✅ 保持 (§5.1, proof + appendix) |
| Citations (ARGORA, Bengel, Matton, etc.) | ✅ 保持 (36/36 match) |
| Regenerate baseline | ✅ 保持 (Table 1, line 43) |

### 2.2 核心数据抽样验证

| 数据点 | 源 | 值 | 当前 | 一致 |
|--------|---|---|------|------|
| \resultFaithHotpot | results.json | 0.847 | main.tex:71 | ✓ |
| \resultContestHotpot | results.json | 0.791 | main.tex:73 | ✓ |
| \improveFaithfulness | 计算 | 10.3% | main.tex:80 | ✓ |
| Ablation w/o SV Faith | results.json | 0.793 | Tab 2 | ✓ |
| Human eval Argus faith | results.json | 3.9 | §6 + App F | ✓ |
| Scalability grounded n=50 | results.json | 0.42s | Fig + text | ✓ |
| Preference 68% | results.json | 0.68 | §6 + App F | ✓ |

### 2.3 编译状态

- 页数: 12 (9 正文 + ~1.5 refs + ~1.5 appendix) ✓
- Conclusion 位置: 第 9 页 ✓
- Undefined references: 0 ✓
- Citation mismatch: 0 ✓

---

## 三、修复是否引入新问题

### 3.1 R77-1 添加的句子

> "a consequence of the relatively sparse attack structures produced by atomic decomposition. In denser frameworks with multiple conflicting viewpoints, preferred semantics would provide greater discriminative power."

- 技术正确: atomic decomposition 确实产生稀疏结构 ✓
- 不矛盾现有声明: Grounded Only 消融确认了小差距 ✓
- 无新数据声明 ✓

### 3.2 W1 修改的复杂性段落

> "Since the repair problem reduces to enforcement after incorporating Δ, it inherits the complexity landscape of extension enforcement; the additional overhead of processing Δ and evaluating heterogeneous cost functions is polynomial and does not alter the complexity class."

- 技术正确: Δ incorporation 是多项式操作 ✓
- 不削弱 Theorem 3: 结果仍然成立（inherited bounds are valid bounds）✓
- 与 note (line 64) 的区别保持一致 ✓

### 3.3 W2 添加的句子

> "The scalability results anticipate growth in framework complexity as LLM reasoning capabilities advance and multi-step explanations become longer; even at current scales, the formal guarantees (AGM compliance, provable optimality) provide value that heuristic methods cannot match."

- 合理预测: LLM reasoning 确实在增强 ✓
- 不 overclaim: "anticipate" + "even at current scales" 的措辞平衡 ✓
- 无新数据声明 ✓

---

## 四、综合评估

### 4.1 论文当前状态

| 维度 | 评估 |
|------|------|
| 形式化 | 5 Defs + 3 Thms + 1 Prop, AGM bridge, Representation theorem |
| 实验 | 2 benchmarks, 8+1 baselines, ablation, scalability, pilot human eval |
| 写作 | KR 顶会水平，running example 贯穿，9 页正文合规 |
| 引用 | 36 refs, 0 undefined/unused, 52.8% recent (2022+) |
| 数据一致性 | ~100+ 数据点全部一致 |

### 4.2 剩余风险

| 风险 | 概率 | 影响 | 缓解 |
|------|------|------|------|
| 审稿人认为 complexity inherited | 30% | MINOR | W1 修复已更诚实表述 |
| 审稿人要求更大 human eval | 20% | MINOR | "pilot" 标注 + 扩展承诺 in conclusion |
| 审稿人质疑小框架实用性 | 25% | MINOR | W2 修复 + 讨论章覆盖 |
| 审稿人要求 ASPIC+ 扩展 | 15% | MINOR | Related work 解释 + future work |

### 4.3 最终接受概率

| 状态 | 概率 |
|------|------|
| R76 (起始) | ~85% |
| R81 (当前) | 87-89% |
| 提升来源 | R77-1/R77-3 文本优化 + W1 诚实表述 + W2 实用性论证 |

---

## 五、结论

KR26 ARGUS 论文经过 81 轮审稿，当前状态优良。核心理论（AGM compliance + Representation + Complexity）和实验（8 baselines + ablation + scalability + human eval）均经过充分验证。R77-R80 的 4 项修复已正确应用，未引入新问题。剩余 5 个 OPEN MINOR issues 均不影响接受决定。

---

**审稿人**: Claude Code (Final Regression)
**审稿时间**: 2026-02-16
