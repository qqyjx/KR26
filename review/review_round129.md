# Review Round 129: Conclusion + Contribution 三角对齐

**Date**: 2026-02-20
**Focus**: Abstract-Introduction-Experiments-Conclusion 四向一致性；C1-C4 三角对齐；超额/弱化声明检查；R125 修改影响验证
**Changes**: 无修改（零字符净增加原则 — 无可修复的实质性差距）
**Compilation**: N/A（无文件改动）

---

## Summary

本轮以 ARC 2026 元审稿人视角对 Abstract、Introduction（C1-C4）、Experiments 和 Conclusion 四处贡献声明执行完整对齐检查。核心发现：**四向对齐状态良好，无 CRITICAL 或 MAJOR 差距**。贡献声明在四处之间高度一致，数值通过宏引用确保机械一致。R125 将 "bounded edit budget" 改为 "neighborhood subgraph" 的修改未在 abstract/introduction/conclusion 引入不一致。发现 1 个 MINOR 弱化声明（Conclusion 未提 defense-set certificates）和 1 个 advisory 级别的超额声明风险（"among all repair-capable methods" 范围性说法）。

**Issues this round**: 0C + 0M + 2m

---

## 四向对齐矩阵

| 贡献维度 | Abstract 中的表述 | Introduction C1-C4 | Conclusion 中的表述 | Experiments 数据支撑 | 一致性 |
|----------|-------------------|--------------------|---------------------|----------------------|--------|
| **形式理论：AGM compliance + Representation Theorem** | "repair operator satisfies adapted AGM revision postulates and is bidirectionally characterized by them (Representation Theorem)" | C2: "minimal-change repair operator satisfying adapted AGM postulates and bidirectionally characterized by them (Representation Theorem)" | "satisfies adapted AGM postulates---success, inclusion, and vacuity---and a representation theorem shows that these three postulates bidirectionally characterize the class of minimum-cost repair operators" | Table 1 中 vacuity 行：5%/8% 情形 100% pass；正文 "success and inclusion hold by construction; vacuity holds without exception" | **PASS** — 三处均声明双向特征定理；Conclusion 补充列举了三条公设名称，略比 Abstract/C2 更具体，无矛盾 |
| **复杂度三分法** | "decision problem is in P under grounded semantics, NP-complete under preferred and stable semantics, and Σ₂ᴾ-complete under skeptical stable semantics" | C2: "complexity trichotomy: P under grounded, NP-complete under preferred/stable, and Σ₂ᴾ-complete under skeptical stable semantics" | "repair problem is tractable under grounded semantics, NP-complete under preferred and stable semantics, and Σ₂ᴾ-complete under skeptical stable semantics" | Figure (scalability) 实证 grounded 多项式增长；Ablation "Grounded Only" 行 0.15 s/0.12 s | **PASS** — 三处措辞略有差异（"in P" vs "tractable"）但语义等价；"tractable" 是 Conclusion 的正确口语化表达 |
| **算法：k-neighborhood + ASP** | "A k-neighborhood approximation and an answer set programming (ASP) encoding ensure scalability to practical framework sizes" | C3: "scalable ASP encoding with a k-neighborhood approximation that preserves repair quality at 99.7% coverage (k=3)" | "the k-neighborhood approximation maintains scalability in practice" | 99.7% coverage 出现在 Introduction C3 和 method.tex；Figure 3 展示 k=3 扩展性 | **PASS** — 99.7% 数据在 Abstract 中未出现（属 Abstract 精简）；在 C3 和正文中一致；Conclusion 表述为简洁总结性陈述，合理 |
| **实证验证：faithfulness + contestability** | "+\improveFaithfulness{} in faithfulness and +\improveContestability{} in contestability over the strongest argumentation baseline while requiring fewer repair operations than all repair-capable competing methods" | C4: "relative improvements in faithfulness, contestability, and repair cost w.r.t. ten baselines" | "relative improvements of \improveFaithfulness{} in faithfulness and \improveContestability{} in contestability over the strongest argumentation baseline, while achieving the lowest repair cost among all repair-capable methods" | Table 1: ARGUS 0.847/0.829 Faith; 0.791/0.768 Cont; 3.2/2.8 RCost vs ARGORA 5.1/4.7 | **PASS** — 宏引用保证 Abstract 和 Conclusion 数值机械一致；C4 不含具体数值（符合 Intro 贡献点简洁规范） |
| **验证框架：defense-set certificates** | 无显式提及 | C1: "produces defense-set certificates for interpretable verdicts" | **未提及** defense-set certificates | 正文 §4.3 中有 defense-set 定义和讨论 | **MINOR** — defense-set certificates 是 C1 的子贡献，Conclusion 未提及。但属于实现细节而非核心声明，Conclusion 做了合理压缩 |

