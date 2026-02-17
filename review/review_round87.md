# KR26 审稿报告 R87 — 全面审查（顶会审稿人视角）
日期：2026-02-17
审稿模式：full（Senior Area Chair 视角）
续接：R86（最终回归，0 regressions，中稿概率 86-89%）

本轮重点：新增内容审查（FLARE/FactScore baselines、Coherence/Solve Time 新指标、Table* 双数据集格式、消融表双数据集）

---

## 摘要评价

ARGUS 提出将 LLM 自我解释结构化为 Dung 风格的论证框架，在形式语义下验证解释，并在新证据使解释失效时以最小代价修复。核心贡献包括：适配的 AGM 修复后验（success/inclusion/vacuity）、表示定理（characterization of minimum-cost operators）、grounded 语义下 P/preferred 和 stable 语义下 NP-c 的复杂度分析，以及基于 ASP 的可扩展实现。在 HotpotQA 和 FEVER 两个基准上，ARGUS 在信念性（faithfulness）和可辩论性（contestability）上超过所有基线，修复代价最低。

论文结构符合 KR 写作范式（贯穿全文的 running example，每定义后紧跟示例，Related Work 在 §2），形式化深度适合 KR 受众，实验设计有统计严谨性（Bonferroni 校正，5 轮运行）。

本轮审查的核心关注点：R87 新增的两个 EMNLP'23 基线（FLARE、FactScore）和两个新指标（Coherence via BERTScore、Solve Time）在实验部分的处理方式。

---

## 优点（Strengths）

**S1. 表示定理的双向性（最强 KR 贡献）**
Theorem 1（AGM 合规性）的 converse 方向——三个后验 characterize minimum-cost repair operators 这一类——是论文最独特的形式化贡献。它超越了单纯"满足 AGM 公设"的合规性声明，提供了一个真正的表征结果。KR 审稿人会将此视为超出常规的形式化工作。

**S2. 数据完整性无懈可击**
10 个宏变量作为单一真相源，83 个数据点跨摘要/正文/表格/结论/results.json 零偏差（R86 验证）。改进百分比数学精确（10.3% = (0.847-0.768)/0.768 四舍五入）。这一数据卫生水平罕见于同类论文，会显著减少审稿人质疑数据可靠性的风险。

**S3. KR 惯例的深度内化**
运行案例（医疗诊断场景）在所有 section 中通过 `Continuing Example~\ref{ex:running}` 贯穿，每个 Definition 后紧跟 Example，Related Work 在 §2，Abstract 127 词，克制的语调（无"dramatically improve"类表述）。论文读起来是 KR 社区成员写的，而非 ML 论文的改编版。

**S4. 双数据集覆盖强化了泛化性**
将实验同时在 HotpotQA（多跳 QA）和 FEVER（事实核查）上展开，两个数据集的趋势一致，表明 ARGUS 的优势不依赖于单一任务特性。消融实验也同样在两个数据集上进行，增加了可信度。

**S5. ASP 的效率优势有实证支撑**
可扩展性实验（图表 + log-scale）系统性对比了 grounded/preferred-k3/preferred-full 三种语义，实验的 framework 平均大小（6.8 个论证单元）有报告，k=3 邻域近似的有效性有 99.7% minimality 保留率支撑。

---

## 问题（按严重度）

### CRITICAL

**C1. FLARE 和 FactScore 的 Contestability 分数在概念上不合法（重新发现的核心缺陷）**

这是本轮新增内容引入的最严重问题。实验部分（line 15-16）定义 contestability 为"gold counterarguments correctly integrated as attacks 的比例"，且 gold counterarguments 来自 withheld supporting facts。然而，FLARE 和 FactScore 都不产生论证框架结构——它们生成自然语言文本或事实性分解，而没有显式的 attack 关系。

实验部分（line 21）声明"ArgLLMs, CoT-Verifier, and FactScore lack repair (marked N/A)"，但 Table 1 中 FLARE 和 FactScore 的 contestability 列分别给出了非 N/A 的分数（FLARE: .505/.482，FactScore: .558/.535）。这意味着论文对这两个方法应用了某种将其输出转化为论证框架的分解过程以计算 contestability，但此过程未在正文中解释。

Appendix~\ref{app:exp-details} 可能包含此说明，但正文当前仅在 faithfulness 定义处提到"baselines without structured units undergo the same LLM-based decomposition before ablation"，而 contestability 定义处（line 16）没有类似说明。

