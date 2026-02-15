# Round 61 审稿报告：形式化精确性审查

**日期**: 2026-02-15
**轮次**: Round 61
**视角**: 发表过 KR/COMMA 的形式化专家（Dvorak/Gaggl 学派）
**目标**: Soundness 4.0 → 4.5

---

## 发现汇总

| ID | 严重级 | 位置 | 问题 | 状态 |
|----|--------|------|------|------|
| 16-1 | **MAJOR** | 全文 | set vs. sequence 不一致：Definition 4 定义 repair 为 set（无序），但 4 处 example 用 ⟨...⟩ (sequence notation)，4 处 prose 说 "sequence of edit operations" | **FIXED** |
| 16-2 | **MAJOR** | preliminaries.tex Def 2 | σ 参数出现在 defense set 定义签名中但未在定义体中使用；Def_σ(t) 的 σ 下标无意义 | **FIXED** |
| 16-3 | **Minor** | preliminaries.tex Def 4 | "sequence" → "set"，候选池形式化，del_arg 级联行为 | **FIXED** (R61 初始编辑) |
| 16-4 | **Minor** | 全文 Examples 1-7 | Running example 一致性交叉检查 | **VERIFIED** ✅ |

---

## 修改详情

### 16-1: set vs. sequence 不一致 → FIXED

**问题**: Definition 4 使用 $\mathit{Ops} = \{o_1, \ldots, o_m\}$（set notation），但：
- preliminaries.tex Ex 5: $\langle \mathsf{add\_arg}(a_6), \mathsf{add\_att}(a_6, a_5) \rangle$
- theory.tex Ex 6: $\langle \mathsf{add\_arg}(a_6), \mathsf{add\_att}(a_6, a_5) \rangle$
- method.tex Ex 7: $\langle \mathsf{add\_arg}(a_6), \mathsf{add\_att}(a_6, a_5) \rangle$
- abstract.tex, introduction.tex, method.tex ×2, theory.tex: "sequence of edit operations"

**修正**:
- 所有 example 中 `\langle ... \rangle` → `\{ ... \}`
- 所有 prose 中 "sequence of edit operations" → "set of edit operations"
- theory.tex proof sketch: "empty sequence" → "empty set"
- 保留 method.tex:119 "beam search over repair sequences"（beam search 确实枚举序列）

**理由**: Repair 操作集合无序——add_arg(a6) 和 add_att(a6, a5) 的应用顺序不影响结果。使用 set notation 与 Definition 4 一致，也与 enforcement 文献中 Baumann & Brewka 的标准用法一致。

### 16-2: Definition 2 σ 参数 → FIXED

**问题**: 原定义：
> "a defense set for $t$ is a minimal admissible set $D \subseteq \mathcal{A}$ such that $t \in D$"

σ 在定义体中完全未使用，但 $\mathit{Def}_\sigma(t)$ 带有 σ 下标。KR 审稿人会立即指出这是 vacuous parameter。

**修正**: 添加 σ-extension 约束：
> "a defense set for $t$ under $\sigma$ is a minimal admissible set $D \subseteq \mathcal{A}$ such that $t \in D$ **and $D \subseteq E$ for some $E \in \sigma(F)$**"

**验证**:
- Example 3 仍然成立：{a3, a4} ⊆ {a1, a2, a3, a4} = grounded extension of F0 ✓
- Example 3 第二段（F1 中 D 不再 admissible）仍然成立 ✓
- 后续 prose "When t is credulously but not skeptically accepted, defense sets exist only for the extensions containing t" 仍然有意义（现在是定义的直接推论，而非独立观察）

### 16-3: Definition 4 精确化 → FIXED (上一次编辑)

- "finite sequence" → "finite set"
- add_arg 候选池：$a \notin \mathcal{A}\cup\mathcal{A}^+$
- del_arg 级联："which also removes all attacks incident to $a$"

### 16-4: Running Example 一致性交叉检查 → VERIFIED ✅

逐一验证所有 7 个 Example：

| Example | 位置 | 内容 | 一致性 |
|---------|------|------|--------|
| Ex 1 (running) | intro | F0, F1, a0-a5, repair with a6 | ✅ |
| Ex 2 (af) | prelim | F0 = ({a0,...,a4}, {(a0,a4),(a3,a0)}), F1 adds a5,(a5,a3) | ✅ |
| Ex 3 (defense) | prelim | D={a3,a4} defense set for a4 in F0 | ✅ |
| Ex 4 (verify) | prelim | F0: accepted, F1: rejected, Δ = ({a5},{(a5,a3)},∅,∅) | ✅ |
| Ex 5 (repair) | prelim | Ops = {add_arg(a6), add_att(a6,a5)}, cost=2 | ✅ |
| Ex 6 (agm) | theory | Vacuity/Success/Inclusion on F0→F1→F2 | ✅ |
| Ex 7 (cost) | method | Confidence-weighted: γ5=0.90, γ3=0.75 | ✅ |

验证了：
- AF 结构 (A, R) 在所有 example 间一致
- 扩展计算正确：F0 grounded = {a1,a2,a3,a4}, F1 grounded = {a1,a2,a5,a0}
- Figure tikz nodes 的 acc/rej 状态与计算匹配
- 代价计算正确

---

## 回归检查

| 历史问题 | 复检 |
|---------|------|
| R13 AGM postulate 强化 | ✅ recovery 反例引用的 F0→F2 路径与修正后一致 |
| R13 Remark 3 差异 | ✅ "add_arg" 描述与 set notation 一致 |
| R14 统计报告 | ✅ 无回归 |
| R15 新引用 | ✅ 无回归 |
| 所有 10 核心宏 | ✅ 无变化 |
| 匿名化 | ✅ 无自引 |

---

## 编译验证

- Pages: **9 + 2 refs = 11** ✅
- Overfull: **0** ✅
- Undefined citations: **0** ✅

---

## 未做项（评估后放弃）

- **ASP 规则示例**: 考虑在 method.tex 添加具体 clingo 规则，但当前页面预算已满（9 页），且 Egly et al. 引用充分覆盖编码细节。放弃。
