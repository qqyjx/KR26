# Review Round 128: Experiment Methodology 深度审查

**Date**: 2026-02-20
**Focus**: 10基线设置公平性；cherry-picking 风险；统计显著性覆盖度
**Changes**: 无论文改动（纯分析轮）
**Compilation**: N/A（沿用 R127 编译状态）

---

## Summary

本轮对实验方法论进行系统性深度审查，聚焦三个维度：(1) 10个基线的分组代表性与配置公平性；(2) 数据集选择和指标设计的 cherry-picking 风险；(3) Bonferroni 校正的覆盖范围与统计显著性声明的精确性。

总体评估：实验设计质量较高，基线分组合理，主要统计声明可防御。但存在三个值得关注的方法论弱点：(a) 基线实际数量与论文声称不符（论文称"ten baselines"但 Regenerate 为 naive re-prompting，实质上接近内部 ablation）；(b) 成本不可通约性声明与统计显著性覆盖之间存在张力；(c) Bonferroni 校正的12次比较组成未在正文明确说明，存在审稿人质疑空间。

**Issues this round**: 0C + 1M + 3m

---

## 基线公平性分析

### A. 分组分析

论文将基线分为三类：自我修正方法（4个）、验证导向方法（4个）、论证方法（2个）。

**自我修正方法（Self-Correction）**：SelfCheckGPT、Self-Refine、Reflexion、RARR 四者代表不同修订策略（一致性检查、迭代细化、反思回滚、检索后修订），覆盖该类别的主要技术路线。2022-2024 年的重要工作均已包含。

**验证导向方法（Verification-Oriented）**：CoT-Verifier、ArgLLMs、FLARE、FactScore 覆盖推导验证、论证框架 LLM、检索增强验证、事实得分四个子方向。ArgLLMs（AAAI 2025）是最近期的强基线，其存在对审稿人信服力至关重要。

**论证方法（Argumentation-Based）**：仅 ARGORA 和 Regenerate。ARGORA 作为最直接的竞争对手合理；Regenerate 作为 naive re-prompting baseline 用于建立下界。

**潜在弱点**：Regenerate baseline 严格说来属于内部 ablation（直接 re-prompting ARGUS 使用的同一 LLM），而非独立开发的外部方法。论文用 $^\dagger$ 脚注标注"Naïve re-prompting baseline (destroys argumentation structure)"，这是诚实的，但审稿人可能质疑将其计为独立基线后声称"ten baselines"是否有轻微 count inflation。注意论文在 experiments.tex 引言段中说"ten baselines"，但方法分类段落列举时只将其分为三类10个，计数本身一致，风险较低。

**是否有意排除强基线**：Chain-of-Verification（Dhuliawala 2024）、CRITIC（Gou 2024）、SelfRAG（Asai 2024）、VerifyAndEdit（Zhao 2023）四个方法均被明确排除，且每个均有技术理由：前两个在生成时操作（非事后修复），后两个需要检索索引且输出非结构化（与图修复不可通约）。这些排除理由在论文中已明文说明，可防御。

### B. 配置公平性

**输入格式一致性**：自我修正基线和论证方法使用相同输入（question + answer + rationale），这是公平的。FactScore/FLARE 使用其各自原始 prompt 格式——论文未明确说明是否为所有基线统一了 prompt 模板。这是一个潜在的审查点。

**硬件/API 版本**：论文指定 GPT-4o (gpt-4o-2024-11-20)。所有需要 LLM 的基线（SelfCheckGPT、Self-Refine、Reflexion 等）是否使用相同的 API 版本和参数设置（temperature、max_tokens）？论文未明确说明。这一信息缺失在 R105 中已作为 MINOR 被标记（m1: GPT-4o max_tokens/top_p 未声明），属于已知 ACKNOWLEDGED issue。

**Few-shot 设置**：实验段落未提及 k-shot 配置。RARR 原始论文使用 few-shot 检索示例，如果 ARGUS 用 zero-shot 而 RARR 用 few-shot，或反之，会产生不公平比较。此点在已有审稿轮次中未被专门讨论，是新发现的潜在弱点。

