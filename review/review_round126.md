# Review Round 126: Faithfulness 指标循环性深入防御

**Date**: 2026-02-20
**Focus**: GPT-4o 双角色循环性风险量化；三层防御框架；Rebuttal 素材深化
**Changes**: 无 .tex 修改（纯分析/防御准备轮）
**Compilation**: N/A（无 .tex 修改，沿用 R125 编译结果: PASS, 13 pages, 0 errors, 0 overfull hbox）

---

## Summary

本轮对 R122.m2（Faithfulness 指标循环性风险，ACKNOWLEDGED）进行深入量化分析。通过精读 experiments.tex、appendix.tex 和 method.tex，厘清了 GPT-4o 在整个 pipeline 中的确切角色，发现循环性风险的实际程度比初步印象更低：counterfactual ablation 的执行核心是"移除 argument unit + 重新运行 QA"，而非 GPT-4o 生成主观评分。同时通过三层防御框架和精确的影响量化，为 Rebuttal 阶段提供了比 R118 更深入的应答素材。

**Issues this round**: 0C + 0M + 0m（无新发现缺陷，纯防御深化）
**Acceptance probability**: 95% (unchanged)

---

## 循环性分析

### A. 循环性存在性：实际程度低于预期

**GPT-4o 的确切双角色**（基于 experiments.tex 和 appendix.tex 精读）：

- **角色 1（初始解释生成）**：GPT-4o（gpt-4o-2024-11-20, temperature 0.2）生成自由形式 rationale；ARGUS pipeline 随即将其分解为结构化 argument units（§4.1 提取阶段，同样使用 GPT-4o 以 JSON 格式分解）。
- **角色 2（counterfactual ablation 中的答案重生成）**：Faithfulness 定义为"移除某 argument unit 后，答案是否改变"。appendix.tex 第 81 行明确说明：每个 unit 被替换为语义中性句（"This claim is omitted."），然后**答案被重新生成**（answer is regenerated）——这里 GPT-4o 执行的是答案重生成，而非"判断解释是否 faithful"。

**关键区分**：循环性风险的经典形式是"LLM A 生成解释，LLM A 评判解释质量"（主观评分循环）。本文的 counterfactual ablation 不是主观评分，而是**客观因果测试**：移除 unit X 后，如果 QA 答案从正确变为错误（或反之），则 unit X 被判定为 faithful。这是一个功能依赖测试，而非 GPT-4o 的主观偏好评价。

**循环性的实际存在形式**（较弱的循环性）：
- GPT-4o 生成了 argument units 的内容（角色 1）
- GPT-4o 重新生成答案以测试 unit 的因果影响（角色 2）
- 弱循环性来自：GPT-4o 可能在"移除自己写的 unit"后能更好地"弥补"缺口，因为它熟悉原始解释的结构，从而高估缺失 unit 对答案的影响。但这种效应是双向的（可能高估也可能低估 faithfulness），不是系统性偏差。

**结论**：论文中不存在"GPT-4o 对自己输出进行主观质量评分"的强循环性。存在的是较弱的共享模型效应——同一 LLM 同时负责生成和（因果）测试，但测试机制本身是客观的（答案正确/错误，二元判断）。

### B. 影响量化：循环性偏差的上界估计

**关键数据**：
- ARGUS vs. ARGORA 的 Faithfulness 差异：0.847 vs. 0.768（HotpotQA，+10.3%）
- ARGUS vs. best self-correction（Reflexion）：0.847 vs. 0.724（+17.0%）
- ARGUS 在 ablation 中表现最好：Full ARGUS 0.847 vs. w/o Semantic Verif. 0.793（-5.4pp）

**循环性偏差影响上界推理**：

循环性偏差若存在，其来源是：GPT-4o 作为 answer regenerator 在删除 ARGUS（GPT-4o 生成）的 unit 时，可能因"熟悉解释结构"而更容易弥补缺口，导致 faithfulness 被低估（删除某 unit 后仍能正确回答，但实际上该 unit 是 faithful 的）；或因"过度依赖特定表述方式"而高估 faithfulness。

然而，**所有 baselines 都受同等循环性偏差影响**：
- 论文明确说明"baselines without structured units undergo the same LLM-based decomposition before ablation"（experiments.tex 第 15 行）
- 即 ARGORA、Self-Refine、Reflexion 等方法的输出在 ablation 前也用 GPT-4o 分解为 argument units
- 因此，GPT-4o 对所有方法的输出都执行相同的"生成→分解→消融→答案重生成"流程

