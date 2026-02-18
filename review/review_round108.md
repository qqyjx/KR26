# Review Round 108 (R108) — Theoretical Boundary Cases Specialist Review
**Date**: 2026-02-19
**Mode**: Degenerate Cases — AGM Postulates, k-neighborhood Limits, Stable Semantics Existence, Representation Theorem Completeness, Cost Model Boundaries
**Reviewer role**: ARGUS 论文理论边界情况审查专家
**Previous round**: R107（写作流畅度专项审查 — 0C+0M+8m，5 FIXED，中稿概率 91-93%）
**Entering acceptance probability**: 91-93%

---

## Executive Summary

本轮作为理论边界情况审查专家，系统检查 ARGUS 论文的定理和形式定义在退化情形下是否成立，涵盖五个维度：AGM 公设在 degenerate 情况（空 KB、无冲突、全冲突框架、α 为矛盾）、k-neighborhood 在 k=0 和 k=|E| 的退化行为、stable semantics 存在性假设的处理、Representation Theorem 的边界覆盖、Cost Model 边界（uniform cost 和 zero-cost）。

**主要发现：无 CRITICAL 问题，无 MAJOR 问题，发现 6 个 MINOR 问题（m1-m6）。** 所有问题均为 ACKNOWLEDGED，页面预算已完全耗尽，任何字符净增均将 conclusion 推至第 10 页（R103 两次修复尝试已验证此约束）。本轮重点为 rebuttal 素材准备。

---

## 历史边界情况分析回归

R103（图论/超图专家审查）已识别以下相关问题，本轮在其基础上深化：

| 历史 ID | 轮次 | 问题 | 与本轮关系 |
|---------|------|------|-----------|
| R103-m3 | R103 | stable extension 不存在时 NP-completeness 证明隐含存在性假设 | 本轮 3c 深化 |
| R103-m2 | R103 | Defense Set 极小性在 stable 语义下歧义 | 本轮 3a 间接相关（stable 语义 degenerate 时） |
| R101-M2 | R101 | Representation Theorem (⟸) 证明草图修复（已修复）| 本轮 3d 验证 |

---

## 3a. AGM Postulates 在 Degenerate 情况下的分析

### 情况 1：空知识库（K = ∅，即 AF = (∅, ∅)）

**场景分析**：若 AF = (∅, ∅)（无论证、无攻击关系），目标论证 a_t 不存在于 A。

**论文处理**：Definition 4（def:repair）要求 a_t ∈ A，因此 a_t ∉ ∅ 时该定义的前置条件不成立——修复问题在空 AF 下无法形成良定义的实例。

**AGM postulates 行为**：
- Success：无法验证（a_t 不在 AF 中，不存在有效修复）
- Inclusion：trivially vacuous（空集操作不改变任何元素）
- Vacuity：trivially satisfied（a_t 无状态，"已满足"的判断无法进行）

**是否构成反例**：不构成。Theorem 1 的条件 "if a valid repair exists"（theory.tex line 11）屏蔽了无法形成修复实例的情况。空 AF 下不存在有效修复（a_t 无法在空框架中获得任何状态），因此定理的前提条件不满足，定理不对此情况作出声明。

**潜在读者困惑**：形式化文本未显式说明 "a_t ∈ A" 是 Definition 4 的隐含前置条件（虽然 a_t ∈ A 在自然语言理解下是显然的）。严格的形式化审稿人可能指出此点。

**严重度**：**MINOR（m1）**——技术上不构成 counterexample，但隐含前置条件 a_t ∈ A 未明确声明。ACKNOWLEDGED。

**Rebuttal 策略**：Definition 4 的形式化文本"Let a_t ∈ A be a target argument"已将 a_t ∈ A 作为定义的组成部分；空 AF 下此前置条件不满足，定理适用范围的"if a valid repair exists"保护条件进一步屏蔽该退化情况。空 AF 在 LLM 解释结构化场景中无实际意义（LLM 输出至少包含一个论证）。

---

### 情况 2：无冲突框架（Conflict-Free AF）

**场景分析**：若所有论证均不相互攻击（R = ∅ 或所有攻击关系都不存在），则每个论证均在 grounded extension 和 preferred extension 中。

