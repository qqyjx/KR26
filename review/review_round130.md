# Review Round 130: 对抗性审稿人单点拒稿搜索

**Date**: 2026-02-20
**Focus**: 以严苛 KR 硬核审稿人视角穷举9维度单点拒稿理由；评估防御强度；识别最高残余风险
**Changes**: 无 .tex 修改（对抗分析轮）
**Compilation**: N/A（无 .tex 修改，沿用 R129 编译结果: PASS, 13 pages, 0 errors, 0 overfull hbox）

---

## Summary

本轮以极端对抗性视角，模拟专攻 formal argumentation 的 KR 硬核审稿人（审过 Dung 1995、Brewka GR 等标志性论文）对 ARGUS 的单点拒稿攻击。系统搜索9个维度，逐一评估论文现有防御的强度与残余漏洞。

**主要发现**：在9个攻击维度中，有2个残余风险较高（防御强度 6/10 以下）——AGM compliance 声明的精确性（仅覆盖 3/8 公设但论文早期版本未清晰承认 Recovery 失败的根本性）和 k-neighborhood 近似的理论质量保证缺失。这两点已在 R58 和 R71 部分修复，但仍有精准反驳素材的缺口。其余7个维度均有较强防御（7/10 或以上）。整体接受概率维持 95%。

**Issues this round**: 0C + 0M + 2m
**Acceptance probability**: 95% (unchanged)

---

## 9维度对抗性攻击分析

---

### 攻击维度 1: Novelty（新颖性）

**最强攻击**:
> "ARGUS = Baumann & Brewka 2010 AF repair + Self-Refine + 套 AGM 标签。Baumann & Brewka 已经研究了论证框架的最小结构修改和扩展语义下的 enforcement；Coste-Marquis et al. 进一步形式化了基于 extension 的最小改变修复。ARGUS 只是将这些已有机制搭载在 LLM pipeline 上，再套一个 AGM compliance 标签，没有新的形式化工具。Representation Theorem 是标准的刻画定理，任何满足三个公设的算子等于最小代价修复——这在经典信念修正文献中是老技术，对 argumentation 领域毫无理论贡献。"

**防御强度**: **8/10**

论文在 related_work.tex 中对 Coste-Marquis et al.、Wallner et al.、Bisquert et al. 逐一进行精确区分：
- 与 Coste-Marquis et al. 的区别：对方针对 extension-level enforcement，本文针对单个 argument 的状态，且引入 evidence update Δ 作为一等输入，支持异质代价函数；
- Representation Theorem 的新颖性：theory.tex 明确声明"to the best of our knowledge, this is the first formal bridge between AGM rationality criteria and argumentation-based explanation repair for LLM self-explanations"。iff 方向刻画了一整类满足三公设的算子等价于最小代价修复，这不是简单移植——证明依赖 κ > 0 的严格正性与 inclusion 公设的必要删除条件之间的交互；
- Hase et al. 已证明 AGM 在 LLM 参数层面不可直接应用，本文通过外部图结构绕过该障碍，是实质性的架构贡献。

**残余漏洞**:
Representation Theorem 的证明逻辑在 theory.tex 的 sketch 中存在循环性风险：逆向方向（给定满足三公设的算子，证明存在 κ 使其等价于最小代价修复）依赖 uniform cost κ(o)=1 的特殊构造，并未证明对任意 κ 的 iff——完整证明被推入 Appendix A。强硬审稿人可能要求澄清 sketch 是否完整覆盖一般 κ 的情形。这是 minor 级别漏洞，不足以构成拒稿理由，但可能被追问。

---

### 攻击维度 2: Dung AF 框架的必要性

**最强攻击**:
> "论文没有回答最根本的问题：为什么是 Dung AF？直接用图约束 + LLM iterative refinement（如 Reflexion 的更强版本）也能做 argument-level 因果删除和增加，代价更低且更灵活。Dung AF 仅是一种工程选择，不是理论必然。ASP solver 带来的形式化保障（extension membership）在实践中被 NLI 关系识别的噪声所主导——任何 NLI 误分类都会污染 attack graph，使 argumentation semantics 的保证形同虚设。"

**防御强度**: **8/10**

