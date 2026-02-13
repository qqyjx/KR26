# Round 8 审稿报告：KR 理论专家视角

**日期**: 2026-02-12
**轮次**: Round 8 / 12
**视角**: KR 理论专家（Argumentation + AGM + Complexity）
**文件**: theory.tex, preliminaries.tex, method.tex

---

## 发现汇总

| ID | 严重级 | 位置 | 问题 | 状态 |
|----|--------|------|------|------|
| 8-1 | **CRITICAL** | theory.tex Thm 2 | Stable complexity 错误：credulous 下应为 NP-c，非 Σ₂ᴾ | **FIXED** |
| 8-2 | **MAJOR** | theory.tex Thm 1 | Inclusion 公设同义反复，缺乏实质内容 | **FIXED** (添加讨论) |
| 8-3 | **MAJOR** | theory.tex Prop 1 | "Sound and complete" 未限定为无 k-neighborhood 的完整搜索空间 | **FIXED** |
| 8-4 | **MAJOR** | theory.tex AGM | "Consistency by construction" 对 stable 不成立 | **FIXED** |
| 8-5 | Minor | theory.tex Thm 1 | Vacuity 的 "cost = 0" 子句冗余 | SKIPPED (不影响正确性) |

---

## 详细分析

### 8-1: Stable Complexity (CRITICAL)

**问题**: 论文声明 "Our results assume credulous acceptance"（theory.tex:40），但 Theorem 2 item 3 声称 stable repair 是 Σ₂ᴾ-complete。

**分析**: 在 credulous acceptance 下:
- Repair decision = ∃Ops (cost ≤ C) ∃E (E is stable ∧ a_t ∈ E)
- Certificate = (Ops, E)，验证在 P 内（cost check + conflict-free + attacks all outsiders + membership）
- 因此问题在 NP 中。NP-hard 由 credulous acceptance under stable 归约得到。→ NP-complete。

Σ₂ᴾ 仅在 **skeptical acceptance** 下成立:
- ∃Ops ∀E (E stable → a_t ∈ E)
- ∀ 量词使验证变为 co-NP → 整体 Σ₂ᴾ

**修复**: Theorem 2 改为 (1) Grounded: P, (2) Preferred & Stable (credulous): NP-c; 补充 skeptical stable → Σ₂ᴾ。Proof sketch 同步更新。

### 8-2: Inclusion Postulate (MAJOR)

**问题**: Inclusion 声明 A ∩ A' ⊇ A \ {deleted by Ops*}。展开后：被 Ops* 删除的 argument 不在 A' 中（显然），未被删除的仍在 A' 中（直接由 apply 定义保证）。因此该公设是同义反复。

**分析**: 真正的 AGM inclusion 有实质内容（K*p ⊆ K+p），但在 AF 上的 adaptation 退化为恒真命题。真正的 minimal-change 保证来自代价优化（κ > 0 使优化器避免不必要删除）。

**修复**: 在讨论段落添加一句，诚实承认 inclusion 由 apply 构造性保证，实质保证来自代价优化。

### 8-3: Proposition 1 Scope (MAJOR)

**问题**: "Sound and complete" 未说明适用范围。Algorithm 1 使用 k-neighborhood 限制，此时 completeness 不保证（最优修复可能涉及 k 外的 argument）。

**修复**: 添加 "when applied to the full framework without k-neighborhood restriction" 限定。

### 8-4: Consistency for Stable (MAJOR)

**问题**: "Consistency holds by construction" 仅对 preferred 成立（每个 AF 至少有一个 preferred extension）。Stable semantics 下 AF 可能无 stable extension。

**修复**: 区分 preferred 和 stable，说明 stable 下 solver 可能报告 infeasibility。

---

## 定义链完整性检查

| 编号 | 名称 | 引用的前置定义 | 配对 Example | 状态 |
|------|------|---------------|-------------|------|
| Def 1 (AF) | Abstract Argumentation Framework | 无 | Ex (ex:af) | ✅ |
| Def 2 (Defense Set) | Defense Set | AF (Def 1) | Ex (ex:defense) | ✅ |
| Def 3 (Task) | Explanation Verification Task | AF (Def 1) | Ex (ex:verify) | ✅ |
| Def 4 (Repair) | Minimal-Change Repair Problem | AF (Def 1), semantics, cost | Ex (ex:repair-ex) | ✅ |

编号连续，逻辑递进，配对完整。

---

## 编译验证

- Pages: **9** ✅
- Undefined references: **0** ✅
- Overfull hboxes: **0** ✅
- Conclusion starts: **page 8** ✅
- 10 核心数值: **全部一致** ✅

---

## 回归检查（R1-R7 关键项）

| 历史问题 | 复检 |
|---------|------|
| B1: credulous/skeptical 一致性 | ✅ 仍正确（theory.tex:40 明确声明 credulous，stable 项已修正） |
| B2: 符号统一 (κ, add_arg, del_arg, {IN,OUT}) | ✅ 无变化 |
| B3: AGM 8 公设完整讨论 | ✅ 仍在，consistency 部分已改进 |
| A1: SelfCheckGPT 矛盾 | ✅ 无变化 |
| E-2a: GPT-4o 版本 | ✅ 无变化 |
| E-3: NLI 模型 | ✅ 无变化 |

**无回归问题。**