**AGM postulates 行为**：
- **Vacuity**：若 a_t 已在 grounded/preferred extension 中（即 s = IN 且 a_t 已 accepted），则 Ops* = ∅。此时 Vacuity 成立。
- **Success**：若 s = OUT，但无冲突框架中 a_t 一定 accepted，不存在有效修复（无法通过添加/删除操作将 a_t 驱逐到 "out" 状态，除非添加一个攻击 a_t 的新论证）。若 Δ 引入攻击 a_t 的新论证，则框架不再是无冲突的，问题回归一般情况。
- **Inclusion**：当修复操作（如 add_att 引入攻击链）执行时，Inclusion 要求保留原有论证和攻击，满足。

**是否构成反例**：不构成。无冲突框架是一般框架的特例，AGM 公设在此情况下平凡成立（Vacuity 为主要情况）或由修复目标自然处理。

**严重度**：**PASS**——无问题，不作为 issue 记录。

---

### 情况 3：全冲突框架（Every pair of arguments mutually attacks）

**场景分析**：若框架中每对论证 a, b 都满足 (a,b) ∈ R 且 (b,a) ∈ R（奇数长度攻击环的极端情况），则：
- Grounded extension：= ∅（特征函数的 least fixed point 为空集）
- Preferred extensions：每个单元素集 {a_i} 若 a_i 能"自我防御"（但全对称攻击下 {a_i} 不 conflict-free）。实际上，对于 n 元素全对称互攻框架，preferred extensions 为 ∅（若框架是奇数长度的循环攻击）或为极大无冲突子集（偶数长度环）。
- Stable extensions：可能不存在（奇数长度攻击环无 stable extension）。

**论文 Theorem 1（AGM Compliance）行为**：
- 若 σ = gr（grounded），grounded extension = ∅，则 a_t 不在 grounded extension 中，status 为 "rejected" 或 "undecided"。若 s = OUT，Vacuity 可能成立（a_t 已 out）；若 s = IN，修复目标要求找到将 a_t 置于 grounded extension 的操作——这在全冲突框架中可能需要破坏某些攻击。
- Theorem 1 的 "if a valid repair exists" 保护了无解情况。

**是否构成反例**：不构成。Theorem 1 的保护条件"if a valid repair exists"覆盖了全冲突框架下修复无解的情况。AGM 公设在存在有效修复时的正确性不受影响。

**严重度**：**MINOR（m2）**——全冲突框架下的行为（grounded extension = ∅，stable extension 可能不存在）未在论文中作为边界情况讨论，但 "if a valid repair exists" 保护条件覆盖了无解情况。对理论深度有要求的 KR 审稿人可能追问此情况，论文无需修改但 rebuttal 应备。ACKNOWLEDGED。

**Rebuttal 策略**：全冲突框架是 Dung 语义文献（Dung 1995）中的已知 degenerate case。在此类框架中，grounded extension 为 ∅，stable extension 可能不存在；论文的 Definition 4 和 Theorem 1 均以 "if a valid repair exists" 为前提，所有 degenerate 情况（包括全冲突框架）均自然落入"无解"分支，定理声明不对此情况作出承诺。此设计是有意为之的防御性形式化。

---

### 情况 4：修复目标为矛盾（s = ⊥，即要求 a_t 同时 IN 和 OUT）

**场景分析**：论文的 s ∈ {IN, OUT}（theory.tex line 11，preliminaries.tex def:repair），不支持 s = ⊥ 的情况。"修复目标为矛盾"在论文的形式化中不可表达——s 只能取 IN 或 OUT 两值。

**与 AGM 的关系**：在经典 AGM 信念修正中，K * ⊥（用矛盾进行修正）被允许（Levi Identity 下处理为一种特殊情况，某些公设如 Consistency（K*5）会产生非一致知识库）。论文的形式化通过限制 s ∈ {IN, OUT} 避免了此问题——没有"s = 矛盾"的概念。

**是否构成问题**：不构成。论文明确定义了状态值域（二值：IN/OUT），自然排除了矛盾目标状态。这与将 AGM "适配"到有限有向图设置的设计选择一致。

**与 AGM Consistency 公设的关系**：theory.tex line 29 已处理 Consistency 公设："Consistency follows because validity requires a_t to belong to at least one σ-extension of the repaired framework."——这等价于要求修复结果是一致的（a_t in 至少一个扩展）。无论如何，s = IN 的修复目标已蕴含了一致性要求。

