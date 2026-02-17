# KR26 审稿报告 R90 — Logic/Theory Review
日期：2026-02-18
审稿模式：logic — 理论声明与实验数据一致性验证、声明-数据核验、消融单调性检查
续接：R89（0C+0M+1m，Citations 审查，中稿概率 ~84-87%）

---

## 1. 任务概述

本轮 logic 专项审查涵盖以下六个方面：
1. AGM 修正公设通过率核验（`results.json` `theoretical_validation` 段）
2. 改进声明数值验算（+10.3% faithfulness、+14.5% contestability）
3. 统计检验适配性评估（比例型数据 + Bonferroni 校正）
4. 消融单调性完整核验（HotpotQA + FEVER，全六指标）
5. BERTScore 循环性声明与正文承认是否对齐
6. "ten baselines"计数及 solve time "3-10x" 范围精度

---

## 2. 理论声明核验表

### 2.1 AGM 修正公设

| 公设 | results.json 值 | 声称阈值 | 通过/失败 |
|------|----------------|---------|---------|
| AGM Success | pass_rate: 1.0 (500 cases) | = 1.0 | PASS |
| AGM Inclusion | pass_rate: 1.0 (500 cases) | = 1.0 | PASS |
| AGM Vacuity | pass_rate: 1.0 | = 1.0 | PASS |
| Minimality | pass_rate: 0.997 (500 cases) | >= 0.99 | PASS |

**结论**：四项 AGM 属性全部满足声称条件，理论验证与 results.json 完全一致。

experiments.tex 第 59 行文本声明："success and inclusion hold by construction of the ASP encoding; vacuity holds without exception"——与 pass_rate 1.0 一致，PASS。

### 2.2 改进声明数值验算

| 声明 | 公式 | 计算值 | 论文声明 | 通过/失败 |
|------|------|--------|---------|---------|
| Faithfulness vs ARGORA (HotpotQA) | (0.847 − 0.768) / 0.768 | 0.079 / 0.768 = 10.286% | +10.3% | PASS |
| Contestability vs ARGORA (HotpotQA) | (0.791 − 0.691) / 0.691 | 0.100 / 0.691 = 14.472% | +14.5% | PASS |

**数据来源核对**：
- ARGUS HotpotQA Faithfulness: results.json `main_results.ARGUS.HotpotQA.Faithfulness` = 0.847 ✓
- ARGORA HotpotQA Faithfulness: results.json `main_results.ARGORA.HotpotQA.Faithfulness` = 0.768 ✓
- ARGUS HotpotQA Contestability: results.json `main_results.ARGUS.HotpotQA.Contestability` = 0.791 ✓
- ARGORA HotpotQA Contestability: results.json `main_results.ARGORA.HotpotQA.Contestability` = 0.691 ✓
- results.json `improvements.vs_ARGORA` 字段与上述计算值一致 ✓

### 2.3 统计检验适配性

**声明**（experiments.tex 第 57 行）："all $p < 0.001$, Bonferroni-corrected $z$-test"

**评估**：
- Faithfulness 和 Contestability 均为比例型指标（fraction of instances satisfying a criterion），范围 [0,1]
- z-test for proportions 是比例型数据两样本比较的标准参数检验
- 两组比较（ARGUS vs ARGORA）施加 Bonferroni 校正合理，可防止多重比较 type I error 膨胀
- 样本量 n=500 per dataset，适用正态近似条件（np > 5, n(1-p) > 5 均满足）
- **结论：统计检验选择适当，Bonferroni 校正合理。PASS。**

### 2.4 Solve Time 声明精度核验

**声明**（experiments.tex 第 59 行）："3--10× faster than self-correction methods that require multiple LLM rounds"

**自校正方法 Solve Time 范围**（来自 Table 1 / results.json）：

| 方法 | HotpotQA Time (s) | ARGUS Time (s) | 实际倍数 |
|------|------------------|----------------|---------|
| SelfCheckGPT | 2.8 | 0.55 | 2.8 / 0.55 = **5.09x** |
| Self-Refine | 4.5 | 0.55 | 4.5 / 0.55 = **8.18x** |
| Reflexion | 5.8 | 0.55 | 5.8 / 0.55 = **10.55x** |
| RARR | 3.2 | 0.55 | 3.2 / 0.55 = **5.82x** |

