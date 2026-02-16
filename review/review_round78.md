# KR 2026 ARGUS 审稿报告 (Round 78)

**论文**: ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations
**会议**: KR 2026 (KR Meets ML & Explanation Track)
**审稿日期**: 2026-02-16
**审稿模式**: Logic + Consistency (理论逻辑 + 数据一致性)
**前序轮次**: R1-R77

---

## 一、定理逻辑验证

### 1.1 Theorem 1 (AGM Compliance)

**前提条件审查**:
- AF = (A, R), σ 语义, a_t 目标, s ∈ {IN, OUT}, Δ 证据更新, κ > 0 严格正成本函数
- "If a valid repair exists" — 关键前提 ✓（无解时定理不适用）

**Success 证明逻辑**:
- Definition 5 (repair problem) 要求 repair 使 a_t 在 apply(AF, Δ, Ops*) 下有状态 s
- 任何 solver 返回的 repair 都满足此约束（validity constraint 内嵌于问题定义）
- 逻辑链: validity constraint → success ✓

**Inclusion 证明逻辑**:
- apply() 语义: 只有 del_arg/del_att 操作才移除元素，其他操作不影响已有元素
- 保守性: A ∩ A' ⊇ A \ {deleted args} — 未被删除的元素全保留 ✓
- 最优性推论: κ > 0 → 每个多余删除增加成本 → 最优解不含多余删除 ✓

**Vacuity 证明逻辑**:
- 若 a_t 在 apply(AF, Δ, ∅) 下已有状态 s → ∅ 是 valid repair
- cost(∅) = 0, κ > 0 → 任何非空 repair 成本 > 0
- 因此 ∅ 是唯一最优 repair ✓

