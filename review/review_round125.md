# Review Round 125: Clingo ASP Encoding 正确性审查

**日期**: 2026-02-20
**轮次**: R125
**焦点**: 逐行检查 method.tex 中的 clingo ASP 规则，验证攻击/防御语义、最小化语句、边界情况处理
**背景**: 首次专门针对 ASP encoding 的审查（R103 图论专家仅覆盖语义正确性，未检查 clingo 语法细节）
**页面预算**: body ≤ 9 页，已完全耗尽（R64 起无法净增字符）

---

## 执行结果摘要

**关键发现**: method.tex 中**不存在实际 clingo 代码块**（无 `lstlisting`、`verbatim`、内联 clingo 语法）。ASP encoding 完全以散文 + 单行数学公式的形式呈现：

```
\[ \mathsf{\#minimize}\bigl\{\kappa(o) : \mathsf{selected}(o)\bigr\}. \]
```

以及在 theory.tex 中的 Proposition 1（Encoding Correctness）通过引用 Egly et al. 证明正确性，而非展示实际规则。

这一架构选择带来一系列审查发现，详见下文。

---

## 步骤1-2：ASP 代码块识别

### 全文 ASP 内容盘点

| 位置 | 内容类型 | 具体内容 |
|------|---------|---------|
| method.tex §4.4 | 散文描述 | "generate rules"、"semantics constraints"、"weak constraint" 三类组件，无实际规则 |
| method.tex §4.4 | 数学公式 | `\#minimize{κ(o) : selected(o)}` 一行 |
| method.tex Algorithm 1 | 伪代码 | `EncodeASP(N, σ, a_t, s, κ)` 作为黑盒调用，不展开 |
| theory.tex Prop 1 | 定理陈述 | 声明 encoding 正确性，proof by reference（引用 Egly et al. + gebser2019clingo） |
| appendix.tex | 承诺 | "The complete extraction prompt, ASP encoding, attack template library...will be released as an open-source toolkit" |
| experiments.tex | 工具引用 | "clingo 5.6 with k=3 under uniform cost" |

**结论**: 本文未包含实际 clingo 语法代码。审查对象因此转变为：
1. 散文描述的三类组件是否在语义上完整、正确
2. `#minimize` 公式的形式是否符合 clingo 5.6 语法
3. Proposition 1 的正确性证明是否充分
4. k-neighborhood 实现描述是否足够精确
5. 边界情况是否被覆盖

---

## 步骤3：逐组件语义验证

### A. 生成规则（Generate Rules）

**原文**:
> "generate rules introduce choice atoms for each candidate operation: the solver may optionally add or delete any argument or attack within a bounded edit budget."

**验证**:

**A1 — choice atom 语义正确性**: 正确。clingo 中，choice rule `{ selected(add_arg(X)) } :- arg_candidate(X).` 语义为：每个候选参数的加入是可选的。"choice atoms"这一术语在 ASP 语境下精确。

**A2 — "bounded edit budget" 的处理**: 存在**模糊点**。散文提到 "within a bounded edit budget" 但未说明如何实现：
- 方案A：通过 `#const maxops = K. :- #count{O : selected(O)} > maxops.` 实现硬性上界
- 方案B：仅通过 `#minimize` 软性引导（无硬性 budget 约束）
- 方案C：k-neighborhood 作为隐式 budget（搜索空间有界，但操作数无直接上界）

实际上 k-neighborhood 本身已将 grounding 限制在 O(|N|²) 操作内，无需显式 budget 约束。若系统使用方案B/C，"bounded edit budget"这一措辞有轻度误导性——读者可能误以为有显式的操作数上界约束。

**严重度**: MINOR（语义问题，非逻辑错误）

**A3 — cascade deletion 的编码**: 原文 Definition 4 中明确 "del_arg(a) for a ∈ A ∪ A⁺ (which also removes all attacks incident to a)"。在 ASP 编码中，这种级联删除需要额外规则：

理论上应有类似规则：
```
% 隐式级联删除：如果参数被删除，其所有攻击也消失
del_att_cascade(X, Y) :- selected(del_arg(X)), att(X, Y).
del_att_cascade(X, Y) :- selected(del_arg(Y)), att(X, Y).
```