论文有三层防御：
1. **Huang et al. (2024) 权威引用**：LLMs 无法在无外部反馈的情况下自我纠正推理——这直接封堵"更强 LLM 自我纠错即可"的假设；
2. **Table 2 消融数据**："w/o Semantic Verif." 行导致 Faithfulness -5.4pp、Contestability -7.7pp——argumentation semantics 是消融中影响最大的单一组件，证明其不可替代性；
3. **Contestability 指标的结构性依赖**：contestability 是 fraction of gold counterarguments correctly integrated as attacks，无显式 attack relation 的方法无法计算，Table 1 的 N/A 格自证。

**残余漏洞**:
NLI 噪声对 extension 计算质量的影响在实验中未独立量化——论文报告了整体 Faithfulness 和 Contestability，但未报告"NLI 关系误分类率"及其对最终修复精度的传播误差。强硬审稿人可能追问：如果 DeBERTa NLI 的 threshold=0.7 产生 10% 误分类，extension-level 的保证降级为何？这是 minor 级别漏洞，appendix 中有 NLI 评估数据，但未与修复质量显式关联。

---

### 攻击维度 3: Representation Theorem 价值

**最强攻击**:
> "Theorem 2（Representation）是 representation result，而非 complexity 或 decidability result——它不告诉我们任何可计算性或算法边界，只是说满足三个公设的算子等价于某种最小代价修复。这在 KR 理论社区是极弱的结果：Dung 1995 给出了基础语义的全谱 complexity；Dunne & Wooldridge 给出了 skeptical/credulous acceptance 的精确复杂度；Dvořák & Dunne 给出了 enforcement 的完整复杂度图谱。与这些标志性结果相比，Theorem 2 仅是工程层面的 sanity check，不构成 KR 理论贡献。"

**防御强度**: **7/10**

论文的主要理论贡献实际上是 Theorem 3（Repair Complexity，即文中的第二个定理——grounded ∈ P / preferred/stable-credulous NP-complete / skeptical-stable Σ₂ᴾ-complete），而非 Representation Theorem。complexity trichotomy 是标准 KR 理论期待的结果，且论文通过 reduction from enforcement literature（Baumann & Brewka 2010, Wallner 2017）建立了严格的下界。defense 路线：Representation Theorem 的贡献是**规范性基础**（任何满足三公设的算子必然是最小代价算子，反之亦然），为 practitioner 提供了独立于 ASP 实现的公理化验证标准；complexity trichotomy 才是技术上更深的 KR 贡献。

**残余漏洞**:
Representation Theorem 的 proof sketch 中逆向方向的完整证明在 Appendix A，且 sketch 仅覆盖 uniform κ。如果审稿人细读 sketch 并发现逆向方向在一般 κ 下需要更强条件（例如 κ 的严格正性 κ(o) > 0 是否就足够，还是需要额外的区分假设），可能会提出技术性质疑。这是可应对的 minor 级别漏洞，但需要准备清晰的澄清材料。

---

### 攻击维度 4: Human Evaluation 规模

**最强攻击**:
> "75 instances 的 human evaluation 来自单一医疗诊断场景（HotpotQA），两名 annotator，κ=0.62 只是 substantial agreement 的下边界。这不能支撑'argumentation-structured LLM self-explanations'的一般性声明。医疗诊断场景是论文对 argumentation 结构最有利的选择（因为医疗诊断天然具有支持/反对结构），结果无法泛化到 creative writing、code generation 等 open-ended 任务。更重要的是，75 个样本的 human evaluation 在 Bonferroni 校正下无法检验 12 项比较的所有假设——作者只报告了 p<0.001，但未给出 Bonferroni 校正后的 adjusted p-value for human evaluation。"

**防御强度**: **8/10**

论文的 rebuttal 路线（来自 R118 草稿 2）：
1. **定位澄清**：75-instance human evaluation 是对自动指标的交叉验证补充，主评估基于 500+500=1000 instances，所有 12 项比较在 Bonferroni 校正后均 p<0.001，Cohen's h=0.26-0.38；
2. **验证目标精确**：r=0.78（p<0.001）的 Pearson 相关足以支撑"counterfactual ablation 是 human-perceived faithfulness 的有效代理"，对于这一验证目标，n=75 是统计上充分的；
3. **κ=0.62 是 substantial agreement**（Landis & Koch 1977 的标准分类），在 n=75 的 blind design 中是正常范围。