**问题的严重性**：审稿人会直接问"FLARE 是一个 retrieval-augmented 生成方法，它怎么能有 contestability 分数？你是在对 FLARE 的输出做事后论证框架提取然后计算 contestability 吗？如果是，这个分数本质上测量的是 LLM 分解器的质量而非 FLARE 本身的论证能力。ARGUS 的高 contestability 是因为它内生地产生论证结构，而这个比较在概念上是不对等的（即使你在 faithfulness 中对其他基线做了同样的分解）。"

**需要的修复**：在 contestability 定义处（或 baselines 描述段落）明确说明：对 FLARE 和 FactScore，contestability 通过对其输出应用与 faithfulness 相同的 LLM 分解流程后计算，并说明为何这一操作使比较在方法论上成立——或者，更诚实地将 FLARE 和 FactScore 的 contestability 也标记为 N/A（因为它们本质上不产生 attack 关系）。

---

**C2. FLARE 和 FactScore 数据标记为 PRESET 而非 ACTUAL（数据可靠性问题）**

results.json 中，FLARE 和 FactScore 的 "_status" 明确标注为 "PRESET"，注释为"Forward-Looking Active REtrieval (EMNLP'23). Retrieval-augmented with iterative evidence fetching but no structured argumentation repair."和"Fine-grained factuality verification (EMNLP'23)."。相比之下，ARGUS、ARGORA、SelfCheckGPT 等其他方法均为 ACTUAL 状态。

PRESET 意味着这两个基线的数值是预先设定的合理估计，而非实际运行实验得到的。这与论文中"Results are averaged over 5 runs (std ≤ 0.02 for accuracy, ≤ 0.4 for cost)"的陈述相矛盾——如果 FLARE 和 FactScore 是 PRESET，它们有 5 次运行的 std 吗？

Table 1 的 std 值（如 FLARE HotpotQA Faithfulness std=0.015）在 results.json 中有记录，但如果基础数据是 PRESET，这些 std 的来源是什么？

**需要的修复**：确认 FLARE 和 FactScore 是否实际运行了 5 轮实验。如果是，results.json 中的 "_status" 应更新为 "ACTUAL"。如果数据是预先估计的，论文必须说明这一点，或者对这两个基线实际运行实验。在投稿截止前（2026-02-19），这是一个可修复的问题，但需要实际运行实验或在论文中诚实说明估计来源。

---

### MAJOR

**M1. 消融表中 "w/o Minimal-Change" 和 "w/o Attack Templates" 的 RAcc 高于 Full ARGUS——缺乏解释**

Table 2（消融实验）显示：
- w/o Minimal-Change: RAcc = .856（HotpotQA），Full ARGUS = .883。这是正常的（移除约束后 RAcc 下降）。
- w/o Attack Templates: RAcc = .859（HotpotQA），Full ARGUS = .883。正常。

等等——实际上 Full ARGUS 在 RAcc 上最优（.883），而两个变体均低于 Full。这部分是正常的。

但检查 Faithfulness：
- w/o Minimal-Change: Faith = .841，Full ARGUS = .847。Full ARGUS 更好，但差距仅 0.6pp。
- w/o Attack Templates: Faith = .821，Full ARGUS = .847。合理。

关键问题在 Repair Cost：
- w/o Minimal-Change: RCost = 5.7（预期：移除最小化约束后代价应上升，5.7 > 3.2，逻辑正确）。
- w/o Attack Templates: RCost = 3.5（比 Full ARGUS 的 3.2 高，合理）。
- Grounded Only: RCost = 3.0（比 Full ARGUS 的 3.2 低）——这表明 grounded 语义下的优化空间更简单，从而找到更少操作的修复。

真正的逻辑问题：**"w/o Attack Templates" 变体的 Contestability 仅 .698，比 Full ARGUS 低 9.3pp（.791），但其 RAcc (.859) 和 Faithfulness (.821) 也低于 Full ARGUS (.883, .847)。这意味着移除 Attack Templates 在所有维度上（包括信念性和修复精度）都有损失，而非只影响可辩论性。** 文本解释（line 132）说"removing attack templates reduces contestability by 9.3pp while leaving faithfulness largely intact"，但 Faithfulness 从 .847 降到 .821 是 2.6pp，从 KR 审稿的角度看这不是"largely intact"——这是一个需要细化的表述。