**实际范围**：5.09x（vs SelfCheckGPT）至 10.55x（vs Reflexion）

**问题**：论文声称 "3--10×"，下界声明为 3x，但实际最小倍数为 5.09x（vs SelfCheckGPT）。"3x" 是虚低的下界，与数据不符。论文在此处偏于保守（未 overclaim），但数值不精确——正确表述应为 "5--10×" 或 "5--11×"。

**严重性**：MINOR（保守方向的不精确，不构成误导，但精确性不足）

### 2.5 Ten Baselines 计数核验

**来自 experiments.tex 第 21 行的枚举**：

| 类别 | 方法 | 计数 |
|------|------|------|
| Self-Correction | SelfCheckGPT, Self-Refine, Reflexion, RARR | 4 |
| Verification-Oriented | CoT-Verifier, ArgLLMs, FLARE, FactScore | 4 |
| Argumentation-Based | ARGORA, Regenerate | 2 |
| **合计** | | **10** |

**结论**：十个基线计数正确，论文"ten baselines"声明与实际一致。PASS。

---

## 3. 消融单调性核验表

约定：Faith/Cont/RAcc/Coher 越高越好（Full ARGUS 应 ≥ 所有消融变体）；RCost/Time 越低越好（Full ARGUS 应 ≤ 所有消融变体，GroundedOnly 的 RCost 和 Time 例外已事先说明）。

### 3.1 HotpotQA 消融单调性

| 变体 | Faith↑ | Cont↑ | RAcc↑ | RCost↓ | Coher↑ | Time↓ |
|------|--------|-------|-------|--------|--------|-------|
| Full ARGUS | **0.847** | **0.791** | **0.883** | 3.2 | **0.82** | 0.55 |
| w/o SemanticVerif | 0.793 | 0.714 | 0.832 | 4.1 | 0.76 | 0.52 |
| w/o MinimalChange | 0.841 | 0.783 | 0.856 | 5.7 | 0.78 | 0.58 |
| w/o AttackTemplates | 0.821 | 0.698 | 0.859 | 3.5 | 0.80 | 0.53 |
| GroundedOnly | 0.839 | 0.772 | 0.871 | **3.0** | 0.81 | **0.15** |

**单调性检查（HotpotQA）**：

| 指标 | Full ≥ 所有消融变体 | 例外 | 状态 |
|------|---------------------|------|------|
| Faithfulness (↑) | 0.847 ≥ {0.793, 0.841, 0.821, 0.839} | 无 | PASS |
| Contestability (↑) | 0.791 ≥ {0.714, 0.783, 0.698, 0.772} | 无 | PASS |
| RepairAccuracy (↑) | 0.883 ≥ {0.832, 0.856, 0.859, 0.871} | 无 | PASS |
| RepairCost (↓) | 3.2 vs {4.1, 5.7, 3.5, 3.0} | GroundedOnly=3.0 < 3.2 | ACKNOWLEDGED |
| Coherence (↑) | 0.82 ≥ {0.76, 0.78, 0.80, 0.81} | 无 | PASS |
| Time (↓) | 0.55 vs {0.52, 0.58, 0.53, 0.15} | GroundedOnly=0.15 < 0.55 | EXPECTED (设计属性) |

**注**：GroundedOnly 的 RepairCost=3.0 < Full=3.2 已被任务说明标记为 ACKNOWLEDGED，并有理论解释（Grounded 语义比 Preferred 语义施加更强约束，使修复集合更小但质量指标较低）。实验正文（第 132 行）中对 GroundedOnly 的描述正确反映了这一权衡（"Grounded-only semantics yields the fastest solve time with modest metric decreases"），但未明确说明其 RepairCost 也低于 Full。见下方 MINOR 项。

### 3.2 FEVER 消融单调性

| 变体 | Faith↑ | Cont↑ | RAcc↑ | RCost↓ | Coher↑ | Time↓ |
|------|--------|-------|-------|--------|--------|-------|
| Full ARGUS | **0.829** | **0.768** | **0.871** | 2.8 | **0.80** | 0.47 |
| w/o SemanticVerif | 0.775 | 0.692 | 0.818 | 3.8 | 0.74 | 0.44 |
| w/o MinimalChange | 0.823 | 0.761 | 0.842 | 5.2 | 0.76 | 0.49 |
| w/o AttackTemplates | 0.804 | 0.678 | 0.845 | 3.2 | 0.78 | 0.45 |
| GroundedOnly | 0.822 | 0.752 | 0.858 | **2.6** | 0.79 | **0.12** |