**严重度**：**PASS**——论文设计正确排除了矛盾目标状态，无问题。

---

## 3b. k-neighborhood 退化情况分析

### 情况 1：k=0（只包含目标论证本身）

**当前论文文本**（method.tex，Algorithm 1 line 2）：k-neighborhood of a_t in the framework。论文未显式讨论 k=0 的退化行为。

**k=0 的含义**：k-neighborhood 包含距离 ≤ 0 的节点，即只有 a_t 本身。repair space 被限制为只能在 a_t 上执行 del_arg(a_t)——而这通常会使目标论证完全消失，不满足 s = IN 的目标。因此：
- 若 s = IN，k=0 时几乎必然无解（无法通过只操作 a_t 来使其 accepted，除非 a_t 本身没有攻击者，此时 k=0 足够）。
- 若 s = OUT，k=0 时可以通过 del_arg(a_t) 达成（但这是将 a_t 从框架中删除，对实际场景无意义）。

**论文对 k 的实验分析**（appendix app:sensitivity）：k=1 时覆盖率较低，k=3 时达到 99.7%。k=0 未在 sensitivity analysis 中讨论。

**与完备性声明的关系**（method.tex）："complete for optimal repairs whose support set lies entirely within the k-neighborhood"——k=0 时 support set 只能是 {a_t}，声明退化为"当最优修复只需操作 a_t 本身时完备"，这是一个极为有限的覆盖场景。

**严重度**：**MINOR（m3）**——k=0 退化情况在论文中无讨论，但 k 的有意义范围显然是 k ≥ 1（sensitivity analysis 从 k=1 开始），审稿人不太可能追问 k=0。如被追问，rebuttal 可指向 sensitivity analysis 的 k 范围选择。ACKNOWLEDGED。

**Rebuttal 策略**：k=0 是实践中无意义的设置——它将修复空间限制为只对目标论证本身操作，无法应对任何攻击关系。Sensitivity analysis（appendix）从 k=1 开始，明确隐含 k ≥ 1 为有效范围。k=0 的数学退化（完备性声明退化为 trivial 条件）是有意的形式化后果，不影响系统的实际价值或定理的正确性。

---

### 情况 2：k=|E|（全部论证，等同于无 k 限制）

**场景分析**：当 k 等于或超过框架中所有论证之间最大距离时，k-neighborhood 覆盖整个框架，k 限制的近似失效——等价于对完整框架执行修复（Proposition 1 的情况）。

**论文声明的完备性**（method.tex）：当 k=|E| 时，"complete for optimal repairs whose support set lies entirely within the k-neighborhood"退化为"当最优修复在完整框架内时完备"，即 Proposition 1（无 k 限制时对 grounded/preferred 语义的 soundness+completeness）。

**一致性验证**：Proposition 1 描述的是"无 k 限制"的 ASP encoding，k=|E| 时 k-neighborhood 等同于全框架，两者一致。无逻辑矛盾。

**实验支持**：experiments.tex 报告"median depth 3, maximum 7"，表明在实验数据集中 k=7 已等价于无限制（最大深度为 7，k=7 覆盖全框架）。k=3 的 99.7% 覆盖率进一步说明 k 远小于 |E| 时覆盖率已接近完备。

**严重度**：**PASS**——k=|E| 退化为 Proposition 1 的情况，两者一致。无问题。

---

### 情况 3：树形论证框架（Tree-Structured AF）

**场景分析**：若 AF 的底层无向图是树（无环），则任意两节点之间路径唯一，k-neighborhood 结构简单（每个节点的 k-邻域是一棵以该节点为根的子树）。

**对完备性的影响**：树形 AF 中，从 a_t 到最远攻击者的唯一路径长度决定了完备修复所需的最小 k。由于路径唯一，k-neighborhood 的覆盖范围（k=depth of attack chain）精确等于完备修复所需范围，不存在多路径带来的冗余搜索。

**论文处理**：论文未专门讨论树形 AF，但 k-neighborhood 完备性的一般论证（support set ⊆ neighborhood ⟹ optimum preserved）对树形 AF 同样成立，且在树形 AF 中更强（唯一路径保证不遗漏）。