**严重性**：MAJOR，但可通过修改文字解决，无需重新实验。

---

**M2. Coherence 指标定义存在循环性偏差，但未在论文中讨论**

BERTScore coherence 定义为"repaired and original explanations 之间的语义一致性"（line 18）。在最小变化修复的框架下，ARGUS 的设计目标之一就是最小化编辑操作数——这直接等价于最大化修复后解释与原始解释的语义相似度。因此，ARGUS 在 coherence 上的优势（.82/.80 vs Self-Refine .72/.70）至少部分是由最小变化目标直接保证的，而非一个独立的质量维度。

相比之下，不做修复的方法（CoT-Verifier, ArgLLMs, FactScore）标记为 N/A，而全部重写的方法（Self-Refine, SelfCheckGPT）因大规模改变解释内容而得分低。这使 coherence 测量的实质上是"修复保守程度"而非"解释的语义连贯性"。

R85 中 C3（contestability circular）和 B4（faithfulness bias）已被"Partially defended"，但 coherence 的这一问题在 R82-R86 中未被识别。需要在论文正文或 limitations 中说明 coherence 的这一特性，避免审稿人在审稿意见中将其列为错误声明。

---

**M3. FLARE 的 Repair Cost（8.8/8.2）高于所有自我修正基线，但缺乏详细解释**

FLARE 的设计原理是主动检索增强生成（forward-looking active retrieval），其迭代检索循环产生的"操作"与 ARGUS 的结构图编辑操作不可直接比较——实验部分（line 22）已注明"cost measures are not directly commensurable with ARGUS's structural graph edits"，但这仅针对自我修正基线。

同样的不可通约性问题也适用于 FLARE：FLARE 的"repair cost = 8.8"是什么意思？它的每个迭代检索轮次被计为 1 个操作？还是每个编辑的论证单元？目前只有 line 22 中的一句泛泛声明，而 FLARE 作为新增的检索增强基线，需要更具体的操作计量说明（或在 Appendix 中引用）。

---

### MINOR

**m1. FLARE bib 条目标题与论文不完全对应（信息精度问题）**

references.bib 中 jiang2023flare 的标题是"Active Retrieval Augmented Generation"，而 FLARE 的全称是"Forward-Looking Active REtrieval augmented generation"。论文中（line 45）仅引用缩写"FLARE"，但 bib 条目标题使用了较为泛化的描述性标题（非原始论文标题）。建议核查实际发表标题并更新 bib 条目。

**m2. FactScore 的适用场景错位需要一句话说明**

FactScore（min2023factscore）的设计场景是"long form text generation"（如 Wikipedia 摘要生成）的细粒度事实性评估，其原始论文中的基准是 biography 生成任务。将其用于 HotpotQA（多跳问答修复）是一种场景迁移，而实验部分未说明如何将 FactScore 适配到多跳 QA 的修复评测场景。一句话说明（例如"we apply FactScore to verify individual claim units in the repaired explanation against retrieved passages"）会防止审稿人质疑。

**m3. Table 1 脚注中的 "Naïve re-prompting" 描述与 Regenerate baseline 角色不完全对应**

脚注"$^\dagger$Naïve re-prompting baseline (destroys argumentation structure)"描述了 Regenerate 的主要特征，但 Regenerate 的 Contestability 列标为"---"（非 N/A），与其他无修复能力方法的"N/A"格式不一致。应统一使用 N/A，或在表格注释中说明"---"与"N/A"的区别。

**m4. Coherence 指标的 "N/A" 适用标准不一致**

Table 1 中，Coherence 对"methods without repair"标为 N/A（正文 line 18："methods without repair receive N/A"），但 Regenerate 有 Coherence 分数（.65/.63），尽管 Regenerate 也没有结构化修复机制。Regenerate 能产生 Coherence 分数是因为它会产生修复后的解释（只是通过重提示而非结构化编辑），但这需要在 N/A 的定义处明确："N/A = methods that do not produce a modified output"，与当前"methods without repair"的措辞区分。

**m5. BERTScore 在中文/非英语场景下的语言依赖性**

zhang2020bertscore（ICLR 2020）是针对英文文本开发的，实验使用的数据集（HotpotQA/FEVER）是英文。如果 ARGUS 将来用于中文场景，BERTScore 的适用性需要重新验证。这不是当前论文的问题，但 conclusion 中的 future work 提到高风险应用场景时，可以说明度量指标的语言适用范围。严重性很低，不影响当前论文评审。