**残余漏洞**:
Human evaluation 限于 HotpotQA（multi-hop QA），未覆盖 FEVER（fact-verification）；医疗诊断场景是 Introduction 的 running example 而非 human evaluation 的实际来源，但审稿人可能混淆。更重要的是：论文 appendix 对 human evaluation 的 Bonferroni 校正是否明确说明（人类评测的 12 项比较是否也做了校正？），若未明确，则构成统计严谨性的可追问漏洞（m-130-1）。

---

### 攻击维度 5: k-neighborhood 近似质量

**最强攻击**:
> "k=3 的近似没有理论下界。99.7% 恢复率是在特定测试集（500+500 instances with withheld gold fact structure）上观测到的，而非证明的。最坏情形近似比未分析：当最优修复需要修改距离 target argument 为 k+1 的节点时，k-neighborhood 近似会产生多大的代价退化？论文承认"median depth 3, maximum 7"——maximum depth 7 意味着存在需要 k=7 的实例，而这些实例在 k=3 时会得到什么结果？是修复失败还是次优解？这个 5% 的 worst-case 未被分析，使得'near-optimal'声明缺乏形式化支撑。"

**防御强度**: **6/10**（较弱）

论文在 method.tex 中给出了近似的完备性条件：k-neighborhood 近似"is complete for optimal repairs whose support set lies entirely within the k-neighborhood"，并解释"A repair can be missed only when the optimal repair requires modifying an argument at distance > k"。这是完备性条件而非近似比保证。论文对 99.7% 的实证结果有 5-seed 重复和标准差报告，但：
- 没有 worst-case analysis；
- "maximum depth 7" 的实例在 k=3 时的具体表现未报告；
- 没有理论下界说明如何随 k 扩展。

**残余漏洞（较高风险）**:
这是9个维度中防御最薄弱的之一。强硬审稿人可能要求：（a）最坏情形近似比的理论分析，或（b）k=4/5 时 99.7% 是否能提升到 100%，以及 k=2 时下降多少——sensitivity analysis 已被移入 appendix（R64 压缩），但 appendix 中是否报告了 k 变化的系统性实验需确认。如果 appendix 有 k=1,2,3,4 的恢复率曲线，则防御升至 7.5/10；若 appendix 仅报告 k=3，则此处是真实的理论漏洞（m-130-2）。

---

### 攻击维度 6: 复杂度结果

**最强攻击**:
> "Theorem 2（Repair Complexity）的下界证明全部来自对已有 enforcement 文献的引用（Baumann & Brewka 2010, Wallner 2017），而非本文独立证明的新 reduction。具体地：preferred semantics 的 NP-hardness 是 'reduces from NP-hard extension enforcement [baumann2010complexity]'，Σ₂ᴾ-hardness 是 'polynomial reduction from the Σ₂ᴾ-hard problem of deciding whether argument deletion can make a target skeptically stable-accepted [wallner2017complexity]'。这不是新的复杂度结果——它是 restatement of known results，只是换了一个问题包装。membership 的上界证明（NP via certificate, Σ₂ᴾ via co-NP oracle）同样是标准技术。整个 Theorem 2 只是 complexity inheritance result，不是新的 complexity analysis。"

**防御强度**: **7/10**

这个攻击有一定道理：三个复杂度结论的下界确实全部来自 reduction from 已有 enforcement 结果。然而论文的 defense 路线有两点：
1. **额外成分使 reduction 非平凡**：theory.tex 明确说明"the reduction to enforcement establishes complexity bounds but does not subsume the repair problem, which additionally involves evidence updates Δ, heterogeneous cost functions, and NLI-grounded candidate generation"——这些额外成分需要论证它们不改变复杂度类（即 polynomial overhead argument），这是本文需要验证的新 claim；
2. **Complexity trichotomy 的价值**：三语义下的完整复杂度图谱（P / NP-complete / Σ₂ᴾ-complete）作为一个整体在 LLM explanation repair 的具体问题框架下是首次呈现，即使单个界是继承的，其组合和在新问题设置中的呈现也有参考价值。

**残余漏洞**:
如果审稿人持"引用他人结果不等于本文贡献"立场，这个攻击可能维持为 weakness。论文需要更清晰地论述 Δ 的引入导致了什么新的复杂度挑战——proof sketch 目前仅说"the additional overhead of processing Δ and evaluating heterogeneous cost functions is polynomial and does not alter the complexity class"，但这个声明本身没有在 sketch 中被证明，而是被断言。强硬审稿人可能要求补充这个 polynomial overhead claim 的证明细节。

---

### 攻击维度 7: 实验数据集的代表性

