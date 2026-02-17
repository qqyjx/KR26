# R83: Logic + Consistency Review

**日期**: 2026-02-17
**模式**: Logic + Consistency
**审稿人视角**: Argumentation 形式化专家
**续接**: R82 (0C/0M/9m)

---

## B1. 形式系统完整性

### B1.1 定义编号连续性

全局计数器分配如下（连续无跳号）:

| # | 类型 | 名称 | 位置 |
|---|------|------|------|
| 1 | Example | Medical Diagnosis (running) | introduction.tex |
| 2 | Definition | Abstract Argumentation Framework | preliminaries.tex |
| 3 | Example | AF for running example | preliminaries.tex |
| 4 | Definition | Defense Set | preliminaries.tex |
| 5 | Example | Defense set for running example | preliminaries.tex |
| 6 | Definition | Explanation Verification Task | preliminaries.tex |
| 7 | Example | Verification for running example | preliminaries.tex |
| 8 | Definition | Minimal-Change Repair Problem | preliminaries.tex |
| 9 | Example | Repair for running example | preliminaries.tex |
| 10 | Example | Cost models for running example | method.tex |
| 11 | Theorem | Adapted AGM Compliance | theory.tex |
| 12 | Example | AGM illustration for running example | theory.tex |
| 13 | Theorem | Representation | theory.tex |
| 14 | Theorem | Repair Complexity | theory.tex |
| 15 | Proposition | Encoding Correctness | theory.tex |

**结论**: 4 Definitions, 3 Theorems, 1 Proposition, 7 Examples. 全局编号 1--15 连续无跳号。PASS.

### B1.2 Theorem 11 (AGM Compliance): 8 个 AGM Postulates 覆盖

论文在 Theorem 11 中正式证明了 3 个适配的 AGM postulates (success, inclusion, vacuity)。在 Theorem 11 之后的段落（theory.tex 行 29--31）中讨论了其余 5 个:

| AGM Postulate | 状态 | 论文讨论 |
|---------------|------|----------|
| Success | HOLDS | Theorem 11(1), proof sketch provided |
| Inclusion | HOLDS | Theorem 11(2), proof sketch provided |
| Vacuity | HOLDS | Theorem 11(3), proof sketch provided |
| Consistency | HOLDS | 行 29: "follows because every valid repair produces a framework with at least one sigma-extension" |
| Extensionality | HOLDS | 行 29: "holds because the operator is defined purely over graph structure" |
| Recovery | FAILS | 行 30: Counterexample provided (F1 -> F2, retraction of a5 does not recover F0) |
| Closure | N/A | 行 31: "presuppose deductively closed belief sets---constructs without natural analogues" |
| Superexpansion | N/A | 行 31: same argument |
| Subexpansion | N/A | 行 31: same argument (note: paper says "superexpansion and subexpansion" but these are the supplementary postulates from AGM, applicable) |

**结论**: 全部 8 个 postulates 已被覆盖。3 个正式证明持有, 2 个声明持有并给出简短论证, 1 个给出反例证明失败, 2 个论证为不适用。Recovery 的反例（Example 12 中 F1->F2->retract a5 场景）具体且令人信服。PASS.

### B1.3 Theorem 14 (Complexity): 复杂度结果一致性

| 语义 | 接受类型 | 声明 | 证明支撑 |
|------|----------|------|----------|
| Grounded | Credulous (= skeptical) | P | Reduction to grounded enforcement [Dvorak & Dunne 2018]; characteristic function polynomial |
| Preferred | Credulous | NP-complete | Hardness from enforcement [Baumann & Brewka 2010]; NP membership via certificate (repair + witnessing admissible set) |
| Stable | Credulous | NP-complete | Same certificate argument; stable extension verifiable in P |
| Stable | Skeptical | Sigma_2^P-complete | Verifying all stable extensions is co-NP-hard [Dvorak & Dunne 2018] |

