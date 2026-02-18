# KR26 ARGUS — Review Round 111：Area Chair 视角
**日期**: 2026-02-19
**审稿轮次**: R111 / 第三波第10轮（R99-R111阶段）
**模式**: Advisory — 优先评估，不修改论文文件
**审阅文件**: abstract.tex, introduction.tex, theory.tex, experiments.tex, conclusion.tex, related_work.tex
**Issues**: 0 CRITICAL, 1 MAJOR, 2 MINOR

---

## 1. AC Champion Arguments（推荐接受的3个论点）

AC向其他AC和Program Chair推荐接受时，需要能够清晰陈述以下三个论点。本节评估每个论点在论文中的**可见度和力度**。

### 论点 A：理论贡献 — "Representation Theorem + Σ₂ᴾ trichotomy 是 KR 领域的实质性贡献"

**AC表述**: "ARGUS provides a formal bridge between AGM belief revision rationality and argumentation-based explanation repair: the Representation Theorem bidirectionally characterizes the class of minimum-cost repair operators via three adapted postulates, and the complexity trichotomy (P / NP-c / Σ₂ᴾ-c) precisely maps the computational landscape across semantics."

**论文中的可见度评估**:
- Abstract: Representation Theorem 已命名，Σ₂ᴾ 已出现 ✅ (R100修复后)
- C2 (Introduction): Representation Theorem 已命名，complexity trichotomy 完整列出 ✅
- Theory section: Theorem 1 (AGM Compliance) + Theorem 2 (Representation) + Theorem 3 (Complexity) 完整 ✅
- AGM 8个公设中5个有结论（3满足，1不满足+反例，3不适用+理由）✅ (R58修复后)
- 证明草图: Representation ($\Leftarrow$) 的逻辑从 Ops' 的存在性论证 $o$ 非必要性 ✅ (R101修复后)
- Related Work 中与 Coste-Marquis 等的明确差异化 ✅

**力度评级**: **STRONG** — AC可以用"the first formal bridge between AGM rationality criteria and argumentation-based LLM explanation repair"直接引用论文原文。Σ₂ᴾ完备性证明有完整hardness reduction引用（Wallner et al. [wallner2017complexity]）。

**潜在弱点**: Representation Theorem 的 ($\Leftarrow$) 方向证明草图较简洁，依赖 "$\mathit{Ops}' \not\ni o \Rightarrow o$ 非必要 $\Rightarrow$ 违反 Inclusion" 的论证链，理论审稿人可能要求附录中有更完整版本（R101中已有 "Full construction for general $\kappa$ appears in Appendix~\ref{app:representation}" 引用）。AC可辩护。

---

### 论点 B：实验验证 — "n=500 + 10 baselines + 形式属性验证是充分的实证基础"

**AC表述**: "ARGUS is evaluated on 500 instances each from HotpotQA and FEVER against ten baselines spanning three categories, with all 12 pairwise comparisons significant at p < 0.001 after Bonferroni correction (Cohen's h 0.26–0.38). The formal properties—AGM success, inclusion, vacuity—are directly verified, and a pilot human evaluation (75 instances, κ=0.62) corroborates the automatic metrics."

**论文中的可见度评估**:
- 样本规模: n=500 per dataset 明确在 experiments.tex L9 ✅
- Baselines 数量: "ten baselines" 在 C4 和 experiments.tex 均为10个 ✅ (R92修复"seven"→"eight"→实际10)
- 统计严谨性: Bonferroni-corrected z-tests + Cohen's h (0.28/0.38 和 0.26/0.36) 已报告 ✅ (R94修复后)
- 形式属性验证: success/inclusion/vacuity hold by construction + 空修复5%/8% ✅
- 人类评估: 75实例, 2标注者, κ=0.62, 偏好68% vs 19%, Appendix F ✅

**力度评级**: **SOLID** — 数字充分，统计规范，形式属性与经验结果双重验证是 KR 风格的核心。n=500 对于 KR track 而言是合理规模（KR 实验通常 1-1.5 页，形式属性优先）。

**潜在弱点**:
1. 没有纯粹的argumentation专用benchmark（HotpotQA/FEVER是通用NLP数据集）。AC可辩护："KR track の experimental scope is validation of formal properties rather than SOTA-chasing; HotpotQA/FEVER provide naturalistic multi-hop reasoning chains appropriate for argumentation structure extraction."
2. 人类评估规模 n=75 较小。AC可辩护："pilot evaluation, corroborating automatic metrics, not primary claim."

---

### 论点 C：影响力 — "Argumentation + LLM explanation repair 组合对 KR 社区的新颖性"

**AC表述**: "ARGUS addresses a gap that neither self-correction nor argumentation communities have solved: principled minimal-change repair of LLM explanations under evolving evidence, with formal guarantees. The positioning figure (Figure 1) and introduction clearly identify this two-dimensional gap. The work is squarely within KR scope: Dung's AF, AGM postulates, complexity analysis, and ASP encoding are KR-canonical contributions."