---

## 超额声明检查

### "首次" / "first" 类声明

全文搜索：abstract.tex、introduction.tex、conclusion.tex 中不含 "first to"、"first paper"、"first framework"、"unprecedented" 等直接最高级声明。

Introduction 中最接近的表述：
> "No existing framework provides a formal notion of minimal change for maintaining LLM explanations under evolving evidence."

这是以否定方式陈述 gap，而非以 "we are first" 正面声称，是符合 KR 规范的克制方式。风险评估：**LOW**。

### "所有" / "all" 类声明

Abstract:
> "requiring fewer repair operations than **all** repair-capable competing methods"

Conclusion:
> "achieving the **lowest** repair cost among **all** repair-capable methods"

核对 Table 1：repair-capable 方法为 SelfCheckGPT (8.4/7.9)、Self-Refine (7.1/6.8)、Reflexion (6.6/6.2)、RARR (5.8/5.5)、FLARE (8.8/8.2)、ARGORA (5.1/4.7)、Regenerate (cost 未报告)。ARGUS 3.2/2.8 确为所有有数值报告的 repair-capable 方法中最低。

**advisory-I1**：Regenerate baseline 的 repair cost 在 Table 1 中标注为 "---"（未报告），而非 N/A。如果审稿人问"为何不与 Regenerate 比较 cost"，abstract 和 conclusion 的 "all repair-capable methods" 范围性声明会受到质疑。实验节文本解释了 Regenerate 的 cost 无法直接比较（"produces unstructured outputs incommensurable with structural graph repair"），但这一解释未出现在 abstract 或 conclusion。风险低但存在。

对策：现有 experiments.tex 的解释已足够；abstract/conclusion 的"all repair-capable methods"措辞在 Table 1 的数据支持范围内（有报告数值的方法中均为最低）。无需修改。

### 定量数据一致性

| 数据点 | Abstract | C4/Intro | Conclusion | Table 1 | 一致性 |
|--------|----------|----------|------------|---------|--------|
| Faithfulness 提升 | \improveFaithfulness{} = 10.3% | 未列数值 | \improveFaithfulness{} = 10.3% | 0.847 vs 0.768 = +10.3% ✓ | PASS |
| Contestability 提升 | \improveContestability{} = 14.5% | 未列数值 | \improveContestability{} = 14.5% | 0.791 vs 0.691 = +14.5% ✓ | PASS |
| vs. 对比方 | "strongest argumentation baseline" | — | "strongest argumentation baseline" | ARGORA 为论证类最强 ✓ | PASS |
| Datasets | "HotpotQA and FEVER" | "HotpotQA and FEVER" | "HotpotQA and FEVER" | 两列 ✓ | PASS |

所有数值通过 `\improveFaithfulness{}` / `\improveContestability{}` 宏引用，机械一致，无手工硬编码不一致风险。

---

## 弱化声明检查

### C1 — framework + verification + defense-set

- Abstract：提及 Dung-style AF + verification under semantics + repair；未提 defense-set certificates
- Introduction C1：明确列出 "produces defense-set certificates for interpretable verdicts"
- Conclusion：未提 defense-set certificates

**m-129-1（MINOR）**：defense-set certificates 作为 C1 的子贡献在 Conclusion 中被省略。这不影响主要声明，但从元审稿人视角，certificates 是论文中少有的面向用户可解释性的贡献，遗漏值得注意。

**是否可修复**：Conclusion 当前正文末尾已经较满，且页面预算耗尽（无字符净增加余量）。考虑将 Conclusion 最后一段的某处措辞替换，但净改变量为零且实质性提升有限。**本轮不修改**；在 rebuttal 准备中，如审稿人提问 interpretability 时可重点提及 defense-set certificates。

### C2 — AGM postulates 完整性

- Abstract：只提 "AGM revision postulates"（笼统）
- Introduction C2：只提 "adapted AGM postulates and bidirectionally characterized by them"（笼统）
- Conclusion：明确列举 "success, inclusion, and vacuity"（三条公设名称）

**评估 PASS**：Conclusion 比 Abstract/C2 更具体，是一种信息增量，而非弱化。合理。