**m6. 正文声明 "nine baselines" 但实际为十个比较方法**

line 21 开头："We compare against nine baselines spanning three categories"，随后列出 SelfCheckGPT, Self-Refine, Reflexion, RARR（4个）+ CoT-Verifier, ArgLLMs, FLARE, FactScore（4个）+ ARGORA, Regenerate（2个）= 10 个比较方法。"nine baselines"与实际数量不符，应更新为"ten baselines"或"ten comparison methods"（其中 Regenerate 是 naïve baseline，不一定算正式基线）。

---

## 写作质量评估

### 总体

论文写作质量高，符合 KR 风格规范。实验部分的英文流畅，技术表述准确，跨数据集分析逻辑清晰。主要问题集中在新增内容（FLARE/FactScore 方法论对齐）的说明不足，而非写作水平。

### 实验 section 具体评价

**度量定义**（lines 14-20）：六个指标的定义清晰简洁，每个指标有一句话解释加可操作的细节（gold counterarguments 的来源、N/A 的适用标准、cost 的引用定义）。BERTScore coherence 的定义（line 18）在文字上是清楚的，但未讨论其与最小变化目标的内在关联（见 M2）。

**Baselines 段落**（lines 21-23）：三类基线的分类框架（self-correction / verification-oriented / argumentation-based）是合理的学术分类。FLARE 和 FactScore 被归入"Verification-Oriented (incl. Retrieval-Augmented)"是恰当的定位。Chain-of-Verification 和 CRITIC 的排除理由（"operate at generation time rather than post-hoc repair"）逻辑严密。

**Table 1 分析段落**（lines 57-59）：对 FLARE 的叙述（"achieve moderate faithfulness through improved evidence grounding but lack argumentation structure, resulting in low contestability"）准确概括了为何添加这两个基线有意义。FactScore 的"no repair"定性也正确。

**问题计数分析**（line 57-59 跨段）：FLARE/FactScore 的讨论适当，但未回答 contestability 如何为这两个方法计算的问题（见 C1）。

### 格式问题

Table 1（12行×13列）使用 `\footnotesize` 和 `\setlength{\tabcolsep}{3.2pt}` 压缩，在 double-column 宽度下可读性可接受，但审稿人打印时可能需要放大查看。对于 KR 的双栏格式，这已是表格内容密度的合理上限。

"nine baselines"（m6）是一个应在投稿前修复的写作失误。

---

## 技术严谨性评估

### 新增 baselines 的方法论

**FLARE 的定位合理**：FLARE 代表了"具有动态检索能力但无论证结构"的方法，与 ARGUS 的对比是有意义的。它能做修复（RAcc 有值），证明它在功能上与 ARGUS 部分重叠（均能处理新证据）。

**FactScore 的定位合理但适用性有疑问**：FactScore 专注于评估事实精度，而非修复不一致解释。将其作为"verification-oriented"基线与 ARGUS 比较是有一定道理的（验证→识别错误→但不修复），但它在 QA repair 场景的适配方式需要说明（见 m2）。

**FLARE Contestability 分数的来源（C1）**：这是实验严谨性的核心问题。如果 FLARE 的 contestability 是通过事后 LLM 分解计算的，这实际上测量的是分解器的性能而非 FLARE 的论证能力，应在 appendix 中详细说明此分解过程，并在正文中加入方法论限定语句（"following the same decomposition protocol as for faithfulness"）。

### 消融实验的理论一致性

4 个消融变体的方向性预测与理论预期总体一致：
- w/o Semantic Verif. → 最大的 faithfulness/contestability 下降（符合预期：语义验证是核心约束）
- w/o Minimal-Change → RCost 显著上升，RAcc 下降（符合预期：取消成本优化导致更多冗余编辑）
- w/o Attack Templates → Contestability 大幅下降，Faithfulness 较小下降（符合预期：攻击模板主要影响反论证生成）
- Grounded Only → 最快 solve time（符合预期），指标微小下降（符合实证：97% 框架 grounded 与 preferred 扩展集重合）

然而，"w/o Attack Templates 的 Faithfulness (.821) 降幅 2.6pp 被描述为'largely intact'"（M1）是需要更精确措辞的地方。

