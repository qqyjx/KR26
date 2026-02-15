# Round 18 审稿报告：对抗性审稿模拟 + 全量回归

**日期**: 2026-02-15
**轮次**: Round 18 (最终轮)
**视角**: 最苛刻 KR 审稿人 — 怀疑 LLM 论文进 KR，熟悉 enforcement 文献
**目标**: 消除残余弱点，最终回归确认

---

## 对抗性审稿：Top 5 攻击 + 防御

### A1: "这就是 enforcement 加预处理" — MAJOR (已有防御，难进一步加强)
**攻击**: 核心 repair operator 本质上是 weighted enforcement。复杂度证明显式使用 reduction to enforcement。
**当前防御**:
- Remark 列出 3 个结构性差异：(i) evidence update Δ 耦合搜索空间；(ii) 异构代价函数；(iii) NLI 管道约束
- AGM 合规分析（5/8 公设讨论）是 enforcement 文献没有的
- Related Work 精准定位与 Baumann/Coste-Marquis/Wallner/Alfano 的区别
**评估**: 防御充分但不压倒性。这是最大风险点——取决于审稿人是否接受 "组合 + 应用领域" 构成足够新意。

### A2: "只用 uniform cost" — MAJOR (已承认，pilot 充分)
**攻击**: 3 种 cost model 只有 uniform 做了全量实验。
**当前防御**: pilot study 100 实例，结论"cost model 影响 style 不影响 quality"。Sensitivity Analysis 段落明确报告。
**评估**: 对 KR 审稿人够用（KR 重理论轻实验）。ML 审稿人可能要求全量。

### A3: "只有 2 个数据集" — MAJOR (KR 标准可接受)
**攻击**: HotpotQA + FEVER 都是英文 NLP benchmark，人造 evidence update。
**当前防御**: 明确承认限制（conclusion），scalability 到 |A|=50 的合成实验。KR 常规：2-3 数据集是标准。
**评估**: 可接受。KR 历史上 1-2 数据集常见。

### A4: "Faithfulness 评估循环论证" — MAJOR → ADDRESSED
**攻击**: 同一 LLM 生成、分解、评估——闭环。
**当前防御**:
- R18 新增：conclusion 中明确承认 "faithfulness metric itself relies on the LLM's consistency under ablation, providing a causal proxy rather than a ground-truth measure"
- experiments 中解释了统一评估确保跨方法公平性
**评估**: 已显式承认。审稿人可能仍不满意但不会说论文"回避"了这个问题。

### A5: "AGM 只证了 3/8 公设" — MINOR-MAJOR (已充分处理)
**攻击**: 只证 success/inclusion/vacuity，其余 5 个要么 informal assert 要么 dismissed。
**当前防御**:
- Consistency/extensionality 有一句 proof sketch（R13 强化）
- Recovery 有具体反例（R13）
- Closure/superexpansion/subexpansion 解释为 "presuppose deductively closed belief sets"
- 明确说 "full axiomatic characterization is a direction for future work"
**评估**: 对 conference paper 足够透明。期刊版本需更完整。

---

## 数据不一致修正

| ID | 问题 | 修正 | 状态 |
|----|------|------|------|
| D1 | Histogram cost=0 (5%, 8%) 与原文 21.7% vacuity 矛盾 | 将 "78.3%/21.7%" 改为 "93%/5%+8%"，与 histogram 一致 | **FIXED** |
| D2 | Conclusion limitation 未显式承认 faithfulness 循环性 | 添加 "faithfulness metric itself relies on LLM's consistency under ablation" | **FIXED** |

---

## 全量回归检查

| 类别 | 检查项 | 通过 | 失败 |
|------|--------|------|------|
| R13 理论深度 | 3 fixes | 3 | 0 |
| R14 统计严谨性 | 4 fixes | 4 | 0 |
| R15 缺失引用 | 3 fixes | 3 | 0 |
| R16 形式化精确性 | 4 fixes | 4 | 0 |
| R17 表达力优化 | 6 fixes | 6 | 0 |
| 10 核心宏 | 10 values | 10 | 0 |
| 34 参考文献 | 34 entries | 34 | 0 |
| Undefined citations | 1 check | 1 | 0 |
| Set/sequence 术语 | 1 check | 1 | 0 |
| Histogram-vacuity | 1 check | 1 | 0 |
| 页数限制 | 1 check | 1 | 0 |
| **总计** | **68** | **68** | **0** |

---

## 编译验证

- Pages: **9 + 2 refs = 11** ✅
- Overfull: **0** ✅
- Undefined citations: **0** ✅

---

## 最终评分预估

| 维度 | R12 预估 | 当前 | 变化 | 关键改进 |
|------|----------|------|------|---------|
| Soundness | 4.0 | 4.5 | +0.5 | R13 AGM 深化, R16 形式化精确 |
| Significance | 3.5 | 4.0 | +0.5 | R13 理论强化, R17 insight 句 |
| Novelty | 4.0 | 4.5 | +0.5 | R15 三篇新引用 + 差异化 |
| Clarity | 4.5 | 5.0 | +0.5 | R16 术语一致性, R17 表达优化 |
| Reproducibility | 3.5 | 4.0 | +0.5 | R14 统计报告, 错误分析 |
| **综合 (1-10)** | **6.5-7.0** | **7.5-8.0** | **+1.0** | |
| **中稿概率** | **~35%** | **~55-65%** | **+20-30pp** | |

**剩余风险**: A1（enforcement 批评）是最大不确定性来源。如果 reviewer 来自 enforcement 社区且不接受 "组合新意" 论证，可能给 borderline reject。但论文的透明性和对自身限制的坦诚承认应该获得大多数审稿人的好评。
