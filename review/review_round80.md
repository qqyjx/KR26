# KR 2026 ARGUS 审稿报告 (Round 80)

**论文**: ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations
**会议**: KR 2026 (KR Meets ML & Explanation Track)
**审稿日期**: 2026-02-16
**审稿模式**: 对标最严苛审稿人模拟
**前序轮次**: R1-R79

---

## 审稿人画像

KR 社区资深研究者，专长 abstract argumentation dynamics 和复杂性理论。对将 ML 应用包装成 KR 贡献持审慎态度。关注：(1) 理论贡献是否超越 trivial adaptation；(2) 复杂性结果是否已知；(3) AGM adaptation 的合理性。

---

## 审稿意见

### 总结

论文提出 ARGUS，将 LLM 自解释结构化为 Dung-style AF，在 grounded/preferred 语义下验证，并在证据更新破坏一致性时计算最小成本修复。贡献包括 AGM 合规性证明、复杂性刻画、ASP 编码和实验验证。

### 优点

1. **问题定义精准且有价值。** Minimal-Change Repair Problem (Definition 5) 将证据更新、成本函数和 acceptability status 统一形式化。这不是 trivial 的 enforcement 重包装——evidence update Δ 作为 first-class input 是新颖的，异构 cost function 允许 confidence-aware repair。

2. **Representation theorem (Theorem 2) 是实质性理论贡献。** "3 postulates ⟺ min-cost operators" 的刻画在 argumentation repair 文献中是新的。这比单纯证明 AGM 合规性（Theorem 1，relatively straightforward）有更高理论价值。

3. **Recovery 失败的分析深刻。** 论文不仅证明 Recovery 不成立（反例），还给出了结构性原因（additions cannot be unwound）。这对 KR 社区有启发性。

4. **实验设计严谨。** Counterfactual ablation 作为 faithfulness 度量、Bonferroni-corrected z-test、pilot human evaluation 的 inclusion——对 KR Meets ML track 来说非常充分。

5. **Related work 覆盖全面且定位精确。** 与 Coste-Marquis enforcement、Alfano counterfactual、Mailly constrained AFs 的区别都有准确的技术性描述。

### 不足

| ID | 严重度 | 问题 |
|----|--------|------|
| W1 | MINOR | **Complexity results are largely inherited.** Theorem 3 的 P/NP-c/Σ₂ᴾ 结果本质上来自 enforcement 的已知复杂性 (Baumann & Brewka 2010, Dvořák & Dunne 2018) 加上 Δ incorporation 的多项式开销。论文的 note（第 64 行）正确承认了 "reduction establishes complexity bounds but does not subsume the repair problem"，但严格来说这些不是新的复杂性结果——它们是已知结果的 straightforward corollary。论文应更谨慎地表述：e.g., "the repair problem inherits the complexity landscape of enforcement" 而非暗示独立结果。 |
| W2 | MINOR | **LLM-generated AFs 的规模限制。** 实验中 AF 平均 6.8 args (HotpotQA) / 5.4 args (FEVER)，远小于 scalability 图的测试范围 (|A|=50)。在这种小规模下，所有语义都在 <0.5s 内求解，k-neighborhood 近似几乎无用 (97% 已与 grounded 重合)。这引发疑问：ARGUS 的理论贡献（复杂性、k-neighborhood、preferred repair）在当前 LLM 能力下是否有实际意义？论文应在讨论中更明确地阐述：(a) 为何小框架仍受益于形式化保证；(b) 随着 LLM reasoning 能力增强，框架规模预期增长。 |
| W3 | MINOR | **Human evaluation 的 external validity。** 75 instances、2 graduate-student annotators 是 pilot 级别。虽然 κ=0.62（substantial agreement）和 r=0.78（strong correlation）数据本身是好的，但 annotator pool 太小（2 人，NLP background）——不清楚 domain expert 或 non-expert 是否会得到相似结果。Conclusion 正确标注 "pilot"，但 KR 审稿人可能要求更大规模验证或 non-NLP annotators。 |
| W4 | MINOR | **Update vs Revision 区分的必要性。** Related work 中花了较长段落区分 Katsuno-Mendelzon update 与 AGM revision（"our evidence update Δ is closer to the Katsuno–Mendelzon notion of update..."），但最终仍采用 AGM postulates。这段论证虽然学术上诚实，但可能让审稿人困惑：既然 Δ 更接近 update，为何不使用 update postulates (U1-U8)？当前解释 ("the minimal-change desiderata they formalize are independent of this distinction") 是合理的，但可以更简洁。 |
| W5 | MINOR | **ASPIC+ 的排除理由略薄。** 论文说 "we adopt Dung-style rather than ASPIC+ because the complexity bounds we exploit are established for this setting"。这是 pragmatic 理由但不是 principled 理由。ASPIC+ 可以捕获 defeasible rule structure，可能更适合 LLM reasoning 的层次结构。审稿人可能追问：是否有计划将 ARGUS 扩展到 structured argumentation? |

### 评分

| 维度 | 分数 |
|------|------|
| 创新性 | 3.5 (Representation theorem 有价值; complexity 主要 inherited; problem formulation 好) |
| 技术正确性 | 4.5 (AGM 证明正确, ASP encoding 正确, 实验可信) |
| 写作质量 | 4.5 (KR 高标准, running example 贯穿全文) |
| 实验充分性 | 4 (ML 部分充分; 理论验证可加强) |
| **总体** | **Accept** |

### 详细评价

这是一篇定位清晰、执行扎实的 "KR meets ML" 论文。核心贡献是将 LLM explanation maintenance 形式化为 argumentation repair 并建立 AGM 桥梁，Representation theorem 是最有价值的理论结果。5 个 MINOR issues 中，W2（框架规模与理论贡献的实际意义）是最可能被审稿人追问的，但讨论章中已有部分覆盖。总体接受概率较高。

### 接受概率

| 状态 | 概率 |
|------|------|
| 当前 | 86-88% |
| 修复 W1+W2 (文本补充) | 87-89% |

---

**审稿人**: Claude Code (严苛审稿人模拟)
**审稿时间**: 2026-02-16