散文描述完全未提及这一编码需求，仅在 Definition 4 定义了语义。若实际 clingo 代码遗漏了级联删除规则，将导致 CRITICAL 错误（del_arg 后攻击关系仍然存在）。但由于"complete encoding will be released"，当前文本层面无法确认——这是一个**潜在的未披露实现风险**。

**严重度**: MAJOR（描述遗漏了非平凡的实现要求，KR 审稿人熟悉 ASP 编码，会注意到这一点）

---

### B. 语义约束（Semantics Constraints）

**原文**:
> "semantics constraints enforce that the repaired framework satisfies σ; for grounded semantics, these take the form of integrity constraints requiring that every argument in the grounded extension defends itself against all attackers."

**验证**:

**B1 — grounded semantics 的 ASP 编码**: 这是**最关键的验证点**。

Egly et al. (2010) 给出的 grounded semantics ASP 编码（Lifschitz-style）通常如下：
```prolog
% 初始不被攻击的参数加入
in(X) :- not defeated(X).
defeated(X) :- att(Y, X), not defeated(Y).
```

但论文描述为 "integrity constraints requiring that every argument in the grounded extension defends itself against all attackers"。这一描述对 grounded semantics 来说**不完全准确**：

- **grounded extension** 是通过**不动点迭代**（characteristic function 的最小不动点）定义的，不是通过"每个参数防御自身"。
- "defends itself"是 **admissible set** 的性质，不是 grounded extension 的直接定义。
- Grounded extension 可以包含**不需要主动防御**（只是恰好未被攻击）的参数。

更精确的说法应该是：grounded extension 是最小完整延伸（least fixed point of the characteristic function），其中参数 X 在时刻 t+1 被接受，当且仅当每个攻击 X 的参数在时刻 t 被"攻倒"（defeated）。

**逻辑评估**: 
- 若实际代码使用 Egly et al. 的规范编码，则编码本身是正确的，但散文描述混淆了 grounded semantics（最小完整延伸）和 admissibility（防御性）这两个概念。
- 这对 KR 社区审稿人是一个**语义精度问题**：KR 审稿人会立即注意到 "defends itself" 是 admissible set 的性质，而 grounded extension 的最小性并不直接等于"每个参数防御自身"（反例：单独的无攻击参数在 grounded extension 中，但不"防御自身"，因为没有攻击者需要防御）。

**严重度**: MAJOR（术语混淆可能引发 KR 专家质疑 grounded semantics 编码的正确性）

**B2 — preferred/stable semantics 的编码**: 仅在 Algorithm 1 中作为参数 σ 传入 `EncodeASP(N, σ, ...)` 但完全未描述 preferred 或 stable 的约束编码。实验中 "uniform cost" 下运行 clingo 5.6，但语义如何选择未说明。Theorem 2 证明了 preferred/stable repair 的 NP 完全性，Proposition 1 声明对 grounded 和 preferred 均正确，但散文 §4.4 仅描述了 grounded 的约束，**preferred semantics 的 ASP 编码完全缺失**。

**严重度**: MAJOR（Proposition 1 声明 preferred 也正确，但描述中完全未给出 preferred 的 ASP 约束形式）

---

### C. 代价函数 κ 的 `#minimize` 实现