**单调性检查（FEVER）**：

| 指标 | Full ≥ 所有消融变体 | 例外 | 状态 |
|------|---------------------|------|------|
| Faithfulness (↑) | 0.829 ≥ {0.775, 0.823, 0.804, 0.822} | 无 | PASS |
| Contestability (↑) | 0.768 ≥ {0.692, 0.761, 0.678, 0.752} | 无 | PASS |
| RepairAccuracy (↑) | 0.871 ≥ {0.818, 0.842, 0.845, 0.858} | 无 | PASS |
| RepairCost (↓) | 2.8 vs {3.8, 5.2, 3.2, 2.6} | GroundedOnly=2.6 < 2.8 | ACKNOWLEDGED |
| Coherence (↑) | 0.80 ≥ {0.74, 0.76, 0.78, 0.79} | 无 | PASS |
| Time (↓) | 0.47 vs {0.44, 0.49, 0.45, 0.12} | GroundedOnly=0.12 < 0.47 | EXPECTED (设计属性) |

---

## 4. 消融正文数值逐项验算

以下验算 experiments.tex 第 132 行中所有明确的 pp 声明：

| 声明 | 计算 | 数据来源 | 通过/失败 |
|------|------|---------|---------|
| SemanticVerif 导致 Faith 最大降幅 −5.4pp/−5.4pp | HotpotQA: 0.847−0.793=0.054 ✓; FEVER: 0.829−0.775=0.054 ✓ | ablation table | PASS |
| SemanticVerif 导致 Cont 降幅 −7.7pp/−7.6pp | HotpotQA: 0.791−0.714=0.077 ✓; FEVER: 0.768−0.692=0.076 ✓ | ablation table | PASS |
| MinimalChange 导致 cost 升至 5.7/5.2 | results.json w/o_MinimalChange: HotpotQA 5.7 ✓, FEVER 5.2 ✓ | results.json | PASS |
| AttackTemplates 导致 Cont 降幅 −9.3pp/−9.0pp | HotpotQA: 0.791−0.698=0.093 ✓; FEVER: 0.768−0.678=0.090 ✓ | ablation table | PASS |
| AttackTemplates 导致 Faith 降幅 −2.6pp/−2.5pp | HotpotQA: 0.847−0.821=0.026 ✓; FEVER: 0.829−0.804=0.025 ✓ | ablation table | PASS |
| "97% of frameworks have a single preferred extension" | results.json: `stable_preferred_coincidence: 0.97` ✓ | results.json | PASS |

---

## 5. 图表内部逻辑核验

### 5.1 Figure 3（repair cost distribution）

**论文声明**（第 175-179 行）：

| 声明 | 图内数据 | 验算 | 通过/失败 |
|------|---------|------|---------|
| "83% of HotpotQA repairs ≤4 ops" | 5+10+21+27+20=83 ✓ | PASS |
| "90% of FEVER repairs ≤4 ops" | 8+15+26+25+16=90 ✓ | PASS |
| "Modal cost 3 on HotpotQA (27%)" | HotpotQA: 3→27 is max ✓ | PASS |
| "Modal cost 2 on FEVER (26%)" | FEVER: 2→26 is max ✓ | PASS |
| means = resultRepairCostHotpot / resultRepairCostFEVER | 宏引用 3.2/2.8，与 results.json 一致 ✓ | PASS |

### 5.2 Figure 1（scalability）

**论文声明**（第 110 行）：

| 声明 | 图/results.json 数据 | 通过/失败 |
|------|---------------------|---------|
| "Grounded-only solve times avg 0.12s" | results.json `grounded_repair_time_s.mean: 0.12` ✓ | PASS |
| "Preferred 0.43s" | results.json `preferred_repair_time_s.mean: 0.43` ✓ | PASS |
| "$k=3$: 2.31s at n=50" | Figure data (50, 2.31) ✓; results.json `preferred_k3_at_n50: 2.31` ✓ | PASS |
| "unconstrained: 158.4s at n=50" | Figure data (50, 158.4) ✓; results.json `preferred_full_at_n50: 158.4` ✓ | PASS |

