# R136: 理论逻辑审查

**日期**: 2026-02-26
**审查员**: Claude (Theory Logic Reviewer)
**焦点**: 定理正确性、消融逻辑、单调性关系

---

## 理论声明验证

### Theorem 1 (AGM Compliance) — theory.tex:10-17
**声称**: 每个 optimal repair 满足 adapted AGM postulates (Success, Inclusion, Vacuity)
- **Success**: 直接由 Definition 4 的 validity constraint 保证 ✅
- **Inclusion**: 由 optimality + κ > 0 保证（不必要的删除可以被移除降低成本）✅
- **Vacuity**: trivial（空集合是 valid repair 当目标已满足）✅
- **Proof sketch**: 逻辑严密 ✅

### Theorem 2 (Representation) — theory.tex:34-36
**声称**: Success + Inclusion + Vacuity 双向刻画 minimum-cost repair operators
- **(⇒)**: 由 Theorem 1 得到 ✅
- **(⇐)**: 构造性证明用 κ(o)=1，通过反证法。核心论证：如果存在更便宜的 repair，则原 operator 的某个操作是不必要的，违反 inclusion ✅
- **Appendix 完整证明**: 在 appendix.tex:166-182，general κ 的扩展 ✅

### Theorem 3 (Repair Complexity) — theory.tex:47-54
**声称**:
1. Grounded: P ✅ — 基于 Dung characteristic function 的 poly-time 可计算性
2. Preferred/Stable (credulous): NP-complete ✅ — 来自 Baumann & Brewka (2010) 的 enforcement hardness
3. Skeptical Stable: Σ₂ᴾ-complete ✅ — 来自 Wallner et al. (2017) + Dvořák & Woltran (2018)

### Proposition 1 (ASP Encoding Correctness) — theory.tex:68-72
**声称**: ASP encoding 对 grounded 和 preferred 语义是 sound and complete
- 依赖 Egly et al. (2010) 的 argumentation encoding + clingo weak constraints 的标准语义 ✅

---

## MAJOR Issues

### M1. Representation Theorem 证明中 inclusion 的精确含义需澄清 [MAJOR]
**位置**: [theory.tex:39-41](paper/sections/theory.tex#L39-L41)
**问题**: 反方向证明中，"inclusion ensures no operation in Ops is superfluous" 的论证假设 inclusion 意味着"最小必要性"。但 Theorem 1 中定义的 inclusion 是 "$\mathcal{A} \cap \mathcal{A}' \supseteq \mathcal{A} \setminus \{a \mid \mathsf{del\_arg}(a) \in \mathit{Ops}^*\}$"，这只说的是"未被显式删除的元素被保留"，并不直接意味着"每个删除都是必要的"。

从 optimality + κ > 0 确实可以推出每个操作必要，但这是 Theorem 1 的（⇒）方向已经证明的。在（⇐）方向中，inclusion 本身不保证最小性——需要与 success + κ > 0 联合使用。

**严重性**: proof sketch 的论证方向是正确的（反证法 + 三个条件联合使用），但行文让读者误以为 inclusion 单独蕴含最小性。建议在 appendix 的完整证明中更清楚地说明三个条件如何联合作用。

### M2. Skeptical stable semantics 的复杂度结果范围 [MAJOR]
**位置**: [theory.tex:53](paper/sections/theory.tex#L53)
**问题**: Theorem 3 的主文声明了 credulous acceptance 下 preferred/stable 的 NP-complete，然后"Under skeptical acceptance with stable semantics" 给出 Σ₂ᴾ。但 skeptical preferred semantics 的复杂度（Π₂ᴾ-complete）没有提及。如果不打算覆盖所有组合，应明确说明 scope。

**修复建议**: 在 Theorem 3 后加一句 "We focus on credulous acceptance for preferred and stable semantics; skeptical preferred repair complexity is discussed in Appendix~..."

---

## MINOR Issues

### m1. 消融实验逻辑一致性 [MINOR]
从 Table 2 (Appendix) 验证消融逻辑：
- w/o Semantic Verification: Faith -5.4pp, Contest -7.7pp → 最大下降，符合"最关键组件" ✅
- w/o Minimal-Change: Faith -0.6pp, Cost +2.5 → 仍然 faithful 但成本大增，符合"不约束则浪费" ✅
- w/o Attack Templates: Faith -2.6pp, Contest -9.3pp → 模板影响 contestability 远多于 faithfulness ✅
- Grounded Only: 接近 full 但速度快 3-4× → 符合 97% 框架单一 preferred=grounded ✅

**所有消融方向符合理论预期** ✅

### m2. 单调性关系 [MINOR]
- Framework size ↑ → Solve time ↑ ✅ (scalability 图所有曲线单调递增)
- k ↑ → Repair optimality ↑ ✅ (87.2% → 99.7% → plateau)
- NLI threshold ↑ → Repair cost ↑ ✅ (2.4 → 4.1, 因为更严格的攻击检测意味着更多未检测到的攻击)

### m3. Definition 编号连续性 [MINOR]
- Definition 1 (AF), 2 (Defense Set), 3 (Verification Task), 4 (Repair Problem)
- Theorem 1 (AGM), 2 (Representation), 3 (Complexity)
- Proposition 1 (ASP Encoding)
- Example 1-7 (running + applications)
**状态**: PASS — 编号连续无跳号 ✅

---

## 统计

| 类型 | 数量 |
|------|------|
| CRITICAL | 0 |
| MAJOR | 2 |
| MINOR | 3 |
| PASS | 7 |

**总结**: 理论部分逻辑严密，所有定理的证明方向正确。两个 MAJOR 问题是关于表述精确度而非正确性。消融实验与理论预期完全一致。