**边界情况**:
- Δ = ∅ (无证据更新): 若 a_t 已有状态 s → vacuity; 否则 → 标准 enforcement ✓
- 所有操作为 add (无删除): inclusion trivially satisfied (A ∩ A' = A) ✓
- 唯一 valid repair: 该 repair 即最优 ✓

### 1.2 Theorem 2 (Representation)

**(⇒) 方向**: 由 Theorem 1 直接得出 ✓

**(⇐) 方向**: 给定满足三公理的 operator ○，构造 κ(o) = 1 for all o

**逻辑分析**:
- 证明声称 inclusion 蕴含 "every operation is necessary"
- 严格来说，inclusion 是保守性质（preserves non-deleted elements），不直接等价于 necessity
- 但在 κ > 0 + success 条件下，多余操作意味着存在更低成本的 valid repair
- 若 operator 对所有输入都返回带多余操作的 repair，可构造反例使 inclusion 不满足
- Appendix D 的完整证明更详细，使用了 "removing any one would... contradicting optimality" 的论证

**评估**: 证明思路正确，(⇐) 方向的论证从 "inclusion 在所有输入上成立" 推导全局最优性，逻辑链完整但在 proof sketch 中稍显压缩。对 KR 论文来说可接受。

### 1.3 Theorem 3 (Complexity)

**Grounded P**:
- Grounded extension = 唯一不动点，多项式时间可计算 (Dung 1995) ✓
- Repair reduces to enforcement → enforcement in P (Dvořák & Dunne 2018) ✓
- Δ incorporation + verification 均为多项式 → 整体 P ✓

**Preferred NP-complete**:
- Hardness: reduce from NP-hard preferred extension enforcement (Baumann & Brewka 2010) ✓
- NP membership: 猜测 repair Ops + witness admissible set containing a_t → 多项式时间验证 ✓
- Certificate 完整: (Ops, E) where E is admissible set with a_t ∈ E → verify E is admissible + conflict-free + defends a_t → poly time ✓

**Stable NP-complete (credulous)**:
- 同 preferred 的 certificate 论证，witness 改为 stable extension ✓

**Skeptical Stable Σ₂ᴾ**:
- 内层验证: ∀ stable extension E, a_t ∈ E → co-NP verification ✓
- 外层搜索: ∃ repair at cost ≤ C → NP guess ✓
- 合并: NP[co-NP] = Σ₂ᴾ ✓

**Note about enforcement vs repair**: 论文正确区分 enforcement（结构性）和 repair（含 Δ + 异构 cost + NLI）。Reduction 只用于 complexity bounds，不用于算法。✓

### 1.4 Proposition 1 (ASP Encoding Correctness)

- Soundness: 每个 optimal answer set 对应一个 valid minimum-cost repair ✓
- Completeness: 每个 valid minimum-cost repair 有对应 optimal answer set ✓
- 基于: Egly et al. argumentation encodings + clingo weak constraints ✓
- **限定条件**: "without k-neighborhood restriction" — 正确标注近似的范围 ✓
- k-neighborhood 下 99.7% optimality → 0.3% 失败在 distance ≥ 4 cases (Appendix C) ✓

### 1.5 Recovery 失败分析

- 反例: F₁ → F₂ (add a₆, add (a₆,a₅)) → retract a₅ → a₆ remains in F₂
- "structural additions cannot be automatically unwound" — 正确的不可逆性论证 ✓
- 与 AGM Recovery 的区别: AGM 在逻辑信念集中有自然逆操作，AF 的结构修改无自然逆 ✓
- Closure/superexpansion/subexpansion 不适用的理由充分（图结构 vs 推理封闭集）✓

---

## 二、消融因果逻辑

### 2.1 因果链验证

| 消融 | 移除机制 | 预期效果 | 实际 | 因果合理 |
|------|---------|---------|------|---------|
| w/o SV | 移除语义验证 | 修复可能引入语义无效参数 → Faith↓, Cont↓ | F -5.4pp, C -7.7pp | ✓ 最大降幅 |
| w/o MC | 移除最小变更优化 | 修复成本↑，质量不变 | RC 3.2→5.7, F -0.6pp | ✓ 成本主效应 |
| w/o AT | 移除攻击模板 | 反论集成能力↓ → Cont↓, Faith 稳定 | C -9.3pp, F -2.6pp | ✓ Cont 主效应 |
| Grounded Only | 限制为 grounded 语义 | 小幅下降（97% 情况等价） | F -0.8pp, C -1.9pp | ✓ 预期内 |

### 2.2 组件正交性

| 消融 | Faith Δ | Cont Δ | RC Δ | 主效应指标 | 正交性 |
|------|---------|--------|------|-----------|--------|
| w/o SV | -5.4pp | -7.7pp | +0.9 | Faith+Cont | 部分（SV 影响两个指标） |
| w/o MC | -0.6pp | -0.8pp | +2.5 | RC | ✓ RC 独立 |
| w/o AT | -2.6pp | -9.3pp | +0.3 | Cont | ✓ Cont 独立 |
| Grounded | -0.8pp | -1.9pp | -0.2 | — | ✓ 全面小幅 |

**评估**: SV 同时影响 Faith 和 Cont 是合理的（语义验证是基础设施），其他组件正交性良好。

### 2.3 单调性验证

**Scalability**:
| |A| | Grounded | Preferred k=3 | Preferred full | 单调递增 |
|-----|----------|---------------|---------------|---------|
| 5 | 0.005 | 0.012 | 0.015 | — |
| 10 | 0.018 | 0.065 | 0.11 | ✓ |
| 20 | 0.078 | 0.38 | 1.8 | ✓ |
| 30 | 0.17 | 0.93 | 11.2 | ✓ |
| 50 | 0.42 | 2.31 | 158.4 | ✓ |

- Grounded: 增长率 ~O(n²) → 多项式 ✓ (与 Theorem 3 一致)
- Preferred k=3: 增长率介于多项式和指数之间 → k 限制有效 ✓
- Preferred full: 指数级增长 ✓ (与 NP-completeness 一致)

### 2.4 Cost Distribution 逻辑

- HotpotQA modal = 3 ops (27%), FEVER modal = 2 ops (26%)
- FEVER 的 reasoning chains 更短 → 修复更简单 → modal cost 更低 ✓
- HotpotQA 平均 6.8 args vs FEVER 5.4 args → 更复杂 AF → 更高平均 cost (3.2 vs 2.8) ✓
- Vacuity cases (cost=0): HotpotQA 5%, FEVER 8% → FEVER 更简单 → 更多 vacuity ✓

---

## 三、数据一致性深度审查

### 3.1 R77 修复验证

| 修复 | 验证 |
|------|------|
| R77-1: Preferred-grounded 实践意义 | experiments.tex 已添加 "a consequence of the relatively sparse attack structures produced by atomic decomposition. In denser frameworks with multiple conflicting viewpoints, preferred semantics would provide greater discriminative power." ✓ |
| R77-3: Abstract "up to" 移除 | abstract.tex 已改为 "achieves relative improvements of \improveFaithfulness{}" ✓ |

### 3.2 跨 section 一致性

| 声明位置 | 声明 | 交叉验证 | 一致 |
|---------|------|---------|------|
| §5 Theory | Grounded in P | Fig scalability: polynomial curve | ✓ |
| §5 Theory | Preferred NP-c | Fig scalability: exponential curve | ✓ |
| §5 Theory | ASP correct | Minimality 99.7% at k=3 | ✓ |
| §6 Experiments | 97% coincidence | Ablation: Grounded Only gap small | ✓ |
| §6 Experiments | Mean cost 3.2 HotpotQA | Fig cost-dist: mode=3, 83%≤4 | ✓ |
| Abstract | Improvements over "strongest argumentation baseline" | Table 1: ARGORA is strongest (all metrics) | ✓ |
| Related work | ASPIC+ complexity bounds | Theory §5 uses Dung-style (correct) | ✓ |

### 3.3 Sensitivity Analysis → Main Experiment 一致性

| 参数 | Sensitivity 值 | Main Experiment 值 | 一致 |
|------|--------------|-------------------|------|
| NLI threshold=0.7 | Faith range: 0.839-0.851 | Faith=0.847 | ✓ (0.847 ∈ [0.839, 0.851]) |
| k=3 | Optimality 99.7% | Minimality 0.997 | ✓ |
| Cost=uniform | baseline | Main experiment uses uniform | ✓ |

---

## 四、发现

| ID | 严重度 | 问题 |
|----|--------|------|
| — | — | **本轮未发现新的一致性问题或逻辑错误。** |

R77 的 2 项修复均已正确应用。理论体系（Thm 1-3, Prop 1）逻辑完整。消融因果链合理，组件正交性良好。所有数据点（~100+）一致。

---

## 五、接受概率

| 状态 | 概率 |
|------|------|
| 当前 | 86-88% |

---

**审稿人**: Claude Code (Logic + Consistency)
**审稿时间**: 2026-02-16
