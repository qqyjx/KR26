# Round 13 审稿报告：理论深度强化

**日期**: 2026-02-15
**轮次**: Round 13
**视角**: KR 资深 PC member，擅长论证理论与信念修正（Hansson/Baumann 学派）
**目标**: Significance 3.5 → 4.0

---

## 发现汇总

| ID | 严重级 | 位置 | 问题 | 状态 |
|----|--------|------|------|------|
| 13-1 | **MAJOR** | theory.tex:29 | AGM 讨论只提及 3/8 公设成立，5 个被一句话打发；缺乏 recovery 失败的具体反例 | **FIXED** |
| 13-2 | **MAJOR** | theory.tex:54-56 | Remark 关于 enforcement 区分过于笼统，缺乏结构化论证 | **FIXED** |
| 13-3 | **MAJOR** | theory.tex:20 | Inclusion proof sketch 不精确——"optimizer never removes unless forced" 不是有效论证 | **FIXED** |

---

## 修改详情

### 13-1: AGM 公设讨论深化 → FIXED

**问题**: 原文将 closure/recovery/superexpansion/subexpansion 简单归类为"presuppose deductively closed belief sets"，这是 KR 审稿人会攻击的弱点。Recovery 是 AGM 中最有争议的公设，应当用 running example 构造具体反例。

**修改**:
- 明确 consistency 和 extensionality 成立的具体原因
- 添加 recovery 失败反例：修复 F₁→F₂ 添加 a₆ 和 (a₆,a₅)；若随后撤回 a₅，F₂ 仍保留 a₆——无法恢复 F₀
- 指出这是 structural vs propositional belief revision 的根本不对称性
- 压缩冗余文字，净增约 2 行

### 13-2: Enforcement 区分结构化 → FIXED

**问题**: Remark 将 3 个区分点揉在一个长句中，读者容易跳过。

**修改**:
- 改为 (i)(ii)(iii) 编号列出 3 个结构性差异
- (i) evidence update Δ 耦合搜索空间到外部输入
- (ii) 异构代价函数 vs enforcement 的无权重编辑
- (iii) add_arg 受 NLI pipeline 约束——候选空间由语义合理性限制，非纯组合搜索（这是新增的关键区分点）

### 13-3: Inclusion 证明精确化 → FIXED

**问题**: "optimizer never removes unless forced" 不是严格论证。

**修改**: 改为反证法——若某 del_arg(a) 可移除且修复仍有效，则移除后代价严格降低（κ>0），与最优性矛盾。

---

## 回归检查

| 历史问题 | 复检 |
|---------|------|
| 8-1: Stable credulous NP-c | ✅ theory.tex Thm 2 未受影响 |
| 8-2: Inclusion 同义反复 | ✅ 新 proof sketch 以反证法论证 necessity |
| 8-3: Prop 1 scope | ✅ 未受影响 |
| 10-2: Supplementary 引用 | ✅ 无回归 |
| 11-2: Inclusion 诚实讨论 | ✅ 新增 recovery failure 强化了 AGM 分析的诚实度 |

---

## 编译验证

- Pages: **9 正文 + 2 参考文献** ✅
- Overfull hboxes: **0** ✅
- Undefined references: **0** ✅ (仅字体警告)

---

## 审稿人评估

**改进前**: Significance 3.5/5 — "AGM adaptation 只有 3 个公设，complexity 继承自 enforcement"
**改进后**: Significance 3.7-4.0/5 — "Recovery failure 反例展示了 structural vs propositional 的根本差异；3 个明确的 enforcement 区分点展示了 repair problem 的独立价值；NLI 约束是纯 enforcement 不具备的语义维度"