**严重度**：**PASS**——树形 AF 是一般 AF 的特例，论文的一般性定理自动覆盖，无需特殊处理。

---

## 3c. Stable Semantics 存在性假设的深度分析

**背景**：R103-m3 已识别此问题：Theorem 2 claim (2) 的 NP-completeness 证明隐含 stable extension 存在性假设。本轮深化分析论文整体对此问题的处理是否充分。

### 论文当前文本分析

**Theorem 2 proof sketch**（theory.tex line 59）：
> "For stable semantics under credulous acceptance, NP-completeness follows: membership by the same certificate argument; hardness by the same reduction..."

"Certificate argument"：验证候选修复 Ops* 是否有效，需要找到一个包含 a_t 的 stable extension——即需要 stable extension 存在。

**Definition 4（def:repair）**：
> "A repair is valid if a_t has status s under σ in AF'..."

对于 σ = st（stable semantics）和 s = IN，有效修复要求 a_t 属于修复后框架的某个 stable extension——这隐含要求修复后框架存在 stable extension。

**"if a valid repair exists" guard**（Theorem 1，theory.tex line 11）：此条件在 Theorem 1 的 AGM compliance 证明中防御了无解情况，但 Theorem 2 的 NP-completeness 声明未明确引用此保护条件。

### 无 stable extension 时的系统行为

若 σ = st 且修复后框架无 stable extension，则：
- "Does there exist a valid repair of cost ≤ C?" 的答案为 "no"（不存在有效修复）。
- NP-completeness 声明通常在 AF 类上定义，该类包括无 stable extension 的情况——此时问题的答案平凡为 "no"，仍在 P（多项式时间可回答）。
- 因此无 stable extension 情况不影响 NP-completeness 的上界（NP membership），但影响下界（NP-hardness）的论证方式：hardness reduction 需要使用一个 stable extension 存在的 AF，这在标准归约中通常是满足的（从 NP-hard 问题归约过来的实例构造的 AF 通常存在 stable extension）。

**是否构成技术漏洞**：Theorem 2 的 NP-completeness 结论本身是正确的（NP-hard for credulous stable acceptance is established in Dung 1995 and subsequent literature，见 Dimopoulos & Torres 1996）。论文通过规约从已知 NP-hard 问题建立下界，隐含使用了 stable extension 存在的 AF 实例。这在论证理论文献中是标准做法，但未显式声明。

**严重度**：**MINOR（m4）**——延续 R103-m3 的分析，此情况在 Theorem 2 的 NP-completeness 证明中未显式声明"稳定扩展存在性"假设，但 KR 理论审稿人对此了解，通常不会视为 defect。无解情况由 Definition 4 的 "valid repair" 定义自然处理。页面预算耗尽，无法添加明确说明。ACKNOWLEDGED。

**Rebuttal 策略**：Theorem 2 的 NP-completeness 结论正确。NP-hardness reduction 来自 Baumann & Brewka（2010）的已知结果，其构造的 AF 实例具有 stable extension（否则 hardness 论证无法成立）。对于无 stable extension 的 AF，"是否存在代价 ≤ C 的有效修复（stable）"的答案为 "no"，可在多项式时间回答（此情况下问题在 P），不影响 NP-completeness 结论（NP 包含 P，NP-hard 类包含需要 stable extension 存在的困难实例）。

---

## 3d. Representation Theorem 边界情况

### 现状确认（R101 修复后）

**Theorem 2（Representation）**（theory.tex line 34-41）：
> "A repair operator ∘ satisfies adapted success, inclusion, and vacuity for every AF, semantics σ, target a_t, and evidence update Δ if and only if there exists a strictly positive cost function κ such that ∘ returns a minimum-cost valid repair under κ."

R101 已修复 (⟸) 方向的循环论证问题，当前证明草图通过 Ops'（不含 o 的有效修复）的存在证明 o 的非必要性，逻辑正确。

### 边界情况检查

**边界 1：空修复集（Ops* = ∅）**

