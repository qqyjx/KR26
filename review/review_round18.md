# R18: 形式化证明审计

**日期**: 2026-02-13
**角色**: Dr. Niskanen — 形式化验证专家（enforcement complexity, counterexample construction）

## 审计范围

逐一验证 Definition 1-4, Theorem 1-2, Proposition 1, Example 2-7 的正确性和相互一致性。

## 手动推导验证

### Grounded Extension 计算

| Framework | 攻击关系 | 手动推导 GE | 论文声明 | 状态 |
|-----------|----------|------------|----------|------|
| $F_0$ | (a0,a4), (a3,a0) | {a1,a2,a3,a4} | {a1,a2,a3,a4} (Ex.4) | **PASS** |
| $F_1$ | +(a5,a3) | {a1,a2,a5,a0} | a4 rejected (Ex.4) | **PASS** |
| $F_2$ | +(a6,a5) | {a1,a2,a3,a4,a6} | a4 restored (Ex.5) | **PASS** |

### Definition-Example 配对验证

| Example | Definition | 验证内容 | 状态 |
|---------|-----------|----------|------|
| Ex.2 (AF) | Def.1 | F0, F1 结构正确 | **PASS** |
| Ex.3 (Defense) | Def.2 | D={a3,a4} conflict-free + admissible + minimal | **PASS** |
| Ex.4 (Verify) | Def.3 | GE(F0) 含 a4, GE(F1) 不含 a4 | **PASS** |
| Ex.5 (Repair) | Def.4 | Ops cost=2, del_arg(a5) cost=1, structure-preserving cost=2 for both | **PASS** |
| Ex.6 (Cost) | Def.4 §cost | κ(del_arg(a5))=0.90, augmentation cost=2κ(add), breakeven κ(add)<0.45 | **PASS** |
| Ex.7 (AGM) | Thm.1 | Vacuity (F0 empty repair), Success (F2 restores a4), Inclusion (no deletions) | **PASS** |

### Theorem 压力测试

| 定理 | 测试 | 结果 | 状态 |
|------|------|------|------|
| Thm.1 Success | 定义蕴含：valid repair ⟹ status satisfied | 由 Def.4 valid 条件直接保证 | **PASS** |
| Thm.1 Inclusion | 多等价最优修复时是否仍成立 | 是：Inclusion 对任意修复（含非最优）均成立 | **PASS** |
| Thm.1 Vacuity | 无效修复不存在时 | 定理条件"If valid repair exists"排除此情况 | **PASS** |
| Thm.2 Grounded P | 特征函数多项式可计算 | 正确：Dung 1995 标准结果 | **PASS** |
| Thm.2 Preferred NP | NP 证书验证 | 证书=(Ops, admissible set)，验证多项式 | **FIXED** |
| Thm.2 Stable σ NP | 同上 | 证书=(Ops, stable ext)，验证多项式 | **PASS** |
| Thm.2 Skeptical Σ₂ᵖ | 量词交替 ∃Ops∀E | 正确：∃(repair) ∀(stable extensions) | **PASS** |
| Prop.1 Scope | "without k-neighborhood" 限定词 | 存在 (R8-3 fix preserved) | **PASS** |

### Algorithm 1 vs Definition 4

| 检查项 | 状态 |
|--------|------|
| INCORPORATE 先于 Ops 执行 | **PASS** (Algorithm 1 line 1) |
| k-neighborhood 限制与 Def.4 的差异已说明 | **PASS** (method.tex line 116-120) |
| Proposition 1 明确限定为 full framework | **PASS** |

## 发现问题

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 18-1 | MINOR | Definition 3 使用 $t_a$ 而非 $a_t$（全文其余均用 $a_t$） | **FIXED** |
| 18-2 | MINOR | Theorem 2 proof sketch "via preferred extension computation" 不够精确 | **FIXED** → "via admissible set verification" |

## 回归检查 (R1-R17)

| 历史轮次 | 关键问题 | 当前状态 |
|----------|----------|----------|
| R8-1 (stable complexity) | NP-complete under credulous | **PASS** |
| R8-2 (inclusion tautology) | 讨论在 theory.tex line 30 | **PASS** |
| R8-3 (Prop.1 scope) | "without k-neighborhood" | **PASS** |
| R8-4 (consistency for stable) | theory.tex line 33 | **PASS** |
| R13-1~R13-6 (running example) | GE 计算、reinstatement | **PASS** |
| R17 (\textsc{Argus} consistency) | 全文统一 | **PASS** |

## 编译结果

| 指标 | 值 |
|------|-----|
| 页数 | 10 (9 content + 1 refs) |
| Errors | 0 |
| Undefined refs | 0 |
| Font warnings | 4 (OT1/ptm/m/scit — cosmetic) |

## 修改文件

| 文件 | 修改 |
|------|------|
| preliminaries.tex | 2处 $t_a$ → $a_t$ |
| theory.tex | 1处 NP 证书描述更精确 |