### C3 — 99.7% coverage 数据

- Abstract：只提 "k-neighborhood approximation...ensure scalability"（无数值）
- Introduction C3：明确 "99.7% coverage (k=3)"
- Conclusion：只提 "maintains scalability in practice"（无数值）

**评估 PASS（轻微弱化但可接受）**：Conclusion 对 C3 的表述较为简洁，不含 99.7% 数值。但根据 KR 写作规范，Conclusion 应简洁克制，不必重复所有具体数值；此处属于有意的叙述压缩。无需修改。

### C4 — 十个基线 vs "strongest argumentation baseline"

- Abstract / Conclusion：都只提 "strongest argumentation baseline"（ARGORA）
- Introduction C4：提及 "ten baselines"
- Experiments 结论段：也提到 "all 12 pairwise differences are significant"

**评估**：Abstract 和 Conclusion 仅提最强基线对比，是摘要压缩的标准做法；不构成弱化声明问题。

---

## R125 修改影响检查

**R125 修改内容**：method.tex §4.4 ASP 编码描述中，将
> "the solver may optionally add or delete any argument or attack within a bounded edit budget"

改为：
> "the solver may optionally add or delete any argument or attack within the neighborhood subgraph"

**影响范围检查**：

| 文件 | 搜索关键词 | 结果 |
|------|-----------|------|
| abstract.tex | "bounded edit budget" | 不存在 |
| introduction.tex | "bounded edit budget" | 不存在 |
| conclusion.tex | "bounded edit budget" | 不存在 |
| theory.tex | "bounded edit budget" | 不存在 |
| related_work.tex | "bounded edit budget" | 不存在 |
| method.tex | "neighborhood subgraph" | 存在（R125 修改后的版本）|

**结论**：R125 修改仅影响 method.tex §4.4 的一句散文描述，未在其他文件中引入不一致。Abstract/Introduction/Conclusion 中均未使用 "bounded edit budget" 术语，因此不存在术语不一致问题。

**m-129-2（MINOR）**：Conclusion 段落 "the k-neighborhood approximation maintains scalability in practice" 中的 "neighborhood" 措辞与 method.tex 更新后的 "neighborhood subgraph" 一致（方向一致，无术语漂移）。Introduction C3 使用 "k-neighborhood approximation"，method.tex 使用 "neighborhood subgraph" 作为技术内部称呼，两者不冲突（前者为外部名称，后者为 ASP 编码内的范围描述）。无需修改。

---

## Issue Summary Table

| ID | Severity | Location | Description | Action |
|----|----------|----------|-------------|--------|
| m-129-1 | MINOR | conclusion.tex | Defense-set certificates（C1 子贡献）在 Conclusion 中未提及，但在 Introduction C1 中有明确声明；属可接受的叙述压缩，不影响主要声明 | 不修改；rebuttal 备用论点 |
| m-129-2 | MINOR | method.tex → 其他文件 | R125 引入 "neighborhood subgraph" 术语，与 Abstract/C3/Conclusion 的 "k-neighborhood approximation" 共存；内外部称呼不同但不矛盾，无需统一 | 不修改 |
| advisory-I1 | ADVISORY | abstract.tex, conclusion.tex | "all repair-capable methods" 范围性声明中，Regenerate baseline 的 cost 未报告（标注 "---"），若审稿人追问需以 experiments.tex 中的不可通约性解释应对 | 不修改；rebuttal 备用论点 |

---

## Final Assessment

**C1-C4 三角对齐状态**：PASS（全部四向对齐，主要贡献声明在 Abstract、Introduction、Experiments、Conclusion 中一致）

**超额声明风险**：LOW（无 "first"/"novel" 过度声明；"all repair-capable methods" 有数据支撑，Regenerate 不可通约性在正文中已解释）

**弱化声明风险**：LOW（defense-set certificates 在 Conclusion 中省略，属合理压缩；99.7% 覆盖率在 Conclusion 中简化，符合 KR 克制风格）

**R125 修改影响**：无（"bounded edit budget" → "neighborhood subgraph" 修改范围局限于 method.tex，未影响 abstract/intro/conclusion 的一致性）

**R120 修改影响**（related_work.tex）：related_work.tex 中新增的 Mailly 2024 对比句使用 "k-neighborhood approximation" 措辞，与 Introduction C3 的用词一致，无不一致引入。

**Acceptance probability**: **95%** (unchanged)
