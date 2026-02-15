# R13: 形式化 Definition-Example 一致性验证

**日期**: 2026-02-13
**视角**: Dr. Caminada — Dung AF 语义形式化验证专家

## 发现汇总

| ID | 严重级 | 问题 | 状态 |
|----|--------|------|------|
| 13-1 | **CRITICAL** | a4 在 F_1 中未被攻击，GE = {a1,a2,a4,a5}，a4 应为 accepted 而非 rejected | **FIXED** |
| 13-2 | **CRITICAL** | Defense set D={a1,a2,a3,a4} 非 minimal（F_0 无攻击时 {a4} 即可） | **FIXED** |
| 13-3 | **CRITICAL** | Example 4 称 a4 rejected 触发 repair，但 a4 在 F_1 中实为 accepted | **FIXED** |
| 13-4 | MAJOR | Figure 1b TikZ a4 为 rej node，与形式语义矛盾 | **FIXED** |
| 13-5 | MAJOR | confidence-weighted cost 中 κ(add·) 未定义 | **FIXED** |
| 13-6 | MAJOR | Example 5 repair 验证需确认引入 a_0 后仍正确 | **VERIFIED** ✓ |
| 13-7 | MINOR | Example 7 vacuity 未显式说明 Δ=∅ | **FIXED** (间接) |
| 13-8 | MINOR | Definition 全局编号连续 | PASS |
| 13-9 | MINOR | "Continuing Example" 格式一致 | PASS |

## 根本原因分析

论文使用 Dung-style 抽象论证框架（仅建模攻击关系），但 running example 的叙事暗含 a3 对 a4 的"支持"关系。在 Dung AF 中，当 a3 被击败时，a4 不会自动失去接受状态——除非有某个攻击者因 a3 的失败而"恢复"（reinstatement）。

原始 F_0 = ({a1,...,a4}, ∅) 中无任何攻击，因此所有参数都在 grounded extension 中。即使 a3 被 a5 击败，a4 因从未被攻击仍保持 accepted。

## 修复方案

引入 **a_0**（"症状非特异性，可能为其他疾病"）作为鉴别诊断论点：

- **F_0** = ({a_0, a1, a2, a3, a4}, {(a_0, a4), (a3, a_0)})
  - GE: a3 unattacked → defeats a_0 → a4 defended → GE = {a1, a2, a3, a4} ✓
- **F_1** += {a5}, {(a5, a3)}
  - GE: a5 defeats a3 → a_0 reinstates → a4 rejected → GE = {a_0, a1, a2, a5} ✓
- **F_2** += {a6}, {(a6, a5)}
  - GE: a6 defeats a5 → a3 restores → a_0 re-defeated → a4 restored → GE = {a1, a2, a3, a4, a6} ✓

Defense set 现在正确：D = {a3, a4}（minimal：a3 needed to defend a4 against a_0）。

## 修改文件

| 文件 | 修改 |
|------|------|
| introduction.tex | Example 1: 增加 a_0 描述，修正 reinstatement 叙事 |
| preliminaries.tex | Example 2: F_0/F_1 重定义含 a_0; Example 3: D={a3,a4}; Example 4: reinstatement 说明; Figure 1: 三子图增加 a_0 节点 |
| theory.tex | Example 7: AGM vacuity/success 更新含 a_0 |
| method.tex | 补充 κ(add_arg)=κ(add_att)=1 在 confidence-weighted model 中 |

## 回归检查

| 历史问题 | 状态 |
|----------|------|
| B1 (credulous/skeptical) | ✅ PASS |
| B2 (notation unified) | ✅ PASS |
| 8-1 (Theorem 2 complexity) | ✅ PASS |
| 9-1 (experiments Σ₂ᴾ sync) | ✅ PASS |
| 10-1 (method.tex skeptical) | ✅ PASS |
| 10-2 (supplementary removed) | ✅ PASS |
| 11-1 (faithfulness protocol) | ✅ PASS |
| 编译 | ✅ 9 pages, 0 errors, 0 undefined refs |

## 影响评估

这是 R1-R12 均未发现的 **最严重的形式化错误**。如果未修复提交，任何熟悉 Dung AF 的审稿人都会立即发现 a4 在 F_1 中不应被拒绝，导致论文可信度严重受损甚至直接拒稿。修复后的 reinstatement 模式是论证理论中的经典构造，使 running example 成为 Dung AF 的优秀教学案例。