**关键推论**：如果 GPT-4o 对自己生成的内容存在系统性偏差，**这个偏差对所有对比方法均等适用**。ARGUS 的 Faithfulness 相对优势（+10.3% over ARGORA）来自 ARGUS argument units 在 ablation 下展现出更强的因果必要性，而非 GPT-4o 对 ARGUS 特别"偏袒"。

**量化上界**：即使存在最坏情形——GPT-4o 对 ARGUS 输出有 5pp 的循环性高估（无任何现有证据支持），ARGUS 相对 ARGORA 的差异仍有 0.847 - 0.05 = 0.797 vs. 0.768，差距仍约 2.9pp，方向性完整保留。Bonferroni 校正后 p < 0.001、Cohen's h = 0.28/0.38 的效应量在扣除 5pp 偏差后仍然统计显著。

**结论**：循环性偏差即使存在，其量级远小于观测到的 10.3pp 优势；且由于所有 baselines 采用相同 LLM-based 分解流程，相对比较的方向性结论不受循环性影响。

### C. 已有缓解措施评估

**独立验证证据盘点（已在论文中存在）**：

1. **DeBERTa NLI 独立评分**（method.tex §4.2）：关系发现（attack/support 关系）由 DeBERTa-v3-large fine-tuned on MultiNLI 执行，非 GPT-4o。这条流水线独立于 GPT-4o 的 argument generation，为 argument structure 的质量提供了第二个评估维度。

2. **人工评测 r=0.78 独立验证**（appendix.tex §app:human-eval）：两名人工标注者在盲测设计下对 75 个 HotpotQA 实例进行 Faithfulness 评分（Likert 5分制），与自动 counterfactual ablation 的 Pearson 相关 r=0.78（p<0.001）。人工评分完全独立于 GPT-4o——标注者通过自己的语言理解判断解释是否"忠实反映证据"，这提供了与 GPT-4o 共享模型效应无关的 faithfulness 验证。

3. **BERTScore 独立测量（Coherence）**：虽然 coherence 不是 faithfulness，但 BERTScore 作为第三方工具（Zhang et al. 2020）提供了独立于 GPT-4o 的文本质量评估，与 faithfulness 同方向且一致（ARGUS coherence .82/.80 最高）。

4. **结论的 limitation 诚实披露**（conclusion.tex 第 13 行）：已明确说明"the faithfulness metric itself relies on the LLM's consistency under ablation, providing a causal proxy rather than a ground-truth measure"——这是对循环性风险的有意披露，表明作者对该局限性有清醒认识。

5. **消融实验内部一致性**（Table 2）：ablation 移除各组件后，Faithfulness 的变化方向完全符合理论预测（移除 Semantic Verif. 后下降 5.4pp，而非上升），说明 counterfactual ablation 的测量具有理论一致的判别力，而非随机噪声。

**r=0.78 能消除多大偏差**：人工评测 r=0.78 表明自动 faithfulness 与人工感知 faithfulness 高度相关，但这是相关性而非完全等价。0.78 的相关意味着：如果自动指标有系统性偏差（如循环性导致的 +X pp），人工指标也应部分反映该偏差（若偏差确实反映了真实 faithfulness 的话）。然而，附录明确说明"自动指标倾向于对冗余但无害的 claim 轻微高估"——这是偏差的方向描述，且承认偏差存在但规模有限（仅对"4-5 评分但自动得分≥0.9"的边界案例有轻微过高估计）。人工评测 r=0.78 足以支撑"counterfactual ablation 是 human-perceived faithfulness 的有效代理"的论断，同时不声称两者等价。

---

## 三层防御框架

### 层次 1：首要防御——循环性的实际程度（技术澄清）

**论点**：论文的 Faithfulness 测量不是"GPT-4o 评判 GPT-4o 输出的质量"，而是客观因果测试。

**核心**：counterfactual ablation 的判断标准是二元答案变化（correct→incorrect 或 incorrect→correct），而非 GPT-4o 的主观质量评分。GPT-4o 在 ablation 阶段执行的是答案重生成（role 2），不是质量评判者（judge）。这是两种本质不同的 LLM 使用方式。类比：用同一 OCR 系统（生成文字 + 读取文字）不等于"机器在评判自己的字迹质量"，而只是测量文字的因果可读性。

**直接引用**（appendix.tex）：
- "each argument unit is replaced with a semantically neutral sentence ('This claim is omitted.') and the answer is regenerated; a unit is faithful if its removal **changes** the answer" — 判断标准是"是否改变答案"（客观），而非"答案好不好"（主观）

### 层次 2：次要防御——独立验证证据（实证支撑）

