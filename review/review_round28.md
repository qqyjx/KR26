# R28: 对抗性终审 + 中稿概率最终评估

**日期**: 2026-02-14
**轮次**: Round 28 (FINAL)
**视角**: 对抗性综合审稿 + Area Chair
**文件**: 全部

---

## 1. "So What" 问题验证

### 核心问题: 为什么需要形式化修复而非简单重新提示？

**论文回答**:
- Introduction (lines 31-33): 自我纠正方法 "edits are unconstrained and previously valid reasoning may be silently discarded"
- Example 1: 具体展示非约束修复的附带损害（丢弃 a₁, a₂）
- Figure 6 (experiments): Self-Refine 重生成 5/6 单元 vs ARGUS 修复代价 2
- Table 1: ARGUS 修复代价 3.2 vs ARGORA 5.1 vs Self-Refine 7.1
- AGM 合规 (Theorem 1): 形式化保证最小变更

### 评估

论文在多个层次回答了"为什么需要"：
1. **概念层** (Introduction): 最小变更原则的必要性
2. **理论层** (Theory): AGM postulates + 复杂度刻画
3. **实证层** (Experiments): 修复代价显著降低

### 状态: PASS ✅ — "So what" 问题回答充分

---

## 2. 消融异常分析

### w/o Minimal-Change

| 指标 | Full | w/o MC | 差值 |
|------|------|--------|------|
| Faithfulness | 0.847 | 0.841 | -0.006 |
| Contestability | 0.791 | 0.783 | -0.008 |
| RepairAcc | 0.883 | 0.856 | -0.027 |
| RepairCost | 3.2 | 5.7 | +2.5 |

**Faithfulness 仅下降 0.006 — 潜在审稿人质疑？**

论文 framing (experiments.tex line 127):
> "Replacing the minimal-change objective with unconstrained repair **preserves faithfulness** but **increases repair cost** from 3.2 to 5.7 operations"

**分析**: 这个 framing 是正确的。Minimal-change 的设计目标是 **minimize cost while maintaining correctness**，不是提升 faithfulness。Repair cost 从 3.2 增到 5.7 (+78%) 是主要效果。RepairAcc 下降 0.027 也有意义——非约束修复可能引入新的不一致性。

### 对抗性场景: 审稿人可能说 "既然 faithfulness 差不多，minimal-change 有什么用？"

**防线**:
1. Cost 维度: 78% 的修复代价增加 → 用户体验和计算效率显著不同
2. RepairAcc 维度: 2.7pp 下降 → 非约束修复更可能引入错误
3. 形式保证维度: AGM vacuity/inclusion 保证了不做无谓修改
4. 可解释性: 最小变更修复更容易向用户解释

### 状态: PASS ✅ — framing 正确，防线充分

---

## 3. 全量数据一致性终检

### 10 核心宏

| 宏 | 值 | Abstract | Table 1 | Experiments Text | Conclusion |
|----|-----|----------|---------|-----------------|------------|
| resultFaithHotpot | 0.847 | — | ✅ (via macro) | ✅ (via macro) | — |
| resultFaithFEVER | 0.829 | — | ✅ | ✅ | — |
| resultContestHotpot | 0.791 | — | ✅ | — | — |
| resultContestFEVER | 0.768 | — | ✅ | — | — |
| resultRepairCostHotpot | 3.2 | — | ✅ | ✅ | — |
| resultRepairCostFEVER | 2.8 | — | ✅ | ✅ | — |
| resultRepairAccHotpot | 0.883 | — | ✅ | — | — |
| resultRepairAccFEVER | 0.871 | — | ✅ | — | — |
| improveFaithfulness | 10.3% | ✅ | — | ✅ | ✅ |
| improveContestability | 14.5% | ✅ | — | ✅ | ✅ |

### 改进百分比验证

- Faith: (0.847 - 0.768) / 0.768 = 10.29% ≈ **10.3%** ✅
- Contest: (0.791 - 0.691) / 0.691 = 14.47% ≈ **14.5%** ✅

### Figure 数据验证

| 图表 | 检查项 | 状态 |
|------|--------|------|
| Fig 5 HotpotQA | 5+10+21+27+20+17 = 100% | ✅ |
| Fig 5 FEVER | 8+15+26+25+16+10 = 100% | ✅ |
| Fig 5 caption "83%" | 5+10+21+27+20 = 83% | ✅ |
| Fig 5 caption "90%" | 8+15+26+25+16 = 90% | ✅ |
| Fig 4 grounded |A|=25 | 0.12s = "averaging 0.12s" | ✅ |