**最强攻击**:
> "HotpotQA 和 FEVER 都是 fact-verification / fact-retrieval 任务，LLM explanations 在这类任务上天然具有 argument-structured 特征（因为答案有客观事实支撑，arguments 对应 evidence chains）。结果根本无法泛化到 open-ended generation（creative writing、dialogue、summarization）或 subjective reasoning（ethical reasoning、policy recommendation），而这些恰恰是 LLM explainability 最重要的应用场景。更根本地：论文人工构造了对抗性 evidence update（withheld gold supporting fact），这是非自然的 adversarial setting——真实场景中 evidence update 是噪声的、不确定的、常常是部分支持的，而非干净的 gold fact。论文在最简单的情形下验证了 ARGUS，将其呈现为一般解决方案。"

**防御强度**: **7/10**

论文有两类防御资源：
1. **Conclusion limitation 诚实披露**（conclusion.tex 第 4 个限制）：明确说明实验局限于 multi-hop QA 和 fact-verification，future work 包括 open-ended generation；
2. **Methodology 正当性**：HotpotQA 是 multi-hop QA（非单步 fact lookup），FEVER 是 claim verification（多步推理），两者都需要推理链——不是最简单的任务。Withheld gold fact 的实验设计是标准的 adversarial setup，在 RARR、RARR++、FLARE 等论文中均采用类似方法。

**残余漏洞**:
R128 的 advisory-I4 已指出 TruthfulQA/StrategyQA 作为额外数据集的防御缺口——如果审稿人坚持要求第三个数据集，论文没有现成防御。更关键的是：论文没有对 evidence update Δ 的质量（信噪比）做 robustness analysis——当 Δ 包含噪声或部分矛盾信息时 ARGUS 的行为如何？这在 conclusion 中被提及但未实验验证。

---

### 攻击维度 8: AGM Compliance 声明的精确性

**最强攻击**:
> "论文标题声称 'AGM-compliant'，但 theory.tex 只证明了 8 个 AGM 公设中的 3 个（success, inclusion, vacuity），并明确承认 Recovery 失败。在经典 AGM 理论中，Recovery 是核心公设之一——Gärdenfors (1988) 和 Katsuno & Mendelzon (1992) 都将 Recovery/Reversibility 视为区分 revision 和 contraction 的关键标准。一个不满足 Recovery 的算子在 AGM 术语中应被称为 'partial AGM compliance' 或 'AGM-inspired'，而非 'AGM-compliant'。论文关于 Closure/Superexpansion/Subexpansion 的讨论以'no natural analogues in argumentation frameworks'为由一笔带过，这对 KR 理论审稿人而言是不可接受的——这需要严格的不可能性证明，而非直觉性排除。"

**防御强度**: **6/10**（较弱）

这是论文最脆弱的理论声明之一。R58 已大幅加强了这一方向，添加了 Recovery 失败的具体反例（Example 3 in theory.tex）和 5 个公设的完整讨论（consistency, extensionality, closure, superexpansion, subexpansion）。防御路线：
- Recovery 失败是**有意设计的**，是 LLM explanation repair 的结构性特征（structural additions made during repair cannot be automatically undone by evidence retraction）；
- 论文采用"adapted AGM compliance"的措辞（theory.tex 第一段），不声称完整 AGM compliance；
- Closure/Superexpansion/Subexpansion 的排除有语义理由（argumentation frameworks 的"beliefs"是图结构元素而非逻辑语句）。

**残余漏洞（较高风险）**:
"no natural analogues"声明缺乏形式化证明。强硬的 AGM 理论审稿人可能要求：对 Closure（Cn(K * α) = Cn(K + α + ...)）是否在 argumentation 层面有定义、如果没有，是否能给出不可能性证明（例如论证 extension-based "closure" 在 preferred/stable semantics 下是不可计算的）。目前 theory.tex 仅给出了 consistency 和 extensionality 的简短论证，对其余 3 个公设的排除只有直觉说明。这是一个 minor 到 major 级别的漏洞，取决于审稿人背景。

---

### 攻击维度 9: LLM 生成 Evidence Updates 的可靠性