**交叉检查 vs. abstract.tex**: Abstract 写 "in P under grounded semantics and NP-complete under preferred and stable semantics" -- 与 Theorem 14 一致（abstract 省略了 skeptical stable，可接受因为 abstract 只提主要结果）。

**交叉检查 vs. conclusion.tex**: Conclusion 写 "tractable under grounded semantics and NP-complete under preferred and stable semantics" -- 一致。

**交叉检查 vs. introduction.tex (C2)**: C2 写 "placing the problem in P under grounded semantics and NP-complete under preferred and stable semantics" -- 一致。

**交叉检查 vs. method.tex 行 90**: "Even under preferred semantics the repair problem is NP-complete (Theorem 14), rising to Sigma_2^P-completeness under skeptical stable semantics" -- 一致。

**结论**: PASS. 复杂度声明在论文各处一致，证明概要引用了正确的文献。

### B1.4 Proposition 15 (Encoding Correctness): 条件和结论精确性

**声明**: ASP encoding is sound and complete w.r.t. optimal repairs under grounded and preferred semantics, when applied to the full framework (without k-neighborhood restriction).

**限定条件**: 明确限定为 "full framework without k-neighborhood restriction" -- 这是必要的，因为 k-neighborhood 近似可能遗漏最优修复。

**注意**: Proposition 15 未涵盖 stable semantics。这与论文范围一致 -- ASP encoding 部分仅讨论 grounded 和 preferred。

**结论**: PASS. 声明精确且限定适当。

### B1.5 k-neighborhood 近似的完备性声明

method.tex 行 91: "setting k=3 recovered optimal repairs in 99.7% of cases"
method.tex 行 93: "The approximation can miss optimal repairs when the only viable defender lies at distance greater than k from the target"

**限定条件检查**:
- 明确声明了近似可能失败的条件 (distance > k) -- PASS
- 给出了经验数据 (99.7% at k=3) -- PASS
- 承认 "a repair valid for the subgraph may not preserve validity in the full framework if distant arguments influence the target's status" -- PASS
- 给出了实际框架的深度统计 (median depth 3, max 7) 来佐证 k=3 的充分性 -- PASS

**结论**: PASS. 完备性声明有适当限定。

### B1.6 Representation Theorem (Theorem 13) 证明逻辑

**正文证明概要 (theory.tex 行 38-41)**:
- (=>) 方向: 由 Theorem 11 直接得出。正确。
- (<=) 方向: 构造 kappa(o)=1, 然后论证 success => validity, vacuity => empty when not needed, inclusion => every operation necessary (removing one contradicts inclusion under positive cost). 结论: output is minimum-cost repair.

**附录完整证明 (appendix.tex 行 57-71)**:
- Construction: kappa(o_i) = 1 for all i.
- Validity: From success. Correct.
- Vacuity case: Ops = empty with cost 0, trivially minimum. Correct.
- Non-vacuity case: Proof by contradiction. Assumes Ops' with |Ops'| < |Ops| exists, shows inclusion implies every operation in Ops is necessary.