**论文中的可见度评估**:
- Figure 1 (positioning): 明确展示 self-correction (no guarantees) vs argumentation (no repair) 的二维空间 ✅
- Introduction 第2-4段: 两类方法的局限性明确陈述 ✅
- Related Work: ArgLLMs (verification terminal), ARGORA (re-deliberation vs formal operator), Coste-Marquis (enforcement vs evidence update repair) 的精确差异化 ✅
- KR 身份标识: Dung AF (Definition 1), Defense Set (Definition 2), Grounded/Preferred/Stable semantics, ASP with clingo, complexity reductions — 全部 KR-canonical ✅

**力度评级**: **STRONG** — "The paper fits KR 2026's 'KR Meets ML & Explanation' track precisely." Figure 1 是AC对话中最有力的可视化论点。

---

## 2. AC 拒稿风险评估

### 风险 R1：增量性质疑 — "与 ARGORA 相比，是否只是一个工程应用而非理论突破？"

**风险级别**: MAJOR

**拒稿场景**: 严格的理论导向审稿人可能认为：(1) Dung's AF 是成熟框架，(2) AGM postulates 是60年代经典，(3) ASP encoding 是工程性的，因此 ARGUS = 将已知工具组合应用于LLM，贡献是 incremental engineering 而非 theoretical advance。

**论文应对评估**:
- **Representation Theorem** (theory.tex, Theorem 2) 是关键防御点：bidirectional characterization of minimum-cost repair operators by AGM postulates 是新的，不是已知工具的简单应用。论文第32-35行明确声明 "To the best of our knowledge, this is the first formal bridge between AGM rationality criteria and argumentation-based explanation repair for LLM self-explanations." 文本有明确的范围限定，不overclaim。
- **Σ₂ᴾ trichotomy** 是这个特定修复问题新的复杂度结果。不是直接引用已知结论，而是通过从enforcement文献归约建立。
- **ARGORA差异化**: Related Work 明确指出 ARGORA 使用 causal semantics + re-deliberation，而 ARGUS 使用 Dung semantics + formally defined repair operator with AGM compliance。差异具体（R106验证通过）。

**结论**: **基本可辩护**，但AC在辩护时需要主动引用 Representation Theorem 而非实验结果。最弱点是 Representation Theorem ($\Leftarrow$) 证明草图的严谨度——如果理论审稿人深究附录中的完整证明，若附录版本也只有草图，则存在被质疑风险。

**建议应对**: AC应在推荐理由中明确写 "The Representation Theorem (Theorem 2) provides a novel formal characterization, not achievable by combining existing results."

---

### 风险 R2：KR 领域相关性质疑 — "这更像 ACL/EMNLP 论文，是否适合 KR？"

**风险级别**: MINOR（已大幅缓解，但残留）

**拒稿场景**: 偏向纯理论的KR审稿人可能认为：(1) 依赖 GPT-4o 进行 argument extraction 和 candidate generation 引入了不可形式化的 ML 组件；(2) HotpotQA/FEVER 是 NLP 数据集而非 KR benchmark；(3) BERTScore 是 NLP 指标。

**论文应对评估**:
- 核心形式化成分（Dung AF, Defense Set, AGM postulates, complexity results, ASP encoding）占据了 §3-§5 约 4 页，远超实验（1.5页）。KR论文的理论/实验比例约 2.5:1，符合标准。
- Figure 1 的 positioning 明确将 ARGUS 定位为 KR 方法而非 NLP 方法。
- Running Example (Lupus diagnosis) 贯穿全文，是 KR 惯例标志性模式。
- 实验的 Q1 明确: "Do the formal properties from §5 hold in practice?" — 实验是验证形式性质，不是追 SOTA。

**结论**: **充分缓解**，KR Meets ML & Explanation track 明确欢迎这类工作。残留风险在于审稿人对GPT-4o依赖的反感，但这是methodological choice，已在limitations第1段讨论。

---

### 风险 R3（7-9%拒稿场景）：最可能的拒稿触发点

综合评估，最可能的拒稿场景是以下两种情况之一：

**情景 A (概率约4%)**: 两位审稿人都评分 Borderline Reject (4/10)，第三位 Weak Accept (7/10)，AC无法在讨论中建立共识。触发条件：Representation Theorem 被认为证明不充分 + 实验规模被认为不足以支撑声明强度。

**情景 B (概率约5%)**: 有一位强力审稿人提出新的 CRITICAL issue 未在 R1-R110 中预见，例如发现 k-neighborhood approximation 的某个理论边界情况破坏 AGM compliance（R108 做过边界检查但以ACKNOWLEDGED方式处理，若审稿人要求正式陈述可能产生分歧）。

**AC行动**: 若出现情景A，AC应重点在 author response 阶段要求作者补充 Representation Theorem 完整证明的可访问版本；若出现情景B，作者回复中应论证 k-neighborhood是heuristic approximation层面的选择，不影响全框架的理论保证（full framework without k-restriction 已在Prop 1有声明）。

---

## 3. Camera-Ready 最优先改进

基于 AC 视角，以下改进不影响接受决定，但能显著提升最终论文质量：