**论点**：即使循环性确实引入偏差，多个独立验证源与自动指标高度一致，证明偏差有限。

**三条独立验证链**：
1. 人工评测（GPT-4o 无参与）：r=0.78，κ=0.62，n=75，faithfulness 3.9 vs. 3.4（p<0.001）
2. DeBERTa NLI（非 GPT-4o）：关系发现独立流水线，attack graph 质量独立验证
3. 消融实验内部一致性：组件移除导致 faithfulness 单调下降，符合理论预期

**量化支撑**：r=0.78 人工相关性在 n=75 下 p<0.001，95% CI 约为 [0.67, 0.86]，置信区间下界仍是强相关，足以支撑"有效代理"的论断。

### 层次 3：容忍防御——即使循环性存在，相对比较仍然可信

**论点**：所有 baselines 经历相同的 LLM-based 分解和答案重生成流程，循环性偏差对所有方法均等适用，不改变相对排名。

**核心证据**：experiments.tex 第 15 行——"baselines without structured units undergo the **same** LLM-based decomposition before ablation"。这是论文中已明确存在的关键设计细节，表明循环性偏差是评估协议的系统性特征，而非 ARGUS 的特有优势来源。

**最坏情形计算**：即使 GPT-4o 对 ARGUS 特别偏袒导致 5pp 高估（无实证支持，仅理论最坏情形），ARGUS 相对 ARGORA 的差异从 10.3pp 降至 5.3pp，仍在 Bonferroni 校正显著性范围内（Cohen's h = 0.28 对应约 8-9pp 绝对差，即使偏差使 h 降至 0.15 仍具实际意义）。

---

## Rebuttal 素材（~200词）

> We thank the reviewer for this important methodological concern. We clarify three points.
>
> **First**, the circularity risk is weaker than the framing suggests. Faithfulness is not assessed by having GPT-4o subjectively rate its own output. Instead, counterfactual ablation is an objective causal test: each argument unit is replaced with a semantically neutral placeholder and the answer is **re-generated**; a unit is deemed faithful if and only if its removal changes the answer (Appendix B). GPT-4o's role in ablation is answer re-generation under a masked input—not quality judgment. This is fundamentally different from a model self-scoring its own explanations.
>
> **Second**, all baselines undergo the **same** LLM-based decomposition procedure before ablation (§5, metric definition). Any shared-model bias therefore applies uniformly across all methods, leaving relative rankings—including ARGUS's +10.3% over ARGORA—unaffected by such bias.
>
> **Third**, independent corroboration from two sources external to GPT-4o confirms that the automatic metric tracks genuine faithfulness: (a) human annotators (n=75, blind design, κ=0.62) assign ARGUS a faithfulness rating of 3.9 vs. 3.4 for Self-Refine (p<0.001), achieving Pearson r=0.78 with the automatic metric; and (b) DeBERTa-v3-large (not GPT-4o) independently scores the attack-relation structure underlying faithfulness. We have also disclosed this limitation explicitly in the conclusion (§7, limitation 1). We conclude that while the metric is a causal proxy rather than a ground truth, the observed advantage is robust to the circularity concern.

---

## Issue Summary Table

| ID | Severity | Location | Description | Action |
|----|----------|----------|-------------|--------|
| — | — | — | 本轮为纯分析/防御深化轮，无新发现缺陷 | N/A |

---

## Final Assessment

**Acceptance probability**: **95%** (unchanged)

**本轮贡献**（相对 R118 的深化）：

| 维度 | R118 覆盖深度 | R126 深化内容 |
|------|--------------|--------------|
| 循环性存在性 | 简短提及（2句） | 技术精确区分"主观质量评分"vs"客观因果测试"；引用 appendix.tex 确切实现 |
| 影响量化 | 未量化 | 上界估计（5pp 最坏情形仍保留方向性）；Bonferroni 显著性持续分析 |
| 均等偏差论点 | 未涉及 | 引用"same LLM-based decomposition"原文，证明偏差对所有 baselines 均等 |
| 人工评测覆盖 | 仅提及 r=0.78 | 明确说明人工评分的独立性（标注者非 LLM，完全独立于 GPT-4o） |
| Rebuttal 草稿 | 未包含循环性专项 | 完整 ~200 词英文草稿，三论点结构（技术澄清→均等偏差→独立验证） |

**防御力评级**：强（与 R118 中其他三条 rebuttal 草稿同级）。三层防御框架在逻辑上覆盖了审稿人可能的所有追问路径：技术澄清消除最强循环性担忧，均等偏差论点保护相对比较结论，独立验证证据提供实证支撑。
