# Round 11 审稿报告：对抗性审稿人视角

**日期**: 2026-02-12
**轮次**: Round 11 / 12
**视角**: 对抗性审稿人（攻击声明 + 找漏洞 + 构造反例 + 质疑新颖性）
**文件**: 跨文件交叉分析

---

## 发现汇总

| ID | 严重级 | 位置 | 攻击 | 状态 |
|----|--------|------|------|------|
| 11-1 | **MAJOR** | experiments.tex:17 | Faithfulness 评估协议未说明所有方法使用相同分解 | **FIXED** |
| 11-2 | Minor | theory.tex Thm 1 | Inclusion 公设同义反复（R8 已添加诚实讨论） | DEFENDED |
| 11-3 | Minor | theory.tex Thm 2 | 复杂度结果继承自 enforcement 文献 | DEFENDED |
| 11-4 | Minor | experiments.tex | 无 enforcement solver 对比 | DEFENDED |
| 11-5 | Minor | theory.tex:20,57 | 引用补充材料但文件不存在 | DEFERRED (R12) |

---

## 对抗性攻击分析

### 11-1: "Faithfulness 评估有利于 ARGUS" (MAJOR) → FIXED

**审稿人攻击**: "ARGUS 使用结构化抽取将解释分解为 argument units，然后 faithfulness 通过逐 unit counterfactual intervention 评估。其他 baselines 产生自由文本——你们如何对它们进行同等的 unit-level intervention？如果 ARGUS 的结构化分解给了它评估优势，结果就不公平。"

**论文当前状态**: 未说明评估协议是否统一。

**修复**: 明确所有方法的输出都经过相同的抽取协议（§3.1）分解为 argument units，然后进行相同的 counterfactual intervention。

### 11-2: "AGM Inclusion 是同义反复" → DEFENDED

**审稿人攻击**: "Inclusion 展开后 = A\{deleted} ⊇ A\{deleted}，恒真。这不是有意义的 AGM adaptation。"

**论文防御**: theory.tex:30 已诚实承认："inclusion, as stated, follows constructively from the semantics of apply; the substantive minimal-change guarantee arises from cost optimization"。这种诚实度是优秀的学术实践。一个公正的审稿人会认可这种坦诚。

**评估**: 防御充分。审稿人可能仍在评审中提到，但不会因此拒稿。

### 11-3: "复杂度结果都是已知的" → DEFENDED

**审稿人攻击**: "NP-completeness 继承自 enforcement (Baumann & Brewka 2010)。添加 cost bound 不改变复杂度类。这不是新贡献。"

**论文防御**:
1. Introduction C2 将复杂度分析定位为修复算子的 *characterization*，不是独立贡献
2. Theorem 2 proof sketch 正确指出了继承关系（"hardness reduces from NP-hard extension enforcement"）
3. 真正的贡献是将 enforcement 复杂度与 LLM explanation repair 场景的连接

**评估**: 防御充分。KR 审稿人理解复杂度分析是形式化工作的标配。

### 11-4: "为什么不对比 enforcement solver？" → DEFENDED

**审稿人攻击**: "应该和 Wallner/Niskanen 等 enforcement 工具做性能对比。"

**论文防御**: related_work.tex:25-28 已解释任务差异——enforcement 改变 AF 使指定集成为 extension，ARGUS 修复 LLM 解释并最小化加权代价。两者目标不同，直接对比无意义。

**评估**: 防御充分。

### 11-5: "补充材料引用但不存在" → DEFERRED

theory.tex 两处引用 "supplementary material"（line 20, 57）但无补充材料文件。

**评估**: 必须在投稿前解决。选项：
1. 准备 supplementary.pdf（最佳）
2. 改为 "available in an extended version"（快速修复）

标记至 R12。

---

## 构造反例尝试

### 反例 1: Greedy 对 grounded 是否总是最优？

**场景**: AF 有一条长攻击链 a₁→a₂→...→aₙ→a_t，要恢复 a_t。

**分析**: grounded extension 通过特征函数迭代计算。greedy 过程可以逐步添加防御者。由于 grounded extension 唯一且单调（添加防御者只增加接受集），greedy 可以找到最优解。