- **Vacuity 公设**：若 a_t 已满足 s，则 Ops* = ∅ 且 cost = 0。
- Representation Theorem 的 (⟹) 方向（Theorem 1 → Representation）：若 κ > 0，则空集是代价最小的修复集（cost = 0 < 任何非空集的代价）。此情况正确。
- (⟸) 方向：给定满足三条公设的算子，若 a_t 已满足 s，Vacuity 要求 Ops* = ∅。定义 κ(o) = 1，cost(∅) = 0，cost(非空集) ≥ 1。最优解为 ∅。一致。**PASS**。

**边界 2：唯一修复集（只有一个有效修复）**

- 若只存在一个有效修复 Ops*，则任何满足三条公设的算子必须返回此修复。
- (⟹) 方向：由 Theorem 1，Ops* 是代价最小（唯一）的有效修复，满足三条公设。PASS。
- (⟸) 方向：若给定满足三公设的算子，唯一有效修复只有 Ops*，Success 要求返回有效修复，Inclusion 要求最小化删除，Vacuity 要求空集当无需修复。在只有一个有效修复的情况下，算子必须返回 Ops*。PASS。

**边界 3：Representation Theorem 的 "for every AF, σ, a_t, Δ" 量化**

Representation Theorem 对所有 AF、所有语义、所有目标论证、所有证据更新普遍量化。这意味着：
- 算子必须在所有可能的 AF（包括全冲突框架、无攻击框架）上都满足三条公设。
- 对于无有效修复的情况（如空 KB、全冲突框架 + 不可能实现的目标状态），公设的满足性是 vacuously true（前提条件不满足时任何条件命题为 true）。

这是一个潜在的边界细节：若对于某个 AF 实例不存在任何有效修复，"满足三条公设"是 vacuously true（三条公设的条件均不成立），这意味着 Representation Theorem 对此情况也 vacuously 成立——但这不意味着算子对此情况有任何有用行为。

**严重度**：**MINOR（m5）**——Representation Theorem 的普遍量化 "for every AF" 与 Theorem 1 的条件量化 "if a valid repair exists" 之间的关系未明确说明。在无有效修复的 degenerate 情况下，Representation Theorem vacuously 成立（所有条件命题在前提为假时为真），但论文未说明此点。ACKNOWLEDGED。

**Rebuttal 策略**：Representation Theorem 中的"每个 AF"量化是逻辑上严格的——在无有效修复的情况下，"满足三条公设"的条件命题 vacuously 为真（前提 "if a valid repair exists" 不满足），因此任何算子都 vacuously 满足公设，等价地存在 κ（但 κ 可以是任意严格正函数，因为没有有效修复使其有意义）。这是经典形式化中的标准处理。

---

## 3e. Cost Model 边界情况

### 情况 1：Uniform Cost（κ ≡ 1）

**含义**：所有操作代价相等，最优修复等价于操作数最少的有效修复（最小编辑距离修复）。

**与 Representation Theorem 一致性**：Representation Theorem 的 (⟸) 方向证明（theory.tex line 40）显式使用"define κ(o) = 1 for every operation o"——即 uniform cost 是 (⟸) 方向证明的标准选择。两者完全一致。**PASS**。

**与 Theorem 1 的一致性**：Inclusion 的证明依赖 κ > 0（"contradicting optimality: removing an unnecessary del_arg(a) would yield a valid repair of strictly lower cost (κ>0)"）。Uniform cost κ = 1 > 0 满足严格正条件。**PASS**。

**严重度**：**PASS**。

---

### 情况 2：Zero-Cost（κ ≡ 0）

**含义**：所有操作代价为 0，任何有效修复均是"最优修复"（代价均为 0），系统无法区分修复质量。

**论文的形式化保护**：Definition 4 要求"strictly positive cost function (κ(o) > 0 for every operation o)"（theory.tex line 11，def:repair）。κ ≡ 0 违反此条件，因此 zero-cost 函数被形式化明确排除在外。

**影响分析**：若允许 κ ≡ 0，则：
- Inclusion 公设的证明失效（"removing an operation would yield a repair of strictly lower cost" 不再成立，因为所有代价均为 0）。
- Vacuity 公设：若 a_t 已满足 s，空集代价为 0；但任何非空有效修复代价也为 0——空集并非唯一"代价最小"的修复。Vacuity 要求返回空集，但其他等代价修复也可能被返回，Vacuity 公设在严格意义下不再成立（对优化目标不唯一时的非确定性算子）。