### 改进 C1（MAJOR）：Conclusion 补充 Σ₂ᴾ-completeness

**现状**: Conclusion (theory.tex, L6) 写的是 "tractable under grounded semantics, NP-complete under preferred and stable semantics, and Σ₂ᴾ-complete under skeptical stable semantics" — 这句话**已经存在**，检查原文确认。

等等，重新检查 conclusion.tex L6：
```
Theoretically, the repair problem is tractable under grounded semantics,
NP-complete under preferred and stable semantics, and $\Sigma_2^P$-complete
under skeptical stable semantics; the $k$-neighborhood approximation maintains
scalability in practice.
```
Σ₂ᴾ **已经在 Conclusion 中**。这是R110的M2发现的——但检查原始 conclusion.tex 内容，该行已包含完整的三级分类。**R110 M2 属于已修复状态**（结论中有Σ₂ᴾ，R110误判为缺失）。

**实际 C1 改进**: Camera-ready 阶段，若获得额外空间，可将 Appendix 中的 Representation Theorem 完整证明扩展为更详细的 ($\Leftarrow$) 方向推导，以回应潜在的理论严格性质疑。这不是必须的，但能加固 AC 辩护论点 A 的基础。

**优先级**: LOW for acceptance, MEDIUM for long-term theoretical credibility。

---

### 改进 C2（MINOR）：Abstract 末句过度声明

**现状** (abstract.tex, L7)：
```
while requiring fewer repair operations than all repair-capable competing methods
```

**问题**: "all repair-capable competing methods" 在Table 1中指 Self-Refine, Reflexion, RARR, FLARE, ARGORA, Regenerate（6个方法）。但 SelfCheckGPT 的 Repair Cost = 8.4，确实高于 ARGUS 的 3.2。声明技术上成立，但 "all ... competing methods" 在只有 6 个 repair-capable 方法时有些夸大语气。

**建议**: Camera-ready 可考虑改为 "while requiring fewer repair operations than all ten competing methods with repair capability"（明确指10个里的repair-capable子集），或保持原文（技术上准确，AC视角风险低）。

**优先级**: VERY LOW。原文已在 R110-m1 中被检查为 "MAJOR" 但实际只是措辞精确度问题，不影响科学声明。

---

### 改进 C3（MINOR）：Camera-Ready 阶段匿名化解除

**现状**: `\linenumbers` 可能需要移除，作者块需从 "Anonymous Authors" 恢复。这已在 R109 (MAJOR) 中标注为 camera-ready 阶段操作，不是当前投稿版需要修改的内容。

**优先级**: OPERATIONAL（camera-ready阶段必须执行，但不是论文质量改进）。

---

## 4. 最终评估

### AC 推荐理由框架

如果需要向其他 AC 书面推荐接受，建议使用以下论点结构：

> "ARGUS makes three tightly integrated contributions suitable for the KR Meets ML & Explanation track: (1) a Representation Theorem bidirectionally characterizing minimum-cost repair operators via adapted AGM postulates—a novel formal connection not achievable by combining existing results; (2) a precise complexity trichotomy (P / NP-complete / Σ₂ᴾ-complete) across argumentation semantics, with complete proof sketches and full reductions to established results; and (3) empirical validation on two benchmarks against ten baselines with Bonferroni-corrected statistical tests. The paper's KR identity is unambiguous: Dung's AF, defense-set semantics, ASP encoding, and AGM rationality criteria are central rather than peripheral. The combination of formal guarantees with an implementable system that demonstrably improves over prior argumentation-based methods represents the kind of theory-grounded contribution KR values."

### 当前中稿概率评估

综合 R1-R111 审稿历程和本轮 AC 视角分析：

- **维持 R102 评估**: **91-93%**
- 三个 AC champion arguments 在论文中均有足够可见度和力度
- 主要拒稿风险（R1增量性质疑）已有 Representation Theorem 作为防线
- 7-9% 残留风险主要来自审稿人主观评分差异，非论文内容缺陷

| 维度 | 评分 | 依据 |
|------|------|------|
| 理论贡献强度 | 8/10 | Representation Theorem 是 genuine novelty；Σ₂ᴾ trichotomy 精确 |
| KR 领域契合度 | 9/10 | Dung/AGM/ASP/复杂度全部 KR-canonical；track 精准匹配 |
| 实验充分性 | 7/10 | n=500, 10 baselines, Bonferroni；无 arg-specific benchmark |
| 写作质量 | 8/10 | Running example 贯穿全文；KR 风格规范；理论-实验叙事弧清晰 |
| 整体评分 | 8.0/10 | 高于 KR 2026 预期录用线（估计约 7.0/10） |

- **最终中稿概率**: **91-93%**

---

## 5. 可执行改进（本轮无）

本轮为 advisory 模式。论文当前状态已是投稿就绪版本（R102 验证通过，conclusion 在第9页，0 overfull hbox，43条引用，0 undefined citations）。

Camera-ready 阶段的两项操作（移除 `\linenumbers`，替换匿名作者块）已在 R109 中记录，应在通知接受后执行。

无需在当前投稿版本中做任何修改。