**结论**: 反例构造失败。Theorem 2(1) 成立。

### 反例 2: k=3 是否可能遗漏最优修复？

**场景**: 目标 a_t 被 a_5 攻击，但最优防御者 a_6 距离 a_t 为 4（经过 a_5→a_7→a_8→a_6 路径）。

**分析**: k=3 会遗漏 a_6。此时 solver 会找到次优修复（可能直接删除 a_5）。

**结论**: Proposition 1 已正确限定 "when applied to the full framework without k-neighborhood restriction"（R8 修复）。k-neighborhood 是近似，不保证最优。论文正确处理。

### 反例 3: 多个最优修复时 Theorem 1 是否成立？

**场景**: 两个不同的修复 Ops₁ 和 Ops₂ 代价相同但删除不同的 arguments。

**分析**: Theorem 1 说 "every optimal repair" 满足三个公设。Success 对两者都成立（都是有效修复）。Inclusion 对两者都成立（cost > 0 阻止不必要删除）。Vacuity 对两者都成立（空修复总是唯一的零代价解）。

**结论**: 反例构造失败。Theorem 1 对所有最优修复成立。

---

## 新颖性评估

| 贡献 | 类似工作 | ARGUS 新增 | 评估 |
|------|---------|-----------|------|
| LLM → AF 映射 | ArgLLMs (2025) | Defense set 证书 | 增量创新 |
| 形式化修复算子 | Enforcement 文献 | 加权代价 + LLM 场景 | **核心创新** |
| AGM 适配 | Bisquert et al. (2013) | 针对 AF 修复的具体化 | 有价值的理论桥梁 |
| ASP + k-neighborhood | 标准 ASP 编码 | k-neighborhood 近似 | 实用贡献 |
| 实验评测 | ArgLLMs 只在小数据集 | 7 baselines × 2 数据集 | 全面 |

**综合评估**: 核心创新（最小改变修复算子）足够明确且有实质性贡献。单一贡献的深度可能不够顶会，但 C1-C4 组合在一起构成了完整的 formalization → theory → implementation → evaluation 链，适合 KR2026 的 "KR Meets ML" track。

---

## 回归检查（R1-R10 关键项）

| 历史问题 | 复检 |
|---------|------|
| 8-1: Stable complexity (credulous NP-c) | ✅ theory/experiments/method 全部一致 |
| 8-2/11-2: Inclusion 讨论 | ✅ 诚实承认在 theory.tex:30 |
| 8-3: Prop 1 scope | ✅ theory.tex:64 |
| 8-4: Consistency preferred/stable | ✅ theory.tex:33 |
| 9-1: experiments.tex Σ₂ᴾ | ✅ experiments.tex:106 |
| 9-2: 代码可用性 | ✅ experiments.tex:14 |
| 9-3: 改进百分比标注 | ✅ experiments.tex:51 |
| 9-4: FEVER Faith 0.829 | ✅ placeholders/dagang 已同步 |
| 10-1: method.tex Σ₂ᴾ | ✅ method.tex:116 |
| B1-B3: 历史核心问题 | ✅ 无变化 |

**无回归问题。**

---

## 编译验证

- Pages: **9** ✅
- Undefined references: **0** ✅
- 10 核心数值: **全部一致** ✅

---

## 审稿人可能的评分预测

| 维度 | 预估 | 风险 |
|------|------|------|
| Soundness | 4/5 | Inclusion 同义反复（已讨论），补充材料缺失 |
| Significance | 3.5/5 | 复杂度继承，单一创新深度有限 |
| Novelty | 4/5 | 修复算子是新的，AGM 适配有价值 |
| Clarity | 4.5/5 | Running example 贯穿，写作清晰 |
| Reproducibility | 3.5/5 | 代码承诺释放，但无 p-value/CI |

**预估综合评分**: 6.5-7.0/10 (Borderline Accept → Weak Accept)
**主要优势**: 完整的形式化链、KR 风格规范、Running example
**主要弱点**: 补充材料缺失、统计不完整、Inclusion 同义反复