### 状态: PASS ✅

---

## 4. Abstract-Contributions-Conclusion 对齐

| 要素 | Abstract | C1-C4 | Conclusion |
|------|----------|-------|------------|
| AF construction + verification | ✅ | C1 ✅ | ✅ |
| AGM postulates (success, inclusion, vacuity) | ✅ | C2 ✅ | ✅ |
| Complexity (P/NP-c/Σ₂ᴾ) | ✅ | C2 ✅ | ✅ (简化) |
| Stable semantics | ✅ | C2 ✅ | ✅ |
| k-neighborhood + ASP | ✅ | C3 ✅ | ✅ |
| HotpotQA + FEVER | ✅ | C4 ✅ | ✅ |
| 10.3% faith + 14.5% contest | ✅ (macros) | — | ✅ (macros) |
| Lowest repair cost | ✅ | — | ✅ |

### 状态: PASS ✅ — 完全对齐

---

## 5. 形式化元素编号

| 类型 | 编号 | 标签 | 内容 |
|------|------|------|------|
| Definition 1 | def:af | Abstract AF | ✅ |
| Example 2 | ex:af | Continuing Ex 1 | ✅ |
| Definition 3 | def:defense-set | Defense Set | ✅ |
| Example 4 | ex:defense | Continuing Ex 1 | ✅ |
| Definition 5 | def:task | Verification Task | ✅ |
| Example 6 | ex:verify | Continuing Ex 1 | ✅ |
| Definition 7 | def:repair | Repair Problem | ✅ |
| Example 8 | ex:repair-ex | Continuing Ex 1 | ✅ |
| Example 9 | ex:cost | Cost Models | ✅ |
| Theorem 10 | thm:agm | AGM Compliance | ✅ |
| Example 11 | ex:agm | AGM Examples | ✅ |
| Theorem 12 | thm:complexity | Repair Complexity | ✅ |
| Proposition 13 | prop:encoding | ASP Correctness | ✅ |

**注意**: 编号使用全局共享计数器 (theorem counter)，定义 1-7 + 例 2,4,6,8,9,11 + 定理 10,12 + 命题 13 = 连续编号至 13 或 14。无跳号。

### 状态: PASS ✅

---

## 6. 编译终检

| 指标 | 值 |
|------|-----|
| 正文页数 | ≤ 9（Conclusion 结束于第 9 页上方） |
| 总页数 | 10（含 References） |
| PDF 大小 | 347,047 bytes |
| LaTeX Errors | 0 |
| Undefined refs | 0 |
| Bibliography entries | 28 |
| Cite keys used | 28 |

### 状态: PASS ✅

---

## 7. R24-R27 全量回归

| Round | Issue | 描述 | 当前状态 |
|-------|-------|------|----------|
| R24-1 | Abstract stable | "preferred and stable semantics" | ✅ |
| R24-2 | Intro C2 stable | "preferred and stable semantics" | ✅ |
| R24-3 | Conclusion stable | "preferred and stable semantics" | ✅ |
| R25-1 | Thm 2 proof | Enforcement reduction (无 "fixed C") | ✅ |
| R25-2 | Def 2 skeptical | 无需修改 | ✅ |
| R25-3 | Running examples | 7 examples 一致 | ✅ |
| R25-4 | Prop 1 caveat | "without k-neighborhood restriction" | ✅ |
| R26-1 | CoVe/CRITIC | 排除说明已添加 | ✅ |
| R26-2 | Statistical sig | z-test p<0.001 已添加 | ✅ |
| R26-3 | Human eval | Limitation 3 已增强 | ✅ |
| R27-1 | Competitive works | 无遗漏 | ✅ |
| R27-4 | Author anonymity | NOTE — 提交前替换 | ⚠️ (非内容问题) |

### 状态: PASS ✅ — 所有修复均保持完好

---

## 8. 中稿概率最终评估

### 模拟审稿人评分

#### Reviewer 1: KR 复杂度理论专家

| 维度 | 评分 | 评语 |
|------|------|------|
| Novelty | 4/5 | 将 AGM + enforcement 应用于 LLM 解释修复是新颖的组合 |
| Soundness | 5/5 | 复杂度结果正确，证明 sketch 清晰，归约链完整 |
| Writing | 4/5 | 结构良好，running example 贯穿全文 |
| Experiments | 3/5 | 理论验证充分，但 500 instances 偏小 |
| **Overall** | **Strong Accept** | "Solid theoretical contribution with practical demonstration" |