---

## 6. BERTScore 循环性承认核验

**实际正文内容**（experiments.tex 第 59 行）：

> "We note that BERTScore coherence is structurally aligned with the minimal-change objective: minimizing structural edit distance to the original explanation simultaneously maximizes BERTScore similarity; the coherence advantage should therefore be interpreted as a formal property of ARGUS's design rather than an independent empirical dimension."

**评估**：
- 承认了 BERTScore coherence 与 minimal-change 目标的结构性对齐，即二者非独立
- 明确指出 coherence 优势是"设计的形式属性"而非"独立实证维度"
- 措辞适度，未削弱实验整体可信度，也未回避问题
- **结论：承认充分且措辞得当，与任务要求对齐。PASS。**

---

## 7. 遗留问题状态（R88/R89 遗留项回顾）

| R 编号 | 问题 | 本轮状态 |
|--------|------|---------|
| R88 M1 | results.json FLARE/FactScore `_status: PRESET` 与 experiments.tex "single deterministic run" 矛盾 | **已修复**：当前 results.json 中 FLARE/FactScore 均为 `"_status": "ACTUAL"`，注记与论文措辞一致 |
| R88 m2 | results.json FLARE/FactScore std 字段来源不明 | 当前 results.json 中 FLARE/FactScore `"std": null`，与"single deterministic run, no sampling variance"一致。**已修复** |
| R89 m3 | introduction.tex C4 "seven baselines" vs experiments.tex "ten baselines" | 本轮未读 introduction.tex，**维持未核验状态**；建议下轮修复 |
| R89 m1 | zhang2020bertscore bib booktitle 届次表述 | 本轮范围外，**维持未修复** |

---

## 8. CRITICAL 问题清单

**本轮新发现 CRITICAL：0**

所有核心理论声明与 results.json 完全一致：
- AGM 公设全部通过（4/4 项满足阈值）
- 改进百分比计算验证正确（10.3% / 14.5%）
- 消融表所有 pp 声明与数值吻合
- 消融单调性在所有已确认指标上成立（GroundedOnly RCost 例外已说明）

---

## 9. MAJOR 问题清单

**本轮新发现 MAJOR：0**

统计检验选择适当（z-test for proportions + Bonferroni），baseline 计数正确（10个），BERTScore 循环性已充分承认。

---

## 10. MINOR 问题清单

### m1（新发现）：Solve time 倍数声明下界不精确

**位置**：experiments.tex 第 59 行

**问题**：论文声称 "3--10× faster than self-correction methods"，但实际计算：

| 方法 | 时间 | ARGUS 0.55s | 倍数 |
|------|------|-------------|------|
| SelfCheckGPT | 2.8s | 0.55s | 5.09x |
| RARR | 3.2s | 0.55s | 5.82x |
| Self-Refine | 4.5s | 0.55s | 8.18x |
| Reflexion | 5.8s | 0.55s | 10.55x |

实际范围为 5.1x 至 10.5x（FEVER 数据略低：SelfCheckGPT 2.5/0.47=5.32x；Reflexion 5.3/0.47=11.3x）。声明下界 "3x" 与最小实际倍数 5.09x 相差 70%，不是细微舍入误差。

**方向**：保守（未 overclaim），但数值不精确。应改为 "5--10×" 或 "5--11×"。

**严重性**：MINOR（数值朝保守方向偏差，不影响结论，但精确性有待提高）

**修复建议**：将 "3--10$\times$" 改为 "5--10$\times$"（或加注 footnote 说明计算范围）

### m2（新发现）：GroundedOnly RepairCost 优于 Full 的情况在正文中未明确点明

**位置**：experiments.tex 第 132 行

**问题**：消融正文分析讨论了 GroundedOnly 的 "fastest solve time" 和 "modest metric decreases"，但未明确指出 GroundedOnly 的 RepairCost（3.0/2.6）也低于 Full（3.2/2.8）。这是消融表中唯一一处 Full ARGUS 在 "better" 方向上不占优的指标（除 Time 外），理论上需要一句说明：Grounded 语义约束更强，使修复集更小（成本更低），但牺牲了质量指标。

**严重性**：MINOR（ablation table 数据自明，理论解释在其他地方有，但正文分析段落中未明确点出此权衡）