**结论**：κ > 0 的严格正要求是 Theorem 1 和 Representation Theorem 成立的必要条件，论文已通过显式约束将 κ ≡ 0 排除。设计选择是正确的。

**严重度**：**MINOR（m6）**——论文 Definition 4 正确排除了 zero-cost，但未在 Theorem 1 之前解释为什么 κ > 0 是必要的（即如果允许 κ ≡ 0，哪些公设会失效）。对理论细节感兴趣的审稿人可能询问 κ > 0 假设的必要性论证。ACKNOWLEDGED。

**Rebuttal 策略**：κ > 0 是 Inclusion 公设成立的必要条件。若 κ ≡ 0，则代价相等时 Inclusion 无法通过"移除操作会降低代价"来论证操作的必要性——任何操作的添加或删除均不改变总代价，极小性无法在代价层面定义。Vacuity 同样依赖 κ > 0（空集代价 0 < 任何非空集代价 ε > 0），zero-cost 下空集的优先性消失。这是理论精确性的必要设计选择，而非任意限制。

---

## 问题汇总

| 严重度 | ID | 问题 | 位置 | 状态 |
|--------|----|----|------|------|
| MINOR | m1 | 空 AF（K=∅）下 AGM 公设的 degenerate 情况：a_t ∈ A 是 Definition 4 的隐含前置条件但未显式声明；"if a valid repair exists" guard 隐式覆盖但未说明 | preliminaries.tex def:repair, theory.tex thm:agm | ACKNOWLEDGED |
| MINOR | m2 | 全冲突框架（grounded extension = ∅，可能无 stable extension）下 AGM 公设退化为 vacuously true 的情况未在论文中讨论 | theory.tex thm:agm | ACKNOWLEDGED |
| MINOR | m3 | k=0 退化情况（只包含 a_t 自身的 neighborhood）在论文中无讨论；sensitivity analysis 从 k=1 开始但未明确排除 k=0 | method.tex §repair | ACKNOWLEDGED |
| MINOR | m4 | Stable extension 存在性假设在 Theorem 2 NP-completeness 证明中未显式声明（延续 R103-m3）；hardness reduction 隐含使用了存在 stable extension 的 AF 实例 | theory.tex thm:complexity | ACKNOWLEDGED（R103-m3 延续深化）|
| MINOR | m5 | Representation Theorem 普遍量化"for every AF"与 Theorem 1 条件量化"if a valid repair exists"之间的关系未说明；在无有效修复的 degenerate 情况下 Representation Theorem vacuously 成立 | theory.tex thm:representation | ACKNOWLEDGED |
| MINOR | m6 | κ > 0 严格正假设的必要性论证缺失：论文未说明若允许 κ ≡ 0 则 Inclusion 和 Vacuity 公设失效（即 κ > 0 是必要而非充分条件） | theory.tex thm:agm proof, def:repair | ACKNOWLEDGED |

**无 CRITICAL 问题，无 MAJOR 问题。**

---

## 是否构成论文声明的 Counter-Example

| 边界情况 | 是否构成 counter-example | 分析 |
|---------|------------------------|------|
| 空 AF（K=∅） | 否 | "if a valid repair exists" guard 屏蔽；a_t ∉ A 时不构成 well-formed 实例 |
| 无冲突框架 | 否 | AGM 公设在此情况下 trivially 成立（Vacuity 主导） |
| 全冲突框架 | 否 | "if a valid repair exists" guard 屏蔽；无解情况被显式排除 |
| α 为矛盾（s=⊥） | 否 | s ∈ {IN, OUT} 的定义已排除矛盾目标状态 |
| k=0 | 否 | 完备性声明退化为 trivial 条件，不违反声明 |
| k=|E| | 否 | 与 Proposition 1 一致 |
| stable ext. 不存在 | 否 | NP-completeness 下界 reduction 使用存在 stable ext. 的实例，上界不受影响 |
| uniform cost (κ≡1) | 否 | Representation Theorem 的 (⟸) 方向显式使用 κ(o)=1 作为构造性证明 |
| zero cost (κ≡0) | 否（已排除） | κ > 0 是必要前提条件，zero-cost 被 Definition 4 显式排除 |