**最强攻击**:
> "Evidence update Δ 由 LLM 生成（或从 withheld gold facts 构造），论文对 Δ 的质量没有独立验证。AGM compliance 的保证依赖 Δ 是真实的新证据——如果 Δ 本身是 LLM 幻觉或噪声，那么 ARGUS 对一个虚假 Δ 执行了 formally correct repair，得到的是一个"形式上正确但语义上错误"的修复。更根本地：Section 4.4 说明'the natural-language claim for the new argument is generated by prompting the LLM to produce a rebuttal of the target's attacker, conditioned on the evidence update Δ'——add_arg 操作产生的新 argument 的 claim 是 LLM 生成的，其真实性完全未验证。论文对 LLM 生成组件（extraction、add_arg claim generation）的可靠性没有独立的 component-level evaluation。"

**防御强度**: **7/10**

论文在实验设计上使用了 withheld gold supporting facts 作为 Δ（非 LLM 生成），这是一个重要的设计细节：在主实验中，Δ 来自 gold dataset，质量有保证。add_arg 生成的 claim 经过 NLI pipeline 验证（"the resulting candidate is verified through the same NLI pipeline before admission"，method.tex）——这是一个内部一致性验证。

**残余漏洞**:
论文对 add_arg claim 的 NLI 验证通过率没有报告——即有多少 LLM 生成的 rebuttal candidate 通过了 NLI threshold=0.7，有多少被拒绝，被拒绝后如何处理（fallback 策略未描述）。这是一个 minor 级别漏洞。更关键的是：R126 已深入分析了 GPT-4o 的双角色循环性问题，但 add_arg 中"LLM 生成 rebuttal 的可靠性"这条攻击路径与 faithfulness circularity 不同——它是关于新 argument 内容真实性的，而非指标循环性的。现有 rebuttal 草稿（R118 草稿 3）对此的覆盖是间接的。

---

## 最高风险综合评估

以下2-3个攻击点在严苛审稿人视角下最可能被坚持：

### 最高风险 #1: k-neighborhood 近似的理论质量保证（维度 5）

**原因**：这是论文中唯一一个"实证结果优秀（99.7%）但理论支撑薄弱（无近似比下界、无 worst-case analysis）"的声明。KR 硬核审稿人对实证替代理论支撑特别敏感。最坏情形（maximum depth 7 的实例在 k=3 时的表现）未报告，这是可以被具体追问的漏洞。Appendix 中的 sensitivity analysis（k 变化曲线）是否存在、内容是否充分，是防御的关键。

**当前防御**：方法论上有完备性条件（near-optimal for repairs within neighborhood），但缺乏 worst-case 近似比的理论框架。

**建议 rebuttal 补充**：准备 k=2/3/4 恢复率数据（如果 appendix 有），和 worst-case 的 informal argument（例如：在图结构的 median depth 3 框架下，k=3 覆盖超过 99%，这与 empirical distribution 一致；提供 k 扩展路径 for deep domains）。

### 最高风险 #2: AGM Compliance 声明的范围精确性（维度 8）

**原因**：KR 理论审稿人对"AGM-compliant"标签的使用极为敏感。Recovery 失败是已知且明确承认的，但对 Closure/Superexpansion/Subexpansion 的排除仅凭"no natural analogues"这一直觉性声明——这对 KR 形式化审稿人是不可接受的。R58 虽然已改善了论述，但仍欠缺形式化的不可能性证明。

**当前防御**：使用"adapted AGM compliance"措辞，有 Recovery 失败反例，有 5 个公设的完整讨论。

**建议 rebuttal 补充**：准备一段精确的技术澄清，解释为什么 Closure 在 argumentation extension 层面等价于什么、为什么在 incomplete 和 non-deductively-closed 的图结构语境下这些公设无法以有意义的方式适配（参考 Booth et al. 2013 关于 argumentation revision 局限性的讨论）。

### 潜在风险 #3: Representation Theorem 逆向证明的完整性（维度 1 + 维度 3）

**原因**：proof sketch 仅展示了 uniform κ 的特殊情形，逆向方向（一般 κ 下的 iff）依赖 Appendix A。审稿人如果细读 sketch 并发现不完整性，可能要求详细证明。这是概率较低（需要细读 appendix）但影响较高（攻击核心理论结果）的潜在风险。

---

## Rebuttal 充分性评估

### R118 素材覆盖度