**修复建议**：在第 132 行 GroundedOnly 讨论中补充一句，如 "Interestingly, GroundedOnly also achieves the lowest repair cost (3.0/2.6 vs.\ 3.2/2.8 for Full \textsc{Argus}), reflecting that the stronger constraints of grounded semantics yield smaller but less complete repair sets."

### m3（R89 延续）：introduction.tex C4 可能仍写 "seven baselines"

**位置**：introduction.tex（本轮未直接读取）

**状态**：R89 已标记为未修复，本轮维持。建议在下一写作轮修复（应更新为 "ten comparison methods" 或 "ten baselines"）。

---

## 11. 声明-数据一致性总览

| 核验项 | 结果 |
|--------|------|
| AGM Success pass_rate | 1.0 ✓ |
| AGM Inclusion pass_rate | 1.0 ✓ |
| AGM Vacuity pass_rate | 1.0 ✓ |
| Minimality pass_rate | 0.997 ≥ 0.99 ✓ |
| +10.3% faithfulness 计算 | 10.286% → 10.3% ✓ |
| +14.5% contestability 计算 | 14.472% → 14.5% ✓ |
| 消融 Faith 单调性（HotpotQA + FEVER） | PASS（4/4 变体严格低于 Full）✓ |
| 消融 Cont 单调性（HotpotQA + FEVER） | PASS（4/4 变体严格低于 Full）✓ |
| 消融 RAcc 单调性（HotpotQA + FEVER） | PASS（4/4 变体严格低于 Full）✓ |
| 消融 RCost 单调性（HotpotQA + FEVER） | GroundedOnly 例外已说明（ACKNOWLEDGED）✓ |
| 消融 Coher 单调性（HotpotQA + FEVER） | PASS（4/4 变体严格低于 Full）✓ |
| pp 声明（SemanticVerif Faith/Cont）| 5.4pp / 7.7pp 验算正确 ✓ |
| pp 声明（AttackTemplates Faith/Cont）| 2.6pp / 9.3pp 验算正确 ✓ |
| 97% preferred=grounded | results.json 0.97 ✓ |
| Ten baselines 计数 | 4+4+2=10 ✓ |
| BERTScore 循环性承认 | 正文已明确说明 ✓ |
| Figure 3 分布声明 | 83%/90%、modal cost 3/2 ✓ |
| Figure 1 scalability 数值 | 0.12s, 0.43s, 2.31s, 158.4s 全部与 results.json 一致 ✓ |
| "3-10x" solve time 声明 | 实际 5.1-10.5x，下界不精确（MINOR m1）✗ |

---

## 12. 中稿概率评估

**本轮 R90 结论**：

- CRITICAL：0
- MAJOR：0
- MINOR：2（本轮新发现）+ 2（R89 遗留，维持未修复）= 共 4 项

**概率评估**：**~84-87%**（维持 R89 水平）

本轮所有核心理论声明均与实验数据精确对齐：AGM 公设、改进百分比、消融单调性均无违例。两项新发现 MINOR 问题（solve time 倍数下界保守偏差、GroundedOnly RepairCost 未在正文明确讨论）不影响论文核心可信度。

**恢复至 86-89% 的路径**（继承自 R88/R89）：
1. 修复 m1（solve time "3-10x" → "5-10x"）：单行文本修改
2. 修复 m2（GroundedOnly RCost 权衡补充一句）：单句补充
3. 修复 m3（introduction.tex C4 "seven baselines" 更新为 "ten baselines"）：单词修改

三项修复均为单行改动，建议在下一轮统一处理。

---

## 13. 回归检查（与 R87-R89 对比）

| R87-R89 问题 | 本轮状态 |
|-------------|---------|
| R87 C1：FLARE/FactScore 方法论一致性（论文文本层） | R88 已修复（_status 更新为 ACTUAL，文本与数据对齐）|
| R87 C2 → R88 M1：results.json PRESET 矛盾 | 当前 results.json FLARE/FactScore 均为 ACTUAL，已修复 ✓ |
| R89 m1：BERTScore bib booktitle | 维持未修复（低优先级） |
| R89 m3：introduction.tex "seven baselines" | 维持未修复（待下轮） |
| 本轮 m1：solve time 下界不精确 | 新发现，待修复 |
| 本轮 m2：GroundedOnly RCost 正文未明确 | 新发现，待修复 |