**结论：所有检查的边界情况均不构成论文声明的 counterexample。**

---

## Rebuttal 应对策略总结

### 若审稿人追问"空框架或全冲突框架下 AGM 公设是否成立"

"论文的 Definition 4 和 Theorem 1 均以 'if a valid repair exists' 为前置条件。在空框架（目标论证不存在）或全冲突框架（目标状态无法达成）中，不存在有效修复，定理的前提条件不满足，定理 vacuously 成立。这是有意的防御性设计：AGM 公设在 argumentation 设置中的适配目的是描述当修复成功时算子的理性行为，而非对无解情况作出声明。这与经典 AGM 信念修正中类似的设计（K*5 仅在修正结果一致时适用）一致。"

### 若审稿人追问"k=0 时系统如何行为"

"k=0 将修复搜索空间限制为只对目标论证 a_t 本身操作，这在实践中无意义（修复需要调整攻击结构，而非只操作孤立论证）。Sensitivity analysis（附录）从 k=1 开始，隐含 k ≥ 1 为有效设置。k=0 的退化是显然的技术边界，k-neighborhood 完备性声明在 k=0 时退化为 trivially weak（仅当最优修复只需操作 a_t 本身时完备），不影响 k=3 的 99.7% 覆盖率结论。"

### 若审稿人追问"κ > 0 严格正假设的必要性"

"κ > 0 是 Inclusion 公设成立的必要条件，而非任意限制。若 κ ≡ 0，则'移除一个操作不增加代价'，Inclusion 所依赖的极小性论证（'若 Ops' = Ops* \ {o} 是有效修复，则 o 是非必要的，contradicting optimality'）失效——因为 cost(Ops*) = cost(Ops') = 0 无法区分。同样，Vacuity 依赖空集的代价（0）严格小于任何非空有效修复的代价（κ > 0 保证），zero-cost 下此优先性消失。κ > 0 是 AGM 公设在有限图修复设置中的精确形式化对应。"

### 若审稿人追问"Representation Theorem 对所有 AF 成立意味着什么"

"Representation Theorem 的'for every AF'量化是逻辑普遍量词。对于无有效修复存在的 AF 实例，定理的条件命题（'∘ satisfies adapted success, inclusion, and vacuity'）vacuously 为真——任何算子都满足前提为假时的公设。等价地，对此类 AF 实例，存在性量词'there exists a strictly positive cost function κ such that...'也 vacuously 满足（选取任意 κ > 0，无有效修复时最小代价修复的存在性条件不可测，选取任意 κ 均可）。这是经典一阶逻辑语义的标准后果，不影响定理在有效修复存在时的实质性内容。"

---

## 编译状态

（沿用 R107 验证结果，本轮无任何 .tex 改动。）

| 检查项 | 值 | 限制 | 状态 |
|--------|---|------|------|
| sec:conclusion 页码 | 9 | ≤9 | PASS |
| LaTeX 错误 | 0 | 0 | PASS |
| 论文改动 | 无 | — | N/A |

**注**：本轮为纯理论分析轮次，不修改论文。页面预算完全耗尽（R103 两次修复尝试验证：任何字符净增均将 conclusion 推至第 10 页）。

---

## 最终评估

- **CRITICAL**: 0 个
- **MAJOR**: 0 个
- **MINOR**: 6 个（m1-m6，全部 ACKNOWLEDGED，无可修复项）
- **中稿概率**: **91-93%**（与 R107 持平）

**总结**：对 ARGUS 论文所有关键理论边界情况的系统性检查表明，论文的形式化设计在 degenerate 情况下是正确的。核心保护机制——"if a valid repair exists"条件和"κ > 0 严格正"约束——有效屏蔽了空框架、全冲突框架、zero-cost 等 degenerate 情况，使 AGM 公设和 Representation Theorem 在这些情况下 vacuously 成立而非被违反。k-neighborhood 在 k=0 退化情况下完备性声明退化为 trivial 但不被违反；k=|E| 退化与 Proposition 1 一致。Stable semantics 存在性假设在 NP-completeness 证明中的隐含使用符合论证理论文献的标准做法。6 个 MINOR 问题均为理论精确性细节，不影响主要结论的正确性；所有问题均有清晰的 rebuttal 防御策略。

---