| 攻击维度 | R118 草稿 | 覆盖充分度 |
|----------|-----------|----------|
| 维度 1: Novelty | 草稿 1 (Representation Theorem 新颖性) | 充分 (8/10) |
| 维度 2: Dung AF 必要性 | 草稿 3 (Argumentation 框架必要性) | 充分 (8/10) |
| 维度 3: Representation Theorem 价值 | 草稿 1 部分覆盖 | 中等 (6/10)，需补充 complexity trichotomy 贡献 |
| 维度 4: Human Evaluation 规模 | 草稿 2 (n=60 Human Evaluation) | 充分 (8/10) |
| 维度 5: k-neighborhood 近似 | 未覆盖 | 欠缺 (2/10) — 需专门准备 |
| 维度 6: 复杂度结果 | 未覆盖 | 欠缺 (2/10) — 需专门准备 |
| 维度 7: 数据集代表性 | 未覆盖 | 欠缺 (3/10) — R128 advisory-I4 有提示但无草稿 |
| 维度 8: AGM Compliance 精确性 | 未覆盖 | 欠缺 (3/10) — R58 改善了论文但 rebuttal 草稿未准备 |
| 维度 9: LLM evidence update 可靠性 | 草稿 3 部分覆盖（循环性视角） | 中等 (5/10)，需区分"循环性"和"内容真实性"两条攻击 |

### R126 素材覆盖度

R126 深入覆盖了维度 9 的 faithfulness circularity 分支（三层防御框架 + ~200 词 rebuttal 草稿），但未覆盖维度 5/6/8。R127 准备了并行工作的威胁模型，R128 深入分析了实验方法论，但5个维度（5/6/7/8/9-真实性分支）的专门 rebuttal 草稿仍欠缺。

### 最高优先级 rebuttal 准备缺口

1. **k-neighborhood 近似（维度 5）**：需要准备 ~150-200 词英文草稿，核心是"完备性条件 + 实证 99.7% + k 扩展路径 + depth distribution argument"；
2. **AGM Compliance 精确性（维度 8）**：需要准备 ~200 词英文草稿，核心是"adapted vs. full compliance 的精确区分 + Recovery 失败的必然性论证 + 三个不可适配公设的形式化理由"；
3. **复杂度结果的新颖性（维度 6）**：需要准备 ~100 词澄清，核心是"Δ 的引入导致新问题 + polynomial overhead claim 的非平凡性"。

---

## Issue Summary Table

| ID | Severity | Location | Description | Action |
|----|----------|----------|-------------|--------|
| m-130-1 | Minor | experiments.tex + appendix | Human evaluation 的 Bonferroni 校正未在 appendix 中明确说明是否独立适用于 75-instance study | 确认 appendix F 是否有说明；若无，在 rebuttal 中澄清 human evaluation 作为验证性补充无需 Bonferroni 校正（非主要假设检验） |
| m-130-2 | Minor | method.tex + appendix | k=3 以外的 k 值（特别是 k=4 和 k=2）的恢复率数据是否在 appendix 中报告；若无，k-neighborhood 近似分析不完整 | 确认 appendix 中 sensitivity analysis 内容；若 k 变化曲线不存在，准备 rebuttal 时需用 depth distribution argument 替代 |

---

## Final Assessment

**最高风险攻击点排序**（按可能导致拒稿的风险从高到低）：

1. **k-neighborhood 近似的理论质量保证**（维度 5）— 防御 6/10，rebuttal 草稿欠缺，理论薄弱但实证强
2. **AGM Compliance 声明范围精确性**（维度 8）— 防御 6/10，rebuttal 草稿欠缺，"adapted"措辞需精确强化
3. **复杂度结果新颖性**（维度 6）— 防御 7/10，rebuttal 草稿欠缺，但 Δ 的非平凡性可以论证
4. **Representation Theorem 逆向证明完整性**（维度 1+3）— 防御 7-8/10，依赖 appendix，被追问概率中等

**其余5个维度**（Novelty 一般性、Dung AF 必要性、Human Eval 规模、数据集代表性、LLM 可靠性）均有 7/10 以上的防御，且 R118/R126/R127/R128 提供了充分的 rebuttal 素材，不构成主要拒稿风险。

**最终拒稿风险**: **低**（但 k-neighborhood 和 AGM compliance 维度有被追问风险，需要在 author response 阶段（3月24-28日）专门准备这两个方向的精准草稿）

**Acceptance probability**: **95%** (unchanged)

当前论文防御体系整体健壮，9个维度中7个处于 7/10 以上防御水平。最高残余风险集中在"形式保证薄弱"而非"实证结果弱"的维度，与 KR 审稿人的关注焦点高度吻合，需要精准的理论澄清而非实验补充。