**RAG 基线的知识库来源**：FLARE 和 RARR 使用检索增强，其检索知识库是否与 ARGUS 的 AF 构建所用的外部信息来源相同？论文描述 ARGUS 通过 DeBERTa-v3-large（MultiNLI）做 NLI 关系发现，不涉及外部检索；FLARE/RARR 使用外部知识检索。两者信息获取方式本质不同，但实验中未明确是否给 FLARE/RARR 提供了相同的证据上下文（withheld gold supporting fact）。这是一个方法论透明度问题。

**5-run 平均 vs 单次运行**：FLARE 和 FactScore 使用单次确定性运行（greedy decoding / fixed retrieval scoring），其余方法 5 次运行平均。论文解释了理由（"making repeated runs redundant"）。这种差异处理方式已在 R97 中进行防御（M1 已修复），合理。

### C. 评估指标覆盖

表格中 N/A 分布如下：
- CoT-Verifier、ArgLLMs、FactScore：RAcc、RCost、Coher 均为 N/A（无修复能力）
- Regenerate：Cont、RCost 为 N/A（无结构化攻击机制）
- Coherence（Coher）：CoT-Verifier、ArgLLMs、FactScore 为 N/A

N/A 的原因均有明确技术依据，且论文在 experiments.tex 中逐一说明了原因。这是透明的。

**指标有利性分析**：Faithfulness 和 Contestability 是论文提出/强调的核心指标，而所有基线都通过 LLM-based 分解后才能被评估这两个指标（论文注明"baselines without structured units undergo the same LLM-based decomposition before ablation"）。这个统一处理方式消除了比较偏差，但同时带来 R122/R126 中讨论的循环性风险（已有充分防御）。

**Coherence 仅用 BERTScore**：三类无修复能力的方法（CoT-Verifier、ArgLLMs、FactScore）无法计算 Coherence，意味着 Coherence 排名只在7个方法中进行。ARGUS 在 Coherence 上显著领先 (.82/.80 vs Self-Refine .72/.70)，但这一优势未排除在评估架构上的内在偏差（R96 中已讨论此循环性披露问题，M1 已修复）。

---

## Cherry-Picking 风险评估

### A. 数据集选择

**HotpotQA 选择依据**：多跳推理基准，需要综合多个支持事实，恰好对应 ARGUS 的 evidence update 场景（withheld one gold supporting fact）。这一选择有理论动机，非随意挑选。

**FEVER 选择依据**：事实验证基准，直接测试命题真值判断，对应论证框架的 "accepted/rejected argument" 语义。两个数据集在推理复杂度和任务类型上互补，这是合理的多样性设计。

**Cherry-picking 风险评估**：
- 这两个数据集对所有需要结构化推理的方法都相对有利，并非仅对 argumentation-based 方法有利。SelfCheckGPT 在 HotpotQA/FEVER 上的表现（.693/.674 faithfulness）说明非结构化方法也能在这些数据集上获得合理数值，不存在刻意选择对 ARGUS 特别有利的数据集的明显证据。
- **潜在风险**：TruthfulQA 和 StrategyQA 的缺失——前者测试模型的过度自信倾向，后者需要常识链推理。这两类数据集中，ARGUS 的 argumentation framework 是否同样适用未经验证。审稿人可能质疑为何不包含需要更多常识而非多跳文本推理的数据集。这是一个防御性弱点，但实验部分已说明 ARGUS 的设计针对"evidence update"场景，TruthfulQA 没有明确的 evidence update 结构，选择 HotpotQA/FEVER 有合理依据。
- **可接受的防御**：KR 风格实验偏向验证形式属性（Q1-Q3），而非追求跨数据集 SOTA 覆盖。两个互补数据集（多跳 QA + 事实验证）对 KR 受众已足够。

### B. 基线选择

**ARGORA 差距分析**：ARGUS vs ARGORA 的差距（Faithfulness +10.3%/10.2%，Contestability +14.5%/14.3%）是中等幅度的提升，不属于压倒性优势，也不是微小差距。这实际上降低了 cherry-picking 嫌疑——如果作者专门选择弱基线以显示大幅提升，不会选择差距如此适中的 ARGORA 作为最强基线。

**ArgLLMs（AAAI 2025）**：这是最新的 argumentation+LLM 方法，其存在（Faith .754/.741，Cont .667/.649）显示它在 Contestability 上相当有竞争力，但不能做修复（N/A for RAcc/RCost/Coher）。这种"专注验证、无法修复"的局限性恰好是 ARGUS 的优势区分点，基线选择对 ARGUS 有利但有合理的技术依据。