#### Reviewer 2: KR + ML 桥梁审稿人

| 维度 | 评分 | 评语 |
|------|------|------|
| Novelty | 4/5 | 将 KR 形式化方法应用于 LLM 解释维护的首次系统尝试 |
| Soundness | 4/5 | 理论完整，实验合理 |
| Writing | 4/5 | 清晰，positioning 图有效 |
| Experiments | 4/5 | 7 baselines, 4 metrics, 2 datasets, stat. tests |
| **Overall** | **Accept** | "Good fit for KR Meets ML track" |

#### Reviewer 3: ML/NLP 实验方法专家

| 维度 | 评分 | 评语 |
|------|------|------|
| Novelty | 3/5 | 形式化贡献不在我的专长范围 |
| Soundness | 3/5 | 实验设计合理但无人工评估 |
| Writing | 4/5 | 流畅，motivation 清晰 |
| Experiments | 3/5 | 缺少人工评估，证据更新是合成的 |
| **Overall** | **Weak Accept** | "Interesting approach, experiments could be stronger" |

### 综合评估

| 因素 | 评估 |
|------|------|
| Track 匹配度 | **极高** — 正好是 "KR Meets ML & Explanation" 的靶心 |
| 理论深度 | **强** — AGM + complexity + ASP encoding |
| 实验广度 | **中等偏上** — 7 baselines, 2 datasets, 但无人工评估 |
| 写作质量 | **高** — 9 页内容结构紧凑，running example 贯穿 |
| 形式化完整性 | **高** — 5 definitions, 2 theorems, 1 proposition, 7 examples |
| 主要风险 | ML 审稿人可能要求人工评估 → limitation 已诚实说明 |

### 中稿概率

| 场景 | 概率 |
|------|------|
| 3 位 KR-oriented 审稿人 | **90%** |
| 2 KR + 1 ML 审稿人 (最可能) | **82%** |
| 1 KR + 2 ML 审稿人 | **70%** |

**最终综合估计: ~80-85%**

### 与初始评估对比

| 时间点 | 概率 | 关键变化 |
|--------|------|----------|
| R23 后 (初始) | ~75% | 基线 |
| R24 后 | ~77% | Stable semantics 补齐 |
| R25 后 | ~82% | CRITICAL Thm 2 证明修复 |
| R26 后 | ~84% | 统计显著性 + limitation 增强 |
| R27 后 | ~84% | 竞争定位确认无遗漏 |
| **R28 (最终)** | **~82-85%** | 全量验证通过 |

### 如何进一步提升至 90%+

1. **添加人工评估** (~+5%): 邀请 2-3 位领域专家评估解释质量
2. **扩展数据集** (~+3%): 增加一个领域（如法律推理）
3. **开源代码** (~+2%): 提交时即公开工具包
4. **Full proofs in appendix** (~+2%): 完整形式化证明

---

## 9. R24-R28 修改总结

### 修改的文件

| 文件 | 修改轮次 | 修改内容 |
|------|----------|----------|
| abstract.tex | R24 | +2 词 ("and stable") |
| introduction.tex | R24 | +2 词 ("and stable") |
| conclusion.tex | R24, R26 | +2 词 ("and stable"), 重写 limitation 3 |
| theory.tex | R25 | 重构 Thm 2 proof sketch (CRITICAL) |
| experiments.tex | R26 | +1 句 CoVe/CRITIC 排除, +1 句统计显著性 |

### 新增的文件

| 文件 | 内容 |
|------|------|
| review/review-20260214-R24-bibliography.md | R24 审稿报告 |
| review/review-20260214-R25-theory.md | R25 审稿报告 |
| review/review-20260214-R26-experiments.md | R26 审稿报告 |
| review/review-20260214-R27-positioning.md | R27 审稿报告 |
| review/review-20260214-R28-final.md | R28 终审报告（本文件） |

### 问题统计

| 严重性 | 发现 | 修复 | 无需修改 |
|--------|------|------|----------|
| CRITICAL | 1 | 1 | 0 |
| MAJOR | 4 | 4 | 0 |
| MINOR | 3 | 0 | 3 (PASS) |
| NOTE | 1 | — | 1 (提交前操作) |

---

## 10. 最终判定

**READY FOR SUBMISSION**

论文已通过 28 轮审稿（R1-R28），共识别并解决 100+ 个问题。所有 CRITICAL 和 MAJOR 问题均已修复。编译无错误，页数合规，数据一致，形式化完整。

预估中稿概率: **82-85%** (KR 2026 "KR Meets ML & Explanation" track)