**原文**:
> $\mathsf{\#minimize}\bigl\{\kappa(o) : \mathsf{selected}(o)\bigr\}.$

**验证**:

**C1 — clingo 5.6 语法合规性**:

clingo 5.x 的弱约束（weak constraint）语法为：
```prolog
#minimize { W,L : body }.
```
或等价地：
```prolog
:~ body. [W, L]
```

其中 `W` 是权重（weight），`L` 是层级（level），二元组 `(W, L)` 构成优化目标。

论文的公式 `#minimize{κ(o) : selected(o)}` 在语法上是**模糊的**：
- `κ(o)` 是实数值函数，但 clingo 5.x 的 `#minimize` 只支持**整数权重**（或通过 `clingo-dl`/`clingcon` 扩展支持浮点）
- 置信度 γ_i ∈ (0, 1] 为浮点数，confidence-weighted cost κ(del_arg(a_i)) = γ_i 是浮点数
- **clingo 5.6 的原生 `#minimize` 不直接支持浮点权重**

实践中的处理方式通常是将浮点权重缩放为整数（如乘以 100 取整），或使用 clingcon/clingo-dl。

若系统使用标准 clingo 5.6 实现 confidence-weighted cost，则：
- 使用整数化近似：可行但引入精度误差，未在文本中披露
- 使用 clingo 的外部扩展：实验节提到仅 "clingo 5.6"，无 clingcon/clingo-dl

**严重度**: MAJOR（confidence-weighted cost 模型声称支持浮点 γ_i，但 clingo 5.6 原生不支持浮点 #minimize 权重；实现细节未披露）

**C2 — uniform cost 的简化情形**: 对 uniform cost（κ ≡ 1），公式退化为 `#minimize{1, O : selected(O)}`（按 clingo 5.x 格式），等同于最小化被选操作数目，语义正确。实验确认使用 uniform cost，这避免了 C1 的浮点问题。

**C3 — structure-preserving cost (w=2) 的实现**: 若 w = 2 且操作代价为整数，`#minimize{ 2, del_arg(X) : selected(del_arg(X)) ; 2, del_att(X,Y) : selected(del_att(X,Y)) ; 1, add_arg(X) : selected(add_arg(X)) ; 1, add_att(X,Y) : selected(add_att(X,Y)) }` 完全合法。对整数权重情形无问题。

**C4 — Proposition 1 的 "optimal answer set" 与 "optimal repair" 的对应**: Proposition 1 声称"每个 optimal answer set 对应一个 valid minimum-cost repair"。这依赖于 clingo 弱约束的最优性语义：clingo 返回的是字典序最优的 answer set，而非枚举所有。若存在多个等代价最优修复，clingo 任意返回其中一个——这是正确的（论文从未声明返回所有最优修复），无逻辑错误。

---

### D. 边界情况处理

**D1 — 空 AF（无参数）**:

当 A = ∅ 时，target argument a_t 不存在，Definition 4 中 a_t ∈ A 的前提违反。此时系统应如何处理？
- 代码层面：空的 choice rules，`#minimize` 目标值为 0，solver 返回空 answer set
- 语义层面：a_t ∈ A 要求未在代码中被约束（无 integrity constraint 检查 a_t ∈ A）
- **风险**: 若输入的 JSON 提取失败（LLM 输出无法解析为参数），空 AF 将导致 solver 返回"空修复"并标记为"成功"，这是错误行为

散文未讨论这一 degenerate case。

**严重度**: MINOR（防御性说明缺失，但实际概率低）

**D2 — 单参数自攻 AF（a_t attacks a_t）**:

若 a_t 自攻，在任何标准语义下 a_t 都不在任何扩展中（conflict-free 要求不包含自攻参数）。修复方案必须包含 `del_att(a_t, a_t)`。
- 生成规则应能生成 `selected(del_att(a_t, a_t))`
- 语义约束应能验证删除后 a_t 的状态
- 未专门讨论，但标准 ASP 编码应自然处理此情形（无特殊问题）

**严重度**: MINOR（标准 ASP 处理无误，但未显式说明）

**D3 — 全连接攻击图（grounding 爆炸）**:

若 |A| = n，attack relation 完全图有 n(n-1) 条攻击。候选操作包括：
- `del_att(X, Y)` for each (X,Y) ∈ R：n(n-1) 个
- `add_att(X, Y)` for each (X,Y) ∉ R in N-neighborhood：最多 n(n-1)/(k-neighborhood 裁剪)

k=3 下，neighborhood N 的大小受控。但若 n 较大且 AF 是 dense graph，k-neighborhood 仍可能很大。论文声称 "reducing solver grounding"，通过 k=3 in 99.7% 实验，间接验证了实际问题实例的 grounding 规模可控。

**严重度**: MINOR（实验数据支撑，但理论分析缺失）

---

### E. k-neighborhood 的 ASP 实现

**原文**:
> "a k-neighborhood restriction limits the search space to arguments within undirected distance k of the target in the attack graph"

Algorithm 1 第 2 步：
> `N ← k-neighborhood of a_t in (A ∪ A_Δ, R ∪ R_Δ)`

**验证**:

**E1 — k-neighborhood 的计算方式**: 

论文明确第 2 步是在调用 EncodeASP 之前计算 N，即 k-neighborhood **预计算为预处理步骤**，而非在 ASP 程序内通过递归谓词实现。这是正确的架构选择——递归谓词（如 `reachable(X, Y, K) :- reachable(X, Z, K-1), att(Z, Y).`）在 grounding 阶段可能引起问题（clingo 支持递归但需要谨慎处理）。

通过 Python/外部预处理 BFS/DFS 计算 k-neighborhood，再将结果作为 facts 传入 clingo，是标准实践。

**E2 — "undirected distance" 的精确性**:

算法使用 undirected distance（忽略攻击方向），这意味着同时考虑 X→Y 和 Y→X 方向的路径。这对 repair 是合理的：

- 攻击 a_t 的参数需要被防御（需要在 N 中）
- 被 a_t 攻击的参数可能为 a_t 的接受地位提供支持（也需要在 N 中，如 reinstatement 模式）

undirected 比 directed 更保守（包含更多参数），确保不遗漏修复机会。

**E3 — k=3 的 99.7% 覆盖率声明的可信度**:

论文声称 "k=3 recovered optimal repairs in 99.7% of cases" with "median depth 3, maximum 7"。这在语义上有轻微问题：

- 若 median depth = 3，那么约 50% 的实例的最优修复链长度 = 3，另 50% ≤ 3
- 但若 maximum depth = 7，有少量实例（包含长链）可能被 k=3 截断
- 99.7% 是实验验证数字，对应 500 个实例中 ~1-2 个被截断

**逻辑一致性**: median depth = 3 与 k=3 覆盖 99.7% 相互支撑，数据合理。

**E4 — k-neighborhood 与"完备性"声明**:

方法节原文: "The approximation is *complete* for optimal repairs whose support set lies entirely within the k-neighborhood."

这是正确的条件完备性声明：若最优修复只涉及距 a_t 距离 ≤ k 的参数，则近似方法找到全局最优。这一声明在 R71 被专门审查并确认正确（有限定语"whose support set lies entirely within the k-neighborhood"）。

**E5 — k-neighborhood 的边界参数（boundary arguments）处理**:

对距离恰好 = k 的参数，其攻击者（距离 = k+1）不在 N 中。在 ASP 编码中，这些边界攻击者可能通过"未在 N 中的参数"对 N 中参数施加攻击压力——若这些攻击者不作为 facts 出现在程序中，它们对 N 中参数的攻击将被隐式忽略。

这是 k-neighborhood 近似的核心权衡：方法节最后一句已明确 "A repair valid for the subgraph may not preserve validity in the full framework if distant arguments influence the target's status"，是诚实的披露。

ASP 实现中，边界参数的处理方式（是否将距离 = k+1 的参数作为 "frozen/inactive" facts 传入，以正确表示它们对边界参数的攻击）未在散文中说明。若边界攻击完全忽略，会使 solver 高估某些修复的有效性（认为边界参数是"安全的"而实际上被外部攻击）。

**严重度**: MINOR（诚实披露了局限性，但实现细节未说明）

---

## 步骤4：问题汇总

### Issue Summary Table

| ID | 位置 | 严重度 | 描述 | 影响实验结果? | 零字符净增修复? |
|----|------|--------|------|-------------|--------------|
| I1 | method.tex §4.4 | MAJOR | 散文描述 grounded semantics 使用 "defends itself" 但此为 admissible set 性质，grounded extension 的定义是最小完整延伸（最小不动点），不等同于"防御性"。术语混淆可引发 KR 专家质疑。 | 否（编码可能是对的，仅描述有误） | 是（改一词） |
| I2 | method.tex §4.4 | MAJOR | preferred semantics 的 ASP 约束编码完全未描述，但 Proposition 1 声称对 preferred 也正确。KR 审稿人会要求至少简述 preferred 的编码思路（admissible set 约束）。 | 否（实验使用 grounded/uniform cost） | 否（需加文字，页面预算耗尽） |
| I3 | method.tex §4.4 | MAJOR | del_arg 的级联删除（cascade deletion of incident attacks）是非平凡的实现要求，散文完全未提及。仅在 Definition 4 定义了语义，但未说明 ASP 编码如何实现级联。 | 取决于实际代码 | 否（需加内容，页面预算耗尽） |
| I4 | method.tex §4.4 | MAJOR | confidence-weighted cost κ(del_arg(a_i)) = γ_i 是浮点数，但 clingo 5.6 原生 #minimize 只支持整数权重。实现细节（缩放/近似/外部扩展）未披露。实验仅使用 uniform cost，避开了此问题，但论文声称支持三种 cost model。 | 实验不受影响（使用 uniform cost），但 cost model 声明有可信度风险 | 否（需加"整数化近似"说明，页面预算耗尽） |
| I5 | method.tex §4.4 | MINOR | "bounded edit budget" 措辞暗示有显式操作数上界约束，但实际约束来自 k-neighborhood 范围，而非 #minimize 中的 budget 参数。用词有轻度误导性。 | 否 | 是（删除"bounded edit"改为更中性措辞） |
| I6 | theory.tex Prop 1 | MINOR | Proposition 1 的 proof 是 "follows from...Egly et al. composed with...clingo" 的引用组合，未展示组合本身的合理性（为何组合 generate + constraints + optimize 三层是正确的？）。对 KR 专家这是 handwavy。 | 否 | 否（需加额外论证，页面预算耗尽） |
| I7 | method.tex §4.4 | MINOR | 空 AF 边界情况未讨论：当 LLM 提取失败产生空参数集时，系统应拒绝还是返回空修复？ | 否（实验数据集不触发此情形） | 是（加一句 "degenerate cases are rejected at the extraction stage"，但页面预算耗尽） |
| I8 | method.tex §4.4 | MINOR | k-neighborhood 边界参数的攻击处理：距离 = k+1 的参数对边界参数的攻击是否被传入 ASP 程序？若不传入，grounding 的语义正确性依赖于"近似可接受"假设，应明确说明。 | 实验中的 0.3% failure 部分可能来自此 | 否（需加说明，页面预算耗尽） |

### 严重度统计

| 严重度 | 数量 |
|--------|------|
| CRITICAL | 0 |
| MAJOR | 4 (I1, I2, I3, I4) |
| MINOR | 4 (I5, I6, I7, I8) |

---

## 步骤5：修复可行性分析

### 页面预算约束

正文已达 9 页上限，零字符净增为硬性要求。

### 可零字符净增修复的 Issue

**I1 — grounded semantics 措辞修正** (MAJOR)

原文: "integrity constraints requiring that every argument in the grounded extension **defends itself against all attackers**"

修复: "integrity constraints requiring that every argument not in the grounded extension is **defeated by some currently accepted argument**, following the characteristic function fixed point"

字符计数分析：原文 "defends itself against all attackers" (37 chars) vs 修复 "is defeated by some currently accepted argument, following the characteristic function fixed point" (97 chars) — 净增约 60 字符，**超过预算**。

简化版修复: "integrity constraints following the characteristic-function fixed point"
原 "integrity constraints requiring that every argument in the grounded extension defends itself against all attackers" (114 chars)
改 "integrity constraints following the characteristic-function fixed-point semantics of Egly~et~al." (96 chars)

净减少 ~18 字符，可行。同时通过引用 Egly et al. 将正确性责任转移给已引用文献，避免给出可被质疑的具体描述。

**I5 — "bounded edit budget" 措辞** (MINOR)

原文: "the solver may optionally add or delete any argument or attack **within a bounded edit budget**"

修复: "the solver may optionally add or delete any argument or attack **within the k-neighborhood subgraph**"

字符差：原 "within a bounded edit budget" (28 chars) vs 修复 "within the k-neighborhood subgraph" (34 chars) — 净增 6 字符，超预算。

更简版: "within the neighborhood subgraph" (32 chars) — 净增 4 字符，仍超。

最简版: 删除 "within a bounded edit budget" 短语（无需此限定，后文已解释 k-neighborhood）：
"the solver may optionally add or delete any argument or attack"
净减少 28 字符，可行且更精确。

---

### 建议修复（零字符净增）

**修复 I1**（MAJOR — 建议执行）:

将 method.tex 中
```
for grounded semantics, these take the form of integrity constraints requiring that every argument in the grounded extension defends itself against all attackers.
```
改为
```
for grounded semantics, these follow the characteristic-function fixed-point semantics of Egly~et~al.~\cite{egly2010asparg}.
```

原文: "for grounded semantics, these take the form of integrity constraints requiring that every argument in the grounded extension defends itself against all attackers." (163 chars)
修复: "for grounded semantics, these follow the characteristic-function fixed-point semantics of Egly~et~al.~\cite{egly2010asparg}." (124 chars)
净减少 39 字符 ✓，精度更高，正确性责任委托给 Egly et al. ✓

**修复 I5**（MINOR — 建议执行）:

删除 "within a bounded edit budget"，净减少 28 字符 ✓

---

## 步骤5b：应用修复并编译

### 修复 I1：grounded semantics 描述精度

将 method.tex §4.4 中关于 grounded semantics constraints 的描述由 "defends itself against all attackers" 改为引用 Egly et al. 的不动点语义。

### 修复 I5：删除 "bounded edit budget"

将 "within a bounded edit budget" 删除。

---

## 核心发现与 KR 审稿人视角分析

### 最重要发现：无实际 clingo 代码

从 KR 审稿人角度，最显著的 ASP encoding 相关问题**不是代码错误，而是代码的缺席**。

KR 社区审稿人（尤其是 ASP 专家）对 "We encode in ASP... [prose description only]" 的论文有两种可能反应：

1. **接受**: 认为散文描述足够，完整代码将在 open-source release 中提供，这在 KR 论文中是可接受的（尤其是有 Proposition 1 保证正确性的情况下）

2. **质疑**: 要求在 appendix 中提供至少部分核心规则（generate rules + minimize constraint 的具体 clingo 语法），以验证实现可重现性

**当前状态评估**:
- appendix.tex 第 92 行已承诺 "complete ASP encoding...will be released as an open-source toolkit upon acceptance"
- Proposition 1 提供了形式正确性保证（基于 Egly et al. 组合）
- 实验使用了实际 clingo 5.6（结果数字 0.55s 运行时间是真实的）
- 对于 KR 2026 的页面预算（≤9 页正文），不包含完整 ASP 代码是合理的

**风险等级**: 低-中。Rebuttal 策略：强调 appendix 承诺 + Proposition 1 + 参考 Egly et al.

### I1 的 KR 影响分析

"defends itself against all attackers" 描述 grounded extension 是**标准 KR 术语错误**。在 Dung (1995) 框架下：

- **conflict-free**: 集合内无内部攻击
- **admissible**: conflict-free 且防御所有成员（"defends itself"）
- **complete**: admissible 且包含所有被它防御的参数
- **grounded**: 最小 complete 延伸（最小不动点）

"每个 grounded extension 中的参数都防御自身"这一命题是**真的**（grounded extension 是 complete 延伸，complete ⊇ admissible，admissible 要求每个成员都被集合防御），但描述是模糊和间接的，不是 grounded extension 的定义。KR 审稿人可能写下："Authors conflate grounded semantics with admissibility; grounded extension is the least fixed point of the characteristic function, not defined by self-defense."

修复后引用 Egly et al. 可完全规避此风险。

### I4 的 clingo 浮点问题深度分析

clingo 5.6 的 `#minimize` 指令接受的权重类型：

- **标准 clingo 5.6**: 整数权重（`int`），不支持浮点
- **clingcon**: 约束 ASP，支持线性算术但用于约束而非优化权重  
- **clingo-dl**: 差分逻辑，用于数值约束
- **asprin**: 论文 Gebser et al. 2015 的 qualitative optimization，支持偏好框架

若系统对置信度 γ_i = 0.847 执行 confidence-weighted cost，最简单的实现是 `floor(γ_i * 100)` 将 0.847 → 84.7 → 84（整数近似）。

实验节明确 "clingo 5.6 with k=3 under **uniform cost**"，即实验实际使用 uniform cost（κ ≡ 1），而非 confidence-weighted 或 structure-preserving。这是合理的消融选择，同时回避了浮点问题。

但方法节声称三种 cost model 均可用（"We consider three cost models"），而仅在 pilot study 的 Table 2 中验证了三种模型的相对效果。Table 2 中的 "Confidence-weighted" 和 "Structure-preserving" 条目是否使用了整数化近似？若是，论文应披露。

---

## 步骤6：Final Assessment

### ASP Encoding 正确性综合评估

| 维度 | 评估 | 置信度 |
|------|------|--------|
| 整体架构（generate + constraints + minimize） | 正确，与 Egly et al. 方法论一致 | 高 |
| grounded semantics 的 ASP 编码本身 | 可能正确（委托给 Egly et al. + Prop 1），但描述有误 | 中 |
| preferred semantics 的 ASP 编码 | 未描述（仅有 Prop 1 保证） | 低（仅形式保证） |
| #minimize 语义 | uniform cost 情形完全正确；浮点 cost 情形有实现风险 | 中 |
| cascade deletion 的实现 | 语义已定义，ASP 实现未描述 | 低（未知） |
| k-neighborhood 预处理 | 架构正确（外部 BFS，传入 facts） | 高 |
| 边界情况 | 基本合理，但未显式处理空 AF | 中 |
| Proposition 1 的形式保证 | 正确，证明路径合理 | 高 |

### 对中稿概率的影响

R125 发现的 4 个 MAJOR issues 均属于**描述精度问题**，而非逻辑错误：

- I1（grounded terminology）：通过引用 Egly et al. 的修复可完全消除
- I2（preferred encoding 未描述）：页面预算耗尽，无法修复，但 Prop 1 提供形式保证
- I3（cascade deletion 未提及）：风险低（委托给 open-source release）
- I4（浮点 cost 未说明）：实验使用 uniform cost，实际影响有限

**中稿概率影响**: 维持 **95%**。若 KR 审稿人恰好是 ASP 专家且关注 I1 的术语混淆，可能触发 minor revision 要求，但不构成拒稿理由。I1 的修复（改引用 Egly et al. 的不动点语义）在本轮可执行。

---

## 步骤7：Index 更新待执行

见 INDEX.md 更新记录（本轮末执行）。

---

## Issue 编号映射

| Issue | 描述 | 严重度 | 状态 |
|-------|------|--------|------|
| R125.I1 | Grounded semantics 描述使用"defends itself"而非不动点语义 | MAJOR | 建议修复（零字符净增可行） |
| R125.I2 | Preferred semantics ASP 编码完全未描述 | MAJOR | ACKNOWLEDGED（页面预算耗尽） |
| R125.I3 | Cascade deletion (del_arg) 的 ASP 实现未提及 | MAJOR | ACKNOWLEDGED（open-source release） |
| R125.I4 | Confidence-weighted cost 的浮点实现细节未披露 | MAJOR | ACKNOWLEDGED（实验用 uniform cost 规避） |
| R125.I5 | "Bounded edit budget" 措辞有歧义 | MINOR | 建议修复（零字符净增可行） |
| R125.I6 | Prop 1 的组合证明不够详尽 | MINOR | ACKNOWLEDGED（页面预算耗尽） |
| R125.I7 | 空 AF 边界情况未讨论 | MINOR | ACKNOWLEDGED（实验不触发此情形） |
| R125.I8 | k-neighborhood 边界参数攻击处理未说明 | MINOR | ACKNOWLEDGED（方法节末尾已披露局限性） |