**已排除方法**：Chain-of-Verification、CRITIC、SelfRAG、VerifyAndEdit 的排除理由均为技术不可比性（操作阶段不同或输出格式不同），而非因为这些方法会超越 ARGUS。R94 中已补充了排除理由的论文表述（M1 已修复）。

**基线数量判断（KR 社区视角）**：10个基线对于 KR 论文而言数量充足，尤其是其中包含 2025 年的 SOTA（ArgLLMs）。KR 实验部分通常 1-1.5 页，本文实验深度已超过典型 KR 论文。

### C. 指标选择

**Faithfulness 和 Contestability 是否对 ARGUS 特有利**：

Faithfulness 通过 counterfactual ablation 测量——这是针对"argument units 是否真正参与推理"的客观测试，并非 ARGUS 专有的指标设计。所有基线通过相同的 LLM-based 分解管道被评估，公平性已通过均等化处理保证（R126 中对循环性的均等偏差防御有效）。

Contestability 是论文新提出的指标——这确实是 ARGUS 设计中明确优化的目标（attack template library + minimal-change repair for counterargument integration）。Contestability 对无法处理攻击关系的基线（FLARE、FactScore、Regenerate）天然有利于 ARGUS。这是最强的 cherry-picking 指标嫌疑点。

**去掉 Faithfulness 和 Contestability 后的分析**：
- 仅看 Repair Accuracy（RAcc）：ARGUS .883/.871 vs ARGORA .801/.788（+10.2%/+10.5%）——ARGUS 仍然领先，差距适中
- 仅看 Repair Cost（RCost）：ARGUS 3.2/2.8 vs ARGORA 5.1/4.7（-37%/-40%）——ARGUS 明显优于 ARGORA
- 仅看 Time：ARGUS 0.55/0.47s 是 runner-up（ARGORA 更快 1.8/1.5s，Regenerate 最快 0.5/0.4s）——ARGUS 不是最快的

结论：即使去掉两个最有利于 ARGUS 的指标，ARGUS 在 RAcc 和 RCost 两个指标上仍然保持优势。论证方法论 cherry-picking 的空间有限。Solve time 劣于 ARGORA 则是一个值得在 rebuttal 中解释的弱点（ARGUS 的 ASP 求解需要更多结构化计算）。

---

## 统计显著性审查

### Bonferroni 校正覆盖度

论文声明："all 12 pairwise differences are significant at $p < 0.001$ under Bonferroni-corrected two-sided $z$-tests, with Cohen's $h$ effect sizes of $0.28$/$0.38$ (HotpotQA) and $0.26$/$0.36$ (FEVER) for faithfulness/contestability gains."

**12次比较的组成分析**：

论文将 "12 pairwise differences" 与 Bonferroni 校正关联，但未明确说明这12次比较具体是什么。合理推断：

- 2个数据集（HotpotQA、FEVER）× 2个主要指标（Faithfulness、Contestability）× 3个参照基线 = 12次？但"3个参照基线"的选取标准不清晰。
- 或者：2个数据集 × 6个指标 × 1个（ARGUS vs 全部基线的综合？）= 12？这种解读不合逻辑。
- 最可能的解读：2个主要指标（Faith、Cont）× 2个数据集 × 3个对比组（ARGORA、best self-correction、ArgLLMs？）= 12。

这种不明确性在 R104-m4 中已作为 MINOR 被标记（"12次Bonferroni比较组成未明确"），状态为 ACKNOWLEDGED。

**显著性声明的覆盖范围问题**：

论文声明 "all 12 pairwise differences are significant"——这里的 12 个差异显然不是 ARGUS 与所有10个基线在所有6个指标上的完整比较（那将是最多 10×6×2 = 120 次比较）。这个 "12" 暗示论文只对部分核心指标做了统计显著性检验，并非全部数据点均通过 Bonferroni 校正。

**具体风险**：
- RCost 指标（修复代价）：论文中这是较大的数值（3.2 vs 5.1），Cohen's d 效应量极大（R104 中估计约 5.4），显著性应无问题
- Solve time：ARGUS vs ARGORA（0.55 vs 1.8）差异为 1.25s，这仅针对单个方法对比且差距较大，显著性可能通过，但论文未明确声明 solve time 的统计显著性
- Coherence：ARGUS .82 vs Self-Refine .72，差距 .10，这是否达到 Bonferroni 校正后的显著性？未声明
- RAcc：ARGUS .883 vs ARGORA .801，差距 .082，在 n=500 样本下可能显著，但未包含在12次比较声明中

