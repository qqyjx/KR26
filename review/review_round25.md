# R25: 证明严谨性审查

**日期**: 2026-02-14
**轮次**: Round 25
**视角**: KR 复杂度理论专家 (Dvorak/Dunne 领域)
**文件**: theory.tex, preliminaries.tex, method.tex

---

## 1. Theorem 2 Grounded P-Membership 证明 (CRITICAL)

### 原始问题

原证明包含两段论证：
1. "固定 C" 论证：$O(|\mathcal{A}|^{2C})$ 个候选子集，"polynomial for any fixed C"
2. "C 是输入" 论证：归约到 Dvorak & Dunne 的 grounded enforcement

**问题**：第一段论证是误导性的红鲱鱼。当 $C$ 是决策问题输入的一部分时，$|\mathcal{A}|^{2C}$ 是输入规模的指数级——这不是多项式。一个精明的 KR 复杂度审稿人会立即标记此处。

### 修复

重构证明 sketch，**直接以 enforcement reduction 为主论证**：
- 删除 "fixed C" 枚举论证
- 引用 Dvorak & Dunne 的 grounded enforcement P 时间算法
- 明确归约链：incorporate Δ → enforce target status → polynomial verification

**修改前** (~8 行):
```
For grounded semantics, ... polynomial for any fixed C ...
When C is part of the input, the result follows from ...
```

**修改后** (~4 行):
```
For grounded semantics, ... Membership in P follows by reduction to
grounded enforcement, which Dvorak and Dunne showed is solvable in
polynomial time ... Our repair problem reduces to enforcement ...
```

**效果**: 更简洁、逻辑更清晰、无漏洞。减少约 4 行 LaTeX，有利于页数控制。

### 状态: **FIXED**

---

## 2. Definition 2 "Skeptically Accepted" 限制 (MINOR)

### 分析

Definition 2 (Defense Set) 要求 $t$ 是 "skeptically accepted"。然而 Theorem 2 和实验使用 credulous acceptance。

**是否存在逻辑矛盾？**
- Grounded semantics: credulous = skeptical（唯一扩展），**无问题**
- Preferred semantics: credulously accepted 的 $t$ 不一定在所有 preferred extensions 中

**结论**: Defense set 仅在验证阶段作为证书使用（当 $t$ 确实被接受时），修复问题不依赖 defense set 的定义。当前定义对 grounded 语义完全正确，对 preferred 语义在实际使用中也无问题。

### 状态: PASS (无需修改)

---

## 3. Running Example 一致性追踪

### 手动验证 Grounded Extension 计算

**F0** (Example 2, Figure 1a):
- Args: {a₀, a₁, a₂, a₃, a₄}, Attacks: {(a₀,a₄), (a₃,a₀)}
- 迭代: F(∅) = {a₁,a₂,a₃} → F({a₁,a₂,a₃}) = {a₁,a₂,a₃,a₄} (fixed point)
- Grounded extension: {a₁,a₂,a₃,a₄}, a₄ accepted ✅

**F1** (Example 2, Figure 1b):
- Args: +{a₅}, Attacks: +{(a₅,a₃)}
- 迭代: F(∅) = {a₁,a₂,a₅} → F = {a₁,a₂,a₅,a₀} → F = {a₁,a₂,a₅,a₀} (fixed point)
- a₄ NOT in extension, rejected ✅

**F2** (Example 5, Figure 1c):
- Args: +{a₆}, Attacks: +{(a₆,a₅)}
- 迭代: F(∅) = {a₁,a₂,a₆} → F = {a₁,a₂,a₆,a₃} → F = {a₁,a₂,a₆,a₃,a₄} (fixed point)
- a₄ accepted, restored ✅

### 修复代价验证

| Example | 描述 | 计算 | 论文值 | 状态 |
|---------|------|------|--------|------|
| Ex 5 (repair) | 均匀代价 | add_arg + add_att = 2 | cost 2 | ✅ |
| Ex 7 (confidence) | γ₅=0.90, 删除 a₅ | κ(del)=0.90 | 0.90 | ✅ |
| Ex 7 (augmentation) | 2κ(add) < 0.90? | κ(add) < 0.45 | "cheaper whenever κ(add) < 0.45" | ✅ |
| Ex 7 (structure) | w=2, del=2, aug=2 | 2×1=2, 2×1=2 | "both cost 2" | ✅ |

### All 7 Examples 一致性

| Example | Label | 位置 | AF 组件一致 | 计算正确 |
|---------|-------|------|-----------|----------|
| 1 (running) | ex:running | introduction.tex | ✅ | ✅ |
| 2 (af) | ex:af | preliminaries.tex | ✅ | ✅ |
| 3 (defense) | ex:defense | preliminaries.tex | ✅ | ✅ |
| 4 (verify) | ex:verify | preliminaries.tex | ✅ | ✅ |
| 5 (repair-ex) | ex:repair-ex | preliminaries.tex | ✅ | ✅ |
| 6 (cost) | ex:cost | method.tex | ✅ | ✅ |
| 7 (agm) | ex:agm | theory.tex | ✅ | ✅ |

---

## 4. Proposition 1 完备性注意事项

Proposition 1 明确限定 "when applied to the full framework without $k$-neighborhood restriction"。
方法论中 k-neighborhood 近似的 99.7% optimality 是经验性声明（experiments.tex），未被声称为形式化保证。

### 状态: PASS ✅

---

## 5. 发现问题汇总

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 25-1 | **CRITICAL** | Thm 2 grounded P-membership 证明含误导性 "fixed C" 论证 | **FIXED** — 重构为直接 enforcement reduction |
| 25-2 | MINOR | Def 2 "skeptically accepted" 限制与 credulous 使用的张力 | PASS — 实际使用无矛盾 |
| 25-3 | MINOR | Running Example 一致性 | PASS — 7 个 Example 全部验证通过 |
| 25-4 | MINOR | Prop 1 completeness caveat | PASS — 已正确限定 |

---

## 6. 编译验证

| 指标 | 值 |
|------|-----|
| 页数 | 9 |
| PDF 大小 | 345,631 bytes (减少 ~0.8KB) |
| Errors | 0 |
| Undefined refs | 0 |

---

## 7. 回归检查

| 历史问题 | 当前状态 |
|----------|----------|
| R8-1 (Stable credulous NP-c) | ✅ Thm 2 条目 2 正确 |
| R8-3 (Prop 1 scope) | ✅ "without k-neighborhood restriction" 保留 |
| R24-1 (Abstract/Intro/Conclusion stable) | ✅ 未受影响 |
| R12 (10 核心宏一致) | ✅ 宏未修改 |
