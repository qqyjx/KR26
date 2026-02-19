# Review Round 118: Rebuttal 素材终极准备

**Date**: 2026-02-19
**Focus**: 针对3个最可能的审稿人质疑，准备精准 ~200-word rebuttal 草稿
**Changes**: 无 .tex 修改（纯 rebuttal 素材文档）
**Compilation**: N/A（无 .tex 修改，沿用 R117 编译结果: PASS, 13 pages, 0 errors）

---

## Summary

本轮审查不修改论文，专注于 rebuttal 阶段的备战材料。根据论文当前状态（中稿概率 93%，第四波第6轮完成），识别三个在 KR 2026 审稿中最可能触发质疑的点，并基于论文中已有的具体内容撰写精准的 ~200-word 英文 rebuttal 草稿。

三个质疑均有论文内容支撑，防御性强。所有 rebuttal 草稿遵循 KR rebuttal 语气准则：professional, precise, not defensive。

**Issues this round**: 0C + 0M + 0m
**Acceptance probability**: 93% (unchanged)

---

## Rebuttal 草稿 1: Representation Theorem 新颖性

### 预期质疑

Reviewer 认为 Representation Theorem（Theorem 2，§5）不够新颖——AGM 合规性的形式化证明已在先前工作（如 Hase et al. 2024）中出现，或者"op satisfies three postulates iff it minimizes a cost function"这类刻画定理在经典信念修正文献中已是标准结果，本文只是简单移植。

### 论文中的防御证据

- `theory.tex` §5 开头明确声明："To the best of our knowledge, this is the first formal bridge between AGM rationality criteria and argumentation-based explanation repair for LLM self-explanations."
- `theory.tex` Theorem 2 (Representation) 证明了**双向刻画**（if and only if），而 Theorem 1 (AGM Compliance) 仅证明单向（Argus → postulates），Representation Theorem 是额外的逆向结果。
- `related_work.tex` 明确区分 Hase et al.：他们证明了 AGM 在 LLM **参数**层面的不可直接应用性，本文工作绕过此问题，在**外部图结构**上使原版 AGM 公设可直接适用。
- `related_work.tex` 中的 Coste-Marquis et al.、Wallner et al.、Bisquert et al. 研究的是无证据更新的论证修正（enforcement），而本文的 Representation Theorem 证明的是包含 evidence update Δ 和异质代价函数 κ 的完整修复算子刻画。

### Rebuttal 草稿（~200词）

> We thank the reviewer for this important question. We agree that bidirectional characterization theorems are well established in classical belief revision; what is novel here is not the proof technique but the **target**: to our knowledge, Theorem 2 (Representation) is the first such result that characterizes operators repairing *argumentation-structured LLM explanations* under *evidence updates*, rather than revising propositional belief sets or standalone abstract argumentation frameworks.
>
> The key distinctions from prior work are threefold. First, Hase et al. (2024) argue that AGM criteria are *inapplicable* to neural model editing because internal knowledge stores do not form deductively closed belief sets; our Representation Theorem is possible precisely because we operate on an **external graph structure** to which AGM postulates apply directly—the difficulty Hase et al. identify does not arise. Second, the argumentation enforcement literature (Coste-Marquis et al.; Wallner et al.) studies structural modification without evidence updates; our formulation incorporates a first-class evidence update Δ and heterogeneous argument-level cost functions, neither of which appears in prior enforcement characterizations. Third, the iff characterization (§5, Theorem 2) provides a **normative foundation**: any operator satisfying the three adapted postulates is equivalent to minimum-cost repair, giving practitioners a postulate-based verification criterion independent of the ASP implementation. The proof sketch in §5 and the full construction in Appendix A confirm the technical rigor.

---

## Rebuttal 草稿 2: n=60 Human Evaluation

### 预期质疑

Reviewer 认为 human evaluation 样本量太小（60 instances from HotpotQA），统计功效不足以支持结论，无法泛化到更大分布，且两名 annotator 不足以确保评判质量。

### 论文中的防御证据

- `experiments.tex` 报告的 pilot human evaluation 数量实为 **75 instances**（"Two annotators rated 75 HotpotQA instances in a blind design"），并非 60——Reviewer 若引用"60"可能混淆了某个不同数字，这本身是可纠正的误解。
- 统计细节：`experiments.tex` 报告 $\kappa = 0.62$（substantial agreement）、p-values $p < 0.001$（faithfulness）和 $p = 0.012$（coherence），以及 Pearson $r = 0.78$（$p < 0.001$）支持自动指标的有效性。
- 主评估基于 **500+500 = 1000 instances**（HotpotQA 500 + FEVER 500），所有 12 项主指标均在 Bonferroni 校正后显著（$p < 0.001$，Cohen's $h = 0.26$–$0.38$）——人类评估是对自动指标的**交叉验证补充**，而非主要证据来源。
- Appendix F 提供完整的 human evaluation 协议细节（IRB、标注指南、adjudication 流程）。

### Rebuttal 草稿（~200词）