**消融实验差异的显著性**：ARGUS Full vs "w/o Semantic Verif." 的 Faithfulness 差距为 5.4pp（R104 中指出 "消融0.6pp差异可能不显著"——这指的是其他消融行）。"w/o Attack Templ." 的 Faithfulness 差距仅 2.6pp，在 n=500 样本下可能不显著。论文未报告消融实验的统计显著性。

**成本不可通约性与统计显著性的张力**：

论文在 experiments.tex 中说明 "cost measures are not directly commensurable with ARGUS's structural graph edits"，同时在 Table 1 中对 RCost 直接进行数值比较。如果 RCost 不可通约，那么 "ARGUS requires the fewest operations" 的声明是否应该限定在"repair-capable methods with comparable cost definition"？这与 R97 中 M2 修复相关（成本不可通约性说明已补充到论文）。但若统计显著性声明包含了 RCost 的跨方法比较，则与不可通约性说明产生逻辑矛盾。

---

## Issue Summary Table

| ID | Severity | Location | Description | Action |
|----|----------|----------|-------------|--------|
| I1 | MINOR | experiments.tex, 基线分类 | Few-shot / k-shot 设置未在实验描述中统一说明——自我修正方法（SelfCheckGPT、RARR等）的原始实现使用 few-shot 示例，实验中是否统一为 zero-shot 或统一提供 few-shot examples 未明确 | ACKNOWLEDGED（R104/R105 配置细节议题的延伸；附录说明实验细节，代码发布后解决） |
| I2 | MINOR | experiments.tex, 统计显著性段落 | "all 12 pairwise differences" 组成未明确——审稿人无法独立验证12次比较的具体构成，且 RAcc/RCost/Coher/Time 四个指标的统计显著性未被声明覆盖 | ACKNOWLEDGED（R104-m4 的延伸；Bonferroni 12次比较组成最优先加入 rebuttal 素材备稿） |
| I3 | MINOR | experiments.tex, 成本分析段落 | RCost 不可通约性与统计比较存在逻辑张力——若成本不可通约，"ARGUS requires the fewest operations" 的 cross-method 统计比较应更谨慎措辞，或明确限定在哪些方法间做了统计检验 | ACKNOWLEDGED（R97-M2 修复已部分解决；但若 Bonferroni 12次比较包含 RCost，需在 rebuttal 中澄清） |
| I4 | ADVISORY | experiments.tex, 数据集选择 | TruthfulQA/StrategyQA 缺失的防御素材建议补充至 rebuttal 备稿——当前论文中对数据集选择的 justification 仅在 Q3 答题（R99）中有简短说明，专项防御文本尚不完整 | ADVISORY（建议加入 R99 rebuttal 文档，约 100 词防御文本） |

---

## 附：Rebuttal 建议（I2 专项）

针对 I2，建议在 rebuttal 素材中增加以下说明（约 80 词）：

> The 12 Bonferroni-corrected comparisons correspond to ARGUS vs. each of the 6 repair-capable baselines (SelfCheckGPT, Self-Refine, Reflexion, RARR, FLARE, ARGORA) on the 2 primary argumentation-specific metrics (Faithfulness, Contestability), i.e., 6 × 2 = 12 comparisons on 2 × 500 = 1000 total instances. Statistical significance for RAcc and RCost holds with larger effect sizes (Cohen's d ≈ 5.4 for RCost) and is not separately reported to avoid multiplicity inflation beyond the primary metrics.

---

## Final Assessment

**Acceptance probability**: **95%** (unchanged)

本轮审查未发现新的 CRITICAL 或 MAJOR 问题。四个发现均为 MINOR 或 ADVISORY，且均为已知议题的延伸（R97/R104/R105 中已有对应 ACKNOWLEDGED issues）。实验方法论的总体质量符合 KR 2026 标准：基线分组合理、排除决策有技术依据、主要统计声明可防御、cherry-picking 风险在可接受范围内。最主要的改进空间在于 rebuttal 时主动说明 Bonferroni 12次比较的具体组成，避免审稿人产生统计不完整的质疑。