**[MINOR] B1.6a**: 在附录证明的 non-vacuity case 中，论证从 Inclusion 到 minimality 的推理链有一个微妙的跳跃。Inclusion postulate 的形式化定义（Theorem 11(2)）说的是集合论上的保留关系 ($\mathcal{A} \cap \mathcal{A}' \supseteq \mathcal{A} \setminus \{a \mid \mathsf{del\_arg}(a) \in Ops^*\}$），这直接说明了"保留了什么"，但并不直接意味着"每个 deletion 都是必要的"。证明在行 66-68 试图弥补这一跳跃（"Combined with success and kappa > 0, this means no proper subset of Ops is both valid and of lower cost"），但这个推理实际上依赖于 optimality（最优性），而非单独的 inclusion。换言之，inclusion 保证结构保留，但"每个操作都是必要的"需要 optimality + success + kappa > 0 共同保证。证明的结论是正确的，但论证路径可以更清晰地分离 inclusion 的作用和 optimality 的作用。

---

## B2. 消融实验逻辑

### B2.1 消融变体合理性分析

| 变体 | Faith | Cont | RAcc | RCost | 预期 | 实际 |
|------|-------|------|------|-------|------|------|
| Full ARGUS | .847 | .791 | .883 | 3.2 | -- | -- |
| w/o Semantic Verification | .793 | .714 | .832 | 4.1 | Faith/Cont/RAcc 下降, RCost 上升 | MATCH |
| w/o Minimal-Change | .841 | .783 | .856 | 5.7 | Faith 微降, RCost 显著上升 | MATCH |
| w/o Attack Templates | .821 | .698 | .859 | 3.5 | Cont 显著下降, Faith 中等下降 | MATCH |
| Grounded Only | .839 | .772 | .871 | 3.0 | 轻微下降（因 97% preferred = grounded） | MATCH |

**逐项分析**:

1. **w/o Semantic Verification**: 移除语义验证后，修复可能引入语义无效的参数。Faith -5.4pp, Cont -7.7pp, RAcc -5.1pp, RCost +0.9。所有指标合理下降，验证是最关键组件。论文解释（"repairs may restore acceptability in the graph while introducing semantically invalid arguments"）与数据一致。PASS.

2. **w/o Minimal-Change**: 移除最小改变约束，使用无约束修复。Faith -0.6pp (微降，合理：修复仍然正确但不精简), RCost +2.5 (显著上升，核心预期)。论文解释正确。PASS.

3. **w/o Attack Templates**: 移除攻击模板库。Cont -9.3pp (显著下降，合理：模板提高反论的发现率), Faith -2.6pp (中等下降), RCost +0.3 (微升)。论文解释（"primarily improve the system's ability to integrate counterarguments"）与 Cont 大幅下降 + Faith 中等下降一致。PASS.

4. **Grounded Only**: 仅用 grounded semantics 替代 preferred。所有指标轻微下降。论文解释（"97% of frameworks have a single preferred extension coinciding with the grounded one"）合理：原子分解产生稀疏攻击结构。RCost 3.0 < 3.2 (Full)，这也合理：grounded 语义下的修复空间更小，可能找到更便宜的修复。PASS.

**[MINOR] B2.1a**: Grounded Only 变体的 RCost (3.0) 低于 Full ARGUS (3.2)，论文未显式解释此现象。直觉上，grounded 语义更宽松（只需在 grounded extension 中接受），因此可能需要更少的操作。可以在消融讨论中加一句简短说明。

### B2.2 消融百分比验证

- "Removing semantic verification causes the largest drops in faithfulness (-5.4pp)": 0.847 - 0.793 = 0.054 = 5.4pp. CORRECT.
- "and contestability (-7.7pp)": 0.791 - 0.714 = 0.077 = 7.7pp. CORRECT.
- "increases cost from 3.2 to 5.7": Table 2 shows w/o Minimal-Change RCost = 5.7, Full = 3.2. CORRECT.
- "Removing attack templates reduces contestability by 9.3pp": 0.791 - 0.698 = 0.093 = 9.3pp. CORRECT.

**结论**: PASS.

---

## B3. 数据一致性

### B3.1 results.json vs. 宏定义 (main.tex 行 69-81)

| 宏 | main.tex 值 | results.json 值 | 匹配 |
|----|-------------|-----------------|------|
| resultFaithHotpot | 0.847 | 0.847 | PASS |
| resultFaithFEVER | 0.829 | 0.829 | PASS |
| resultContestHotpot | 0.791 | 0.791 | PASS |
| resultContestFEVER | 0.768 | 0.768 | PASS |
| resultRepairCostHotpot | 3.2 | 3.2 | PASS |
| resultRepairCostFEVER | 2.8 | 2.8 | PASS |
| resultRepairAccHotpot | 0.883 | 0.883 | PASS |
| resultRepairAccFEVER | 0.871 | 0.871 | PASS |
| improveFaithfulness | 10.3% | +10.3% | PASS |
| improveContestability | 14.5% | +14.5% | PASS |

### B3.2 Table 1 (main results) vs. results.json

检查所有 8 个 baseline + ARGUS 在两个数据集上的值:

| Method | Dataset | Faith | Cont | RAcc | RCost | Match |
|--------|---------|-------|------|------|-------|-------|
| SelfCheckGPT | HotpotQA | .693 / 0.693 | .524 / 0.524 | .701 / 0.701 | 8.4 / 8.4 | PASS |
| SelfCheckGPT | FEVER | .674 / 0.674 | .498 / 0.498 | .685 / 0.685 | 7.9 / 7.9 | PASS |
| Self-Refine | HotpotQA | .712 / 0.712 | .541 / 0.541 | .736 / 0.736 | 7.1 / 7.1 | PASS |
| Self-Refine | FEVER | .698 / 0.698 | .519 / 0.519 | .721 / 0.721 | 6.8 / 6.8 | PASS |
| Reflexion | HotpotQA | .724 / 0.724 | .563 / 0.563 | .752 / 0.752 | 6.6 / 6.6 | PASS |
| Reflexion | FEVER | .709 / 0.709 | .537 / 0.537 | .738 / 0.738 | 6.2 / 6.2 | PASS |
| RARR | HotpotQA | .738 / 0.738 | .547 / 0.547 | .769 / 0.769 | 5.8 / 5.8 | PASS |
| RARR | FEVER | .721 / 0.721 | .531 / 0.531 | .754 / 0.754 | 5.5 / 5.5 | PASS |
| CoT-Verifier | HotpotQA | .751 / 0.751 | .589 / 0.589 | N/A / null | N/A / null | PASS |
| CoT-Verifier | FEVER | .733 / 0.733 | .561 / 0.561 | N/A / null | N/A / null | PASS |
| ArgLLMs | HotpotQA | .754 / 0.754 | .667 / 0.667 | N/A / null | N/A / null | PASS |
| ArgLLMs | FEVER | .741 / 0.741 | .649 / 0.649 | N/A / null | N/A / null | PASS |
| ARGORA | HotpotQA | .768 / 0.768 | .691 / 0.691 | .801 / 0.801 | 5.1 / 5.1 | PASS |
| ARGORA | FEVER | .752 / 0.752 | .672 / 0.672 | .788 / 0.788 | 4.7 / 4.7 | PASS |
| Regenerate | HotpotQA | .709 / 0.709 | --- / null | .743 / 0.743 | --- / null | PASS |
| Regenerate | FEVER | .695 / 0.695 | --- / null | .729 / 0.729 | --- / null | PASS |
| ARGUS | HotpotQA | macro / 0.847 | macro / 0.791 | macro / 0.883 | macro / 3.2 | PASS |
| ARGUS | FEVER | macro / 0.829 | macro / 0.768 | macro / 0.871 | macro / 2.8 | PASS |

### B3.3 Table 2 (ablation) vs. results.json

| 变体 | Faith | Cont | RAcc | RCost | Match |
|------|-------|------|------|-------|-------|
| Full_ARGUS | .847/0.847 | .791/0.791 | .883/0.883 | 3.2/3.2 | PASS |
| w/o_Semantic_Verification | .793/0.793 | .714/0.714 | .832/0.832 | 4.1/4.1 | PASS |
| w/o_MinimalChange | .841/0.841 | .783/0.783 | .856/0.856 | 5.7/5.7 | PASS |
| w/o_Attack_Templates | .821/0.821 | .698/0.698 | .859/0.859 | 3.5/3.5 | PASS |
| Grounded_Only | .839/0.839 | .772/0.772 | .871/0.871 | 3.0/3.0 | PASS |

### B3.4 改进百分比验证

| 计算 | 公式 | 结果 | 论文声明 | 匹配 |
|------|------|------|----------|------|
| Faith improvement HP | (0.847-0.768)/0.768 | 10.29% | 10.3% | PASS (rounding) |
| Contest improvement HP | (0.791-0.691)/0.691 | 14.47% | 14.5% | PASS (rounding) |
| Faith improvement FEVER | (0.829-0.752)/0.752 | 10.24% | 10.2% (results.json) | PASS |
| Contest improvement FEVER | (0.768-0.672)/0.672 | 14.29% | 14.3% (results.json) | PASS |

### B3.5 摘要 vs. 正文 vs. 结论数据一致性

**Abstract**: "relative improvements of 10.3% in faithfulness and 14.5% in contestability over the strongest argumentation baseline while requiring fewer repair operations than all competing methods"
- 10.3% / 14.5%: 与宏 improveFaithfulness / improveContestability 一致. PASS.
- "fewer repair operations than all competing methods": ARGUS HotpotQA RCost = 3.2, vs ARGORA 5.1 (最低 baseline). PASS.

**Conclusion**: "relative improvements of up to 10.3% in faithfulness and 14.5% in contestability over the strongest argumentation baseline, while achieving the lowest repair cost among all repair-capable methods"
- "up to 10.3%": 宏引用，正确. 但注意 FEVER faithfulness improvement 是 10.2%，所以 "up to" 是准确的. PASS.
- "lowest repair cost": 3.2/2.8 vs ARGORA 5.1/4.7. PASS.

### B3.6 人类评估数据: 附录 vs. 正文

**experiments.tex 行 183**: "higher mean faithfulness ratings (3.9 vs. 3.4 on a 5-point Likert scale, p < 0.001)"
**appendix.tex Table (tab:human-eval)**: ARGUS Faith 3.9 +/- 0.7, Self-Refine 3.4 +/- 0.9, p < 0.001. MATCH.

**experiments.tex 行 183**: "coherence ratings (4.1 vs. 3.8, p = 0.012)"
**appendix.tex Table**: ARGUS Coherence 4.1 +/- 0.6, Self-Refine 3.8 +/- 0.8, p = 0.012. MATCH.

**experiments.tex 行 184**: "annotators preferred ARGUS in 68% of comparisons, Self-Refine in 19%, with 13% ties (Cohen's kappa=0.62)"
**appendix.tex**: Preference ARGUS 68%, Self-Refine 19%, Tie 13%. Kappa = 0.62. MATCH.
**results.json**: preference ARGUS 0.68, Self-Refine 0.19, Tie 0.13. agreement kappa 0.62. MATCH.

**experiments.tex 行 185**: "Pearson correlation... r=0.78 (p<0.001)"
**appendix.tex 行 129**: r = 0.78 (p < 0.001). MATCH.
**results.json**: pearson_r 0.78, p_value "<0.001". MATCH.

### B3.7 理论验证数据: 正文 vs. results.json

**experiments.tex 行 54**: "Vacuity holds without exception... covering 5% of HotpotQA and 8% of FEVER instances"
**results.json**: AGM_vacuity pass_rate 1.0. Cost distribution: HotpotQA 0-cost = 5%, FEVER 0-cost = 8%. CONSISTENT.

**experiments.tex 行 55**: "frameworks averaged 6.8 arguments (max 18) on HotpotQA and 5.4 (max 14) on FEVER"
**Not in results.json** but internally consistent with paper text. N/A for json check.

**experiments.tex 行 56**: "Grounded-semantics solve times averaged 0.12s and preferred 0.43s"
**results.json**: grounded_repair_time_s mean 0.12, preferred_repair_time_s mean 0.43. MATCH.

**experiments.tex 行 91**: "setting k=3 recovered optimal repairs in 99.7% of cases"
**results.json**: minimality pass_rate 0.997. MATCH.

**experiments.tex 行 108**: "k-neighborhood approximation keeps preferred repair tractable up to |A|=50 (2.31s)"
**results.json**: scalability preferred_k3_at_n50 2.31. MATCH.
**Figure 4 (scalability) data point**: preferred k=3 at 50 = 2.31. MATCH.

**experiments.tex 行 108**: "unconstrained preferred repair... exceeds 150s at |A|=50"
**results.json**: preferred_full_at_n50 158.4. MATCH.
**Figure 4 data point**: preferred full at 50 = 158.4. MATCH.

### B3.8 Cost Distribution Histogram vs. Text Claims

**experiments.tex 行 176 caption**: "83% of HotpotQA and 90% of FEVER repairs require at most 4 operations"
**Figure 5 data**: HotpotQA: 5+10+21+27+20 = 83%. FEVER: 8+15+26+25+16 = 90%. MATCH.

**experiments.tex 行 180**: "modal cost is 3 operations on HotpotQA (27%) and 2 on FEVER (26%)"
**Figure 5 data**: HotpotQA max at cost=3 (27%). FEVER max at cost=2 (26%). MATCH.

**Distribution sums**: HotpotQA: 5+10+21+27+20+17 = 100%. FEVER: 8+15+26+25+16+10 = 100%. PASS.

---

## B4. 交叉引用

### B4.1 LaTeX Compilation

- 0 errors, 0 undefined references, 0 multiply-defined labels.
- 4 font shape warnings (OT1/ptm/m/scit) -- cosmetic only, from \textsc in italics context.
- PASS.

### B4.2 Label/Ref Completeness

All \ref{} targets have corresponding \label{} definitions:
- Sections: sec:intro, sec:related, sec:preliminaries, sec:method, sec:extraction, sec:relation, sec:verification, sec:repair, sec:theory, sec:experiments, sec:conclusion -- all defined.
- Figures: fig:positioning, fig:af-evolution, fig:af-f0, fig:af-f1, fig:af-f2, fig:pipeline, fig:scalability, fig:cost-dist, fig:repair-example -- all defined.
- Tables: tab:main, tab:ablation, tab:human-eval -- all defined.
- Definitions: def:af, def:defense-set, def:task, def:repair -- all defined.
- Theorems: thm:agm, thm:representation, thm:complexity -- all defined.
- Proposition: prop:encoding -- defined.
- Examples: ex:running, ex:af, ex:defense, ex:verify, ex:repair-ex, ex:cost, ex:agm -- all defined.
- Algorithm: alg:repair -- defined.
- Appendix sections: app:repair-example, app:sensitivity, app:error-analysis, app:representation, app:exp-details, app:human-eval -- all defined.

No orphaned labels (labels without any \ref{} pointing to them) worth flagging.
PASS.

### B4.3 Section Reference Consistency

- C2 references "\S\ref{sec:repair}--\S\ref{sec:theory}" -- sec:repair is a subsection of sec:method, sec:theory is the next section. This range makes sense.
- method.tex references "Definition~\ref{def:af}" and "Definition~\ref{def:repair}" -- correct targets.
- theory.tex references "Definition~\ref{def:repair}" multiple times -- correct.
- experiments.tex references "\S\ref{sec:theory}" and "Theorem~\ref{thm:complexity}" -- correct.
- Appendix references "Appendix~\ref{app:representation}" and "\S\ref{sec:experiments}" -- correct.

PASS.

---

## 发现汇总

### MINOR Issues

**M1 [MINOR - B1.6a]: Representation Theorem 证明中 Inclusion 到 minimality 的论证跳跃**

文件: `/home/qq/KR26/paper/sections/appendix.tex`, 行 66-68

附录中 Theorem 13 (Representation) 的 (<=) 方向证明在 non-vacuity case 中，论证从 Inclusion postulate 推导 "每个操作都是必要的" 时存在微妙的论证间隙。Inclusion 的形式化定义（Theorem 11(2)）规定了结构保留关系，但并不直接蕴含操作的不可约性。证明在行 66-68 通过 "Combined with success and kappa > 0" 试图弥补，但实际上这里的核心论证依赖于 optimality 假设（如果存在更小的 valid repair 则原 operator 违反了 inclusion under positive cost 的蕴含），而这一点可以更清晰地表述。结论是正确的，但 argumentation-savvy 审稿人可能要求更精确的分离。

**建议**: 在证明中明确说明 Inclusion + Success + kappa > 0 三者联合蕴含 irredundancy（不可约性），而非单独归因于 Inclusion。

---

**M2 [MINOR - B2.1a]: Grounded Only 消融变体的 RCost 下降未解释**

文件: `/home/qq/KR26/paper/sections/experiments.tex`, 行 131

Grounded Only 变体的 RCost (3.0) 低于 Full ARGUS (3.0 < 3.2)。论文讨论了该变体在 faithfulness 和 contestability 上的轻微下降，但未解释为什么 repair cost 反而更低。直觉上，grounded 语义的修复约束更宽松（只需满足唯一 grounded extension 中的接受性），因此可能需要更少的操作。但这一点值得在消融分析中简短提及，以防审稿人追问。

**建议**: 在 "Grounded-only semantics yields modest decreases across all metrics" 之后加一句解释 RCost 下降的原因。

---

**M3 [MINOR - B3.7]: Sensitivity Analysis 中的 Llama-3 结果与正文缺少交叉引用**

文件: `/home/qq/KR26/paper/sections/appendix.tex`, 行 46

附录 Sensitivity Analysis 报告了 Llama-3-70B-Instruct 作为 extraction backbone 的结果 (faithfulness 0.813, contestability 0.762)，但这些数字未出现在 results.json 中。虽然作为 pilot study 可以接受不收录到主数据文件，但建议在 results.json 中添加 sensitivity_analysis 条目以保持数据追踪完整性。

---

**M4 [MINOR]: CLAUDE.md 中 "Definition 5 in method.tex" 的记录与实际不符**

文件: `/home/qq/KR26/CLAUDE.md`, 第 14 节 "形式化元素清单"

CLAUDE.md 列出 "Definition 5 | Def 5 | method.tex | 修复问题形式化"，但实际上 method.tex 中没有 \begin{definition} 环境。4 个 Definition 全部在 preliminaries.tex 中（编号 2, 4, 6, 8）。method.tex 中的修复问题讨论引用了 Definition 8 (def:repair)，没有新增定义。这是 CLAUDE.md 的元数据错误，不影响论文本身，但可能在后续 session 中引起混淆。

---

**M5 [MINOR]: CLAUDE.md 中 Theorem 编号与实际全局编号不对应**

文件: `/home/qq/KR26/CLAUDE.md`, 第 14 节

CLAUDE.md 列出 "Theorem 1 = AGM Compliance, Theorem 2 = Complexity, Proposition 1 = ASP encoding"。但实际全局编号为 Theorem 11 = AGM Compliance, Theorem 13 = Representation, Theorem 14 = Complexity, Proposition 15 = Encoding Correctness。此外 CLAUDE.md 遗漏了 Theorem 13 (Representation Theorem)。同样不影响论文本身。

---

## 统计

- **CRITICAL**: 0
- **MAJOR**: 0
- **MINOR**: 5 (M1: 证明论证精度, M2: 消融解释缺失, M3: sensitivity 数据未收录, M4-M5: CLAUDE.md 元数据)

---

## 总体评价

论文的形式系统在 R83 审查中表现出色。4 个 Definition、3 个 Theorem、1 个 Proposition 的全局编号 1-15 连续无跳号。AGM 合规性分析覆盖了全部 8 个 postulates（3 个正式证明、2 个声明持有、1 个反例失败、2 个论证不适用），复杂度结果在论文各处一致。数据一致性检查涵盖 10 个宏定义、所有表格条目、百分比计算、直方图分布和人类评估数据，全部匹配。消融实验逻辑合理，所有移除组件后的性能变化方向符合理论预期。交叉引用无遗漏、无冲突。

与 R82 (0C/0M/9m) 相比，本轮在形式逻辑和数据一致性方面的深度审查未发现任何 CRITICAL 或 MAJOR 问题，仅有 5 个 MINOR 发现（其中 2 个涉及论文本身的表述精度，3 个涉及 CLAUDE.md 的元数据一致性）。论文的理论基础和实验数据管理达到了 KR 投稿的标准。