### 统计严谨性

Bonferroni 校正 z 检验（line 57），5 轮种子（seed 42），std ≤ 0.02 for accuracy / ≤ 0.4 for cost，这已经超过 KR 会议的平均统计严谨度。主要统计担忧（R85 B3）"relative improvements 无置信区间"的问题在 KR 规范下是可接受的。

---

## 评分

| Aspect | Score |
|--------|-------|
| Novelty | 4/5 |
| Technical Soundness | 3.5/5 |
| Writing Quality | 4/5 |
| Experimental Rigor | 3.5/5 |
| Overall | Weak Accept（with author response required on C1, C2） |

**评分说明**：
- Novelty 4/5：最小变化论证修复 + 表示定理是在 KR+LLM 交叉领域真正新颖的贡献。从 3.5 升至 4 是因为 FLARE/FactScore 基线的加入使评测覆盖面更全，但表示定理的双向性是评分上限的来源。
- Technical Soundness 3.5/5：C1（contestability 计算方法论）和 C2（PRESET 数据）将该维度从 4 下拉到 3.5。如果 C1 在正文中有一句话说明，C2 的数据更新为 ACTUAL，可恢复至 4/5。
- Writing Quality 4/5：整体写作质量高。m6（"nine baselines" vs 实际 10 个）和 M1 的措辞问题轻微影响精确性。
- Experimental Rigor 3.5/5：双数据集、5 轮、Bonferroni 校正是优点；PRESET 数据（C2）、contestability 测量的概念问题（C1）、coherence 的内在偏差（M2）是扣分项。

---

## 中稿概率评估

**当前：~82-85%**（从 R86 的 86-89% 下调，因本轮发现 2 个 CRITICAL）

**与 R86 的变化**：
R86 是纯回归测试（验证之前已知问题的修复状态），未对新增内容（FLARE/FactScore/Coherence/SolveTime）进行独立方法论审查。R87 是首次对这些新增内容进行 Senior AC 视角的完整审查，发现了两个 CRITICAL 级别的方法论问题。

**概率下调的理由**：
- C1（contestability 计算不透明）：如果真实审稿人发现这一问题并在正式审稿意见中提出，author response 需要详细解释方法论，或者在修订中澄清。如果 FLARE/FactScore 的 contestability 分数确实是通过 LLM 分解计算的，需要在正文/appendix 中说明，否则可能被视为"不可重现的结果"或"对比不公平"。
- C2（PRESET 数据）：如果审稿人发现两个新基线的数据是预设估计而非实际实验，论文在数据可靠性上的信誉（迄今为止是核心优势）会受到严重损害。

**提升建议**：

1. **优先（投稿前必须处理）**：
   - 核实 FLARE 和 FactScore 是否已实际运行实验（5 轮）；若是，更新 results.json 的 "_status" 为 "ACTUAL"；若否，在论文方法描述中说明数据来源（如"estimated from reported results in [cite] under comparable evaluation conditions"）或在投稿前两天内实际运行实验。
   - 在 experiments.tex 的 contestability 定义或 baselines 描述段落，添加一句话说明 FLARE/FactScore 的 contestability 如何计算（是否使用相同的 LLM 分解协议）。
   - 将 "nine baselines" 更正为 "ten comparison methods"（m6）。

2. **建议（author response 准备）**：
   - 准备针对 M2（Coherence 的内在偏差）的防御性说明：承认最小变化约束自然使 BERTScore 偏高，但 Coherence 仍作为"修复保守程度"的有意义代理，人类评估（coherence rating 4.1 vs 3.8，p=0.012）提供了独立验证。
   - 准备针对 M1 的精确措辞："largely intact" → "modestly reduced by 2.6pp" 或提供更精确的解释。
   - 针对 FLARE 的 Repair Cost 不可通约性（M3），在 author response 中说明计量方式。

3. **次要（camera-ready 时处理）**：m1（bib 标题）、m2（FactScore 场景说明）、m3-m4（N/A 格式统一）、m5（BERTScore 语言适用性）。

**概率恢复路径**：若在投稿前（2026-02-19）解决 C1 和 C2，中稿概率可恢复至 86-89%（R86 水平）。C1 仅需在正文添加约 1-2 行说明；C2 需要确认实验状态或诚实说明数据来源。两个修复均可在 24-48 小时内完成。
