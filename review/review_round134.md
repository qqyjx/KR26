# R134: UAI 2026 定位适配审查

**日期**: 2026-02-26
**审查员**: Claude (UAI Positioning Reviewer)
**焦点**: 论文是否适合 UAI 审稿人的期望（uncertainty/probabilistic reasoning 视角）

---

## 背景

UAI (Conference on Uncertainty in Artificial Intelligence) 的核心关注点：
- Bayesian reasoning, probabilistic graphical models
- Uncertainty quantification, decision making under uncertainty
- Formal models of reasoning under incomplete/uncertain information
- **与本文直接相关**: argumentation under uncertainty, non-monotonic reasoning, belief revision

UAI 近年接收过的相关论文类型：probabilistic argumentation, abstract argumentation complexity, belief change, non-monotonic reasoning。本文的 argumentation + AGM belief revision 主题**天然适合 UAI**。

---

## MAJOR Issues

### M1. Abstract 未强调 "uncertainty" 连接 [MAJOR]
**位置**: [abstract.tex](paper/sections/abstract.tex)
**问题**: Abstract 中没有出现 "uncertainty" 一词。UAI 审稿人首先扫描 abstract 判断论文是否在 scope 内。当前 abstract 完全以 "argumentation + repair" 为框架，没有显式连接到 uncertainty reasoning。
**修复建议**: 在 abstract 中加入一句连接，例如在描述问题时提及 "reasoning under evidential uncertainty" 或 "uncertain and evolving evidence"。具体位置：第 3 句 "when an evidence update renders the explanation inconsistent" 可改为 "when new, possibly uncertain evidence renders the explanation inconsistent"。

### M2. Introduction 缺少 UAI 社区语境 [MAJOR]
**位置**: [introduction.tex](paper/sections/introduction.tex)
**问题**: Introduction 的叙事完全从 KR 视角出发（"a central knowledge representation challenge"），没有连接到 UAI 的核心议题（uncertainty in AI systems, reasoning under incomplete information）。
**修复建议**:
- 第 1 段末尾加入 uncertainty 视角："This gap is compounded when explanations must account for uncertain or incomplete evidence—a setting naturally captured by argumentation semantics, where the acceptability of conclusions depends on the evolving attack structure."
- C1-C4 贡献列表本身无需修改（已足够形式化），但可以在列表前加一句："These contributions address the broader challenge of maintaining explanation integrity under evidential uncertainty:"

### M3. Related Work 缺少 UAI 社区核心工作 [MAJOR]
**位置**: [related_work.tex](paper/sections/related_work.tex)
**问题**: Related Work 覆盖了 argumentation+LLM、self-correction、belief revision 三条线，但缺少：
1. **Probabilistic argumentation**: Hunter (2013), Li et al. (2021) 等在 UAI 有影响力的工作
2. **Uncertainty in NLG/NLP**: Kuhn et al. (2023, semantic uncertainty), Kadavath et al. (2022, self-aware uncertainty)
3. **UAI 近年相关工作**: 如果有 UAI 2024-2025 发表的 argumentation/belief revision 论文应该引用

**修复建议**: 在 "Argumentation and LLMs" 段落中加入 1-2 句关于 probabilistic argumentation 的定位说明，解释为什么本文选择 classical (Dung-style) 而非 probabilistic argumentation。

### M4. Confidence score 的不确定性语义未充分利用 [MAJOR]
**位置**: [method.tex:18](paper/sections/method.tex#L18)
**问题**: §4.1 提到每个 argument unit 有 confidence score γᵢ ∈ (0,1]，§4.4 用它定义 confidence-weighted cost。但论文没有讨论 γᵢ 的 uncertainty 含义——这正是 UAI 审稿人最关心的。γᵢ 本质上是 LLM 的 epistemic uncertainty estimate，可以连接到 UAI 的核心议题。
**修复建议**: 在 §4.1 或 §4.4 中加入 1-2 句讨论 confidence score 作为 uncertainty proxy 的性质和局限性。

---

## MINOR Issues

### m1. Conclusion 中的 future work 未提及 probabilistic extensions [MINOR]
**位置**: [conclusion.tex:13](paper/sections/conclusion.tex#L13)
**问题**: Future work 提到了 sequence explanations 和 RAG integration，但没有提及 probabilistic argumentation extension（如 weighted/probabilistic AF），这对 UAI 审稿人是自然的下一步。
**修复**: 加一句："Extending the framework to probabilistic argumentation semantics would enable principled handling of graded argument strength."

### m2. "KR challenge" 措辞 [MINOR]
**位置**: [introduction.tex:6](paper/sections/introduction.tex#L6)
**问题**: "a central knowledge representation challenge" 是 KR 会议的语言。对 UAI，改为 "a central challenge in reasoning under uncertainty" 或 "a challenge at the intersection of formal reasoning and uncertain evidence" 更合适。

### m3. 定理风格已符合 UAI [MINOR]
**状态**: PASS — global numbering (Theorem 1, 2, Proposition 1) 和 Definition-Example 配对结构在 UAI 中完全可接受。UAI 接收形式化论证论文。

---

## 整体适配评估

| 维度 | 评分 (1-5) | 说明 |
|------|-----------|------|
| Scope fit | 4/5 | 论文主题（argumentation + belief revision）天然适合 UAI |
| Terminology | 3/5 | 多处使用 KR 专属表述，需微调 |
| Community awareness | 2/5 | 缺少 UAI 社区核心工作引用 |
| Uncertainty connection | 2/5 | 未显式连接到 uncertainty reasoning |
| Technical depth | 5/5 | 定理证明、复杂度分析、ASP encoding 符合 UAI 标准 |

**结论**: 论文内容适合 UAI，但**包装需要调整**。核心技术贡献无需修改，主要是 framing 和 related work 的适配。

## 统计

| 类型 | 数量 |
|------|------|
| CRITICAL | 0 |
| MAJOR | 4 |
| MINOR | 3 |
| PASS | 1 |