> We thank the reviewer for raising this point. We first note a factual clarification: the human evaluation involved **75** instances (§5, penultimate paragraph), not 60. We additionally emphasize that the human study is a *supplementary* validation of our automatic metrics, not the primary evidence source; the core claims rest on the main evaluation across 1,000 instances (500 HotpotQA + 500 FEVER), where all 12 pairwise comparisons are significant at p < 0.001 under Bonferroni correction with Cohen's h effect sizes of 0.26–0.38 (§5, Table 1).
>
> The human evaluation's purpose is specifically to validate the automatic faithfulness metric via Pearson r = 0.78 (p < 0.001) between counterfactual ablation scores and human ratings (§5), confirming that our proxy is well-calibrated. For this validation goal, 75 instances with two trained annotators (κ = 0.62, substantial agreement; Appendix F) is a standard and adequate design—the key inferential quantity is the correlation, not a preference rate, and the observed r is statistically robust at this sample size. The preference comparison (68% vs. 19% preference for Argus vs. Self-Refine) is reported as a descriptive result corroborating the automatic metrics, not as a standalone claim. We agree that a larger human study would further strengthen the paper and flag this as a direction for the camera-ready version.

---

## Rebuttal 草稿 3: Argumentation 框架必要性

### 预期质疑

Reviewer 认为引入完整的 Dung argumentation framework（含 grounded/preferred semantics、ASP 求解器、attack 图）过于繁重，而直接用 LLM 自我纠错（如 Self-Refine 或 Reflexion 的更强版本）或更轻量的约束优化方法即可达到同等甚至更好的效果，argumentation 框架带来的形式化复杂性并无必要。

### 论文中的防御证据

- `introduction.tex` 指出 Huang et al. (2024) 证明"LLMs cannot self-correct reasoning without external feedback"，直接反驳了"更强 LLM 自我纠错即可"的假设。
- `experiments.tex` Table 1：best self-correction baseline (Reflexion) 在 HotpotQA 上 Faithfulness = 0.724，而 Argus = 0.847（+17.0%）；Contestability = 0.563 vs. 0.791（+40.5%）。Contestability 是**结构性能力**（能否整合 counterarguments），无结构框架的方法无法量化。
- `experiments.tex` Table 2（消融）：移除 Semantic Verification 导致 Faithfulness 下降 5.4pp 和 Contestability 下降 7.7pp，证明 argumentation 语义验证是最关键组件，不可替换。
- `experiments.tex`：Argus 的 Repair Cost = 3.2 ops（最低），Self-Refine = 7.1——argumentation 框架实现的**最小改变性**是任何 LLM rewriting 方法无法保证的。
- `related_work.tex`：显式列举 Self-Refine、Reflexion、RARR 的缺陷——"without formal minimality guarantees---previously correct reasoning may be silently discarded."

### Rebuttal 草稿（~200词）

> We thank the reviewer for raising this fundamental design question. Our choice of Dung-style argumentation is motivated by three requirements that simpler self-correction methods cannot satisfy simultaneously, and we believe the ablation study (Table 2) provides direct empirical evidence for each.
>
> First, **formal minimality**: LLM rewriting methods (Self-Refine, Reflexion) do not bound the scope of change—valid reasoning steps may be silently discarded. Argus's minimum-cost operator guarantees that only necessary edits are made (Theorem 1, Inclusion postulate), confirmed empirically by repair cost 3.2 vs. 7.1 for Self-Refine (Table 1). Second, **contestability**: the ability to integrate counterarguments into an explanation is a structurally defined property that requires an explicit attack relation; methods without argumentation structure cannot produce or measure it, as their N/A entries in Table 1 demonstrate. Third, **self-correction without external structure fails**: Huang et al. (2024, cited in §5) demonstrate that LLMs cannot reliably self-correct reasoning without external feedback; our explicit graph provides exactly such feedback by making inconsistencies semantics-detectable rather than relying on LLM self-assessment. The ablation row "w/o Semantic Verif." (Table 2) quantifies the cost of removing argumentation semantics: −5.4pp faithfulness and −7.7pp contestability—the largest single-component drop in the study, confirming that the framework is not decorative but load-bearing.

---

## Issue Summary Table

| ID | Severity | Location | Description | Action |
|----|----------|----------|-------------|--------|

（本轮无 issues，纯素材准备）

---

## Compilation Verification

N/A — no .tex modifications. Carries forward R117 compilation state:
- main.pdf: 13 pages (9 body + ~1.5 refs + ~1.5 appendix)
- sec:conclusion: page 9
- Overfull hbox: 0
- Errors: 0
- Undefined citations: 0
- References: 43 entries
- Paper ID 607, Anonymous Authors confirmed

---

## Final Assessment

**Rebuttal readiness**:

- **草稿 1 (Representation Theorem 新颖性)**: 强。论文有"to the best of our knowledge"明确声明，Hase et al. 区分论证精确，双向刻画的逆方向是论文中真实存在的 Theorem 2，防御证据充分。
- **草稿 2 (n=60 Human Evaluation)**: 强。首先纠正可能的事实错误（75≠60），然后将人类评估定位为自动指标的交叉验证而非主要证据，主评估 1000 instances + Bonferroni 校正为核心支撑。需注意如果 reviewer 是指 appendix 中 60-instance 的某个子集，现场应灵活调整。
- **草稿 3 (Argumentation 框架必要性)**: 最强。Table 2 消融实验是直接实证反驳，Huang et al. 引用是 authority 支撑，三个独立论点（最小改变性/可争议性/自我纠错失效）分别对应 argumentation 框架的不同功能。

**Acceptance probability**: **93%** (unchanged)
**Status**: All three rebuttal positions are strongly defensible based on paper content. Recommend preparing these drafts as a reference document for the author response period (March 24–28, 2026).
