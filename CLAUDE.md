# Claude Code 论文写作配置 -- KR2026 ARGUS

## 1. Project Overview

| Item | Detail |
|------|--------|
| **Paper Title** | ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations |
| **Conference** | KR 2026 (23rd Int. Conference on Principles of Knowledge Representation and Reasoning) |
| **Track** | KR Meets ML & Explanation |
| **Deadline** | Abstract: February 12, 2026; Paper: February 19, 2026 |
| **Author Response** | March 24--28, 2026 |
| **Notification** | April 13, 2026 |
| **Camera-ready** | May 3, 2026 |

**Core Idea**: LLM self-explanations (rationales) are unverifiable and non-repairable. ARGUS structures explanations as argument graphs, applies argumentation semantics for formal verification, and performs minimal-change repair when new evidence arrives---ensuring explanations remain synchronized with answers at minimum edit cost.

**Pipeline**: `LLM -> Argument Graph -> Semantic Verification -> Minimal-Change Repair`

---

## 2. Build & Run Commands

```bash
cd paper && latexmk -pdf main.tex      # Compile
cd paper && latexmk -C                  # Clean
cd paper && latexmk -pdf -g main.tex    # Force recompile
```

### Page Limit Check

> **⚠️ 惨痛教训（2026-02-25 desk rejection）**：论文经过 68 轮审查后被 desk reject，根因是 **附录页数未计入页数限制**。
> `\appendix` 写在 `.tex` 文件里 = 计入页数限制！必须用 supplementary material（单独上传）才能不计入。

**KR 2026 要求**：正文 ≤ 9 页（含 abstract、figures、**appendices**；不含 references 和 acknowledgements）

**关键区分**：
- **In-paper appendix**（`\appendix` 在 `.tex` 中）→ **计入**页数限制
- **Supplementary material**（单独 PDF/ZIP 上传到投稿系统）→ **不计入**页数限制
- ❌ 绝对禁止：把正文内容移到 `\appendix` 来"压缩页数"——这是假压缩，附录仍然计入！
- ✅ 正确做法：超出页数限制的内容移到单独上传的 supplementary material

```bash
# 【投稿前必须执行】验证实际 PDF 页数
cd paper && latexmk -pdf main.tex

# 1. 查看 PDF 总页数
pdfinfo main.pdf | grep Pages

# 2. 找到 references 起始页（此页之后不计入限制）
grep -n "\\\\bibliography" main.tex

# 3. 找到 appendix 起始页（appendix 计入限制！）
grep -n "\\\\appendix" main.tex

# 4. 计算可数页数 = 总页数 - references 页数
#    如果 appendix 在 references 之后，appendix 页数也要加回来！

# 5. 检查模板版本是否为最新
head -1 styles/kr.sty
# 必须与会议官方 authors kit 版本一致
```

**页数计算公式**：`可数页数 = body 页数 + appendix 页数`（不含 references/acknowledgements 页数）

---

## 3. Repository Structure

```
KR26/
├── CLAUDE.md              # Claude Code 工作指南（本文件）
├── dagang.md              # 论文大纲，定义各 section 结构和要点
├── placeholders.md        # 占位符追踪清单（图表/数值/同步状态）
├── .gitignore             # LaTeX artifacts, IDE files, Python cache, OS files
├── paper/                 # LaTeX 论文源文件
│   ├── main.tex           # 主文件（宏定义 + section includes）
│   ├── .latexmkrc         # latexmk 构建配置（pdflatex, BibTeX）
│   ├── references.bib     # 参考文献（26 条被引用条目）
│   ├── sections/          # 章节文件（8 个 .tex 文件，共 ~604 行）
│   │   ├── abstract.tex        # §0 Abstract (~127 词)
│   │   ├── introduction.tex    # §1 Introduction + Running Example + C1-C4
│   │   ├── related_work.tex    # §2 Related Work（KR 惯例：紧跟 Introduction）
│   │   ├── preliminaries.tex   # §3 Preliminaries (Def 1-4 + Examples)
│   │   ├── method.tex          # §4 Method (§4.1-4.4, Algorithm 1, ASP encoding)
│   │   ├── theory.tex          # §5 Theory (Theorem 1-2, Proposition 1)
│   │   ├── experiments.tex     # §6 Experiments (Tables 1-2, Figures 3-5)
│   │   └── conclusion.tex      # §7 Conclusion + 4 limitations
│   └── styles/            # KR2026 模板样式文件
│       ├── kr.sty         # KR 2026 LaTeX 样式
│       └── kr.bst         # KR 2026 BibTeX 样式
├── results/               # 实验结果数据
│   └── results.json       # 结构化结果（status: ACTUAL, 5 seeds, 2026-02-10）
└── review/                # 审稿意见存档（49 个文件，68 轮审查）
    ├── review-20260211-R01-R05-initial.md    # R01-R05: 初始全面审查
    ├── review-20260212-R05b-revision.md      # R05b: 修订轮
    ├── review-20260212-R06-titleabstract.md  # R06: 标题摘要审查
    ├── review-20260212-R07-fixes.md          # R07: 修复确认
    ├── review-20260212-R08-theory.md         # R08: KR 理论专家审查
    ├── ...                                    # R09-R57: 多轮深度审稿
    ├── review-20260215-R58-theory-depth.md   # R58: AGM 理论深化
    ├── ...                                    # R59-R67: 统计/引用/形式化/清晰度/对抗/数据一致性
    └── review-20260215-R68-final-regression.md  # R68: 最终回归（ALL PASS）
```

**注意**：论文中的 TikZ 图表（Figures 1-5）内联定义在 `.tex` 文件中，无独立 `figures/` 目录。实验代码在外部服务器运行，本仓库仅含论文源文件和结构化结果数据。

### Section 文件详细信息

| 文件 | 内容 | 关键元素 |
|------|------|---------|
| `abstract.tex` | ~127 词摘要 | Context+Gap → Contribution → Validation |
| `introduction.tex` | 动机 + Running Example + C1-C4 | Example 1 (医疗诊断场景), 4 contributions |
| `related_work.tex` | 三条研究线比较 | 论证+LLM, 自我修正, 信念修正 |
| `preliminaries.tex` | Definitions 1-4 + Examples | AF, Defense Set, 验证任务, 修复问题 |
| `method.tex` | §4.1-4.4 核心方法 | Algorithm 1, ASP encoding, k-neighborhood |
| `theory.tex` | 形式化理论结果 | Theorem 1 (AGM), Theorem 2 (复杂度), Prop 1 |
| `experiments.tex` | 实验评测 | Table 1-2, Fig 3-5, 7 baselines, 消融 |
| `conclusion.tex` | 总结 + 局限 | 4 具体技术局限 |

---

## 4. KR2026 Format Notes

| Item | Requirement |
|------|-------------|
| **Template** | `\documentclass{article}` + `\usepackage{kr}` |
| **Page limit** | Long paper: ≤ 9 pages; Short paper: ≤ 4 pages (incl. abstract, figures, appendices; excl. references & acknowledgements) |
| **Review** | Double-blind anonymous peer review |
| **Bibliography** | `\bibliographystyle{kr}` with `kr.bst` |
| **Citations** | `\cite{}` and `\shortcite{}` |
| **Submission** | https://submissions.floc26.org/kr/ |
| **Supplementary** | Up to 100 MB allowed, but paper must be self-contained |
| **AI Policy** | AI cannot serve as author; if used, authors bear full responsibility |

### Anonymization

Double-blind review: do NOT include author names, affiliations, or self-identifying references in the submitted version. Avoid "we previously showed [OurWork2024]" patterns.

---

## 5. 学术写作风格规范（Nature/Science/NeurIPS/KR 标准）

### 核心原则

1. **消除列表依赖症**：禁止在正文中过度使用 `\itemize` 和 `\enumerate`，将列表转换为流畅段落叙述，使用过渡词（Notably, Furthermore, Moreover, Conversely, Additionally, Specifically, Finally）

2. **Run-in Headings**：用 `\textbf{标题.}` 替代过多的 `\subsubsection{}`，但仅限正文中间的分节标题

3. **段落密实化**：合并碎片化的单句段落，每个段落必须有明确的主题句

4. **内联定义**：符号定义整合到文本流中，如 `where $\tau$ denotes type, $\mathbf{p}$ represents position`

5. **实验参数叙述化**：
   - ❌ `Grid size: 50x50, Agents: 5`
   - ✅ `We conducted experiments on a $50 \times 50$ grid deployed with 5 agents...`

6. **段落开头禁用加粗关键词标签**：
   - 禁止在正文段落首句使用 `\textbf{关键词.}` 模式开头（如 `\textbf{The safety gap.}` `\textbf{Key insight.}` `\textbf{From prompts to programs.}`）
   - 段落应以自然叙述句开头，通过内容本身引导读者，不需要用加粗标签"预告"段落主题
   - **例外**：Contributions 列表中的 `\textbf{(C1) ...}` 标题允许使用；正文中间用于分节的 run-in heading（如 `\textbf{Pheromone Dynamics.}`）允许使用，但 Introduction 的叙述段落不应使用
   - ❌ `\textbf{The safety gap.} Existing systems operate as untyped interpreters...`
   - ❌ `\textbf{From prompts to programs.} We observe that...`
   - ❌ `\textbf{Paper outline.} §2 gives...`
   - ✅ `Existing LLM-based incident response systems operate as untyped interpreters...`
   - ✅ `The incident response workflow has a natural computational structure...`
   - ✅ `The remainder of this paper is organized as follows.`

7. **Contributions 列表简洁化**：
   - 每个贡献点限制在 1-2 句话（≤3 行 LaTeX）
   - 只写核心贡献和关键结论，细节留给正文展开
   - Section 引用放在句末括号中，如 `...preserving decidable type checking (§4--§5).`
   - ❌ 在 Contributions 中展开技术细节、对比论述、完整定义、背景解释
   - ❌ `\item \textbf{(C1) A non-trivial product effect algebra with interaction axioms} (§3--§5). We design a typed functional DSL... that instantiates the abstract framework of [X]. Crucially, the three components are not independent: we identify four interaction axioms... These axioms are preserved by typing, yielding three domain-specific safety theorems... We further equip the type system with bounded effect polymorphism...`（7 行，过长）
   - ✅ `\item \textbf{(C1)} A typed functional DSL grounded in a product effect algebra with four interaction axioms that couple the components, yielding three domain-specific safety theorems. Bounded effect polymorphism enables generic reusable combinators while preserving decidable type checking (§3--§5).`（3 行，简洁）

8. **控制括号使用**：
   - 避免在正文中大量使用 `(e.g., ...)` 和 `(...)` 补充说明
   - 优先使用从句（such as, including, for instance, namely）或破折号替代
   - 每段正文中括号不超过 2 处
   - ❌ `mitigation actions (pod restart, configuration rollback, and capacity scaling)`
   - ❌ `failures that range from merely wasteful (querying irrelevant telemetry) to catastrophic (executing destructive operations)`
   - ✅ `mitigation actions such as pod restart, configuration rollback, and capacity scaling`
   - ✅ `failures ranging from merely wasteful---querying irrelevant telemetry---to catastrophic, including executing destructive operations`

### 高级写作规则（来自多轮审稿经验）

9. **Abstract 与 Introduction 的 Contributions 必须对齐**：Abstract 中提到的每个贡献必须在 Introduction 的 Contributions 列表中有对应项，反之亦然。Conclusion 的总结也必须与两者一致。

10. **数据一致性铁律**：摘要、正文、表格、图表、appendix 中出现的同一数据必须完全一致。每次修改数据后，必须全文搜索该数值确认所有出现点都已更新。

11. **Related Work 的比较必须精确**：与每个相关工作的比较必须指出具体差异点，不能只说 "unlike X, we do Y"。应说明 X 做了什么、为什么不够、我们如何不同/更好。

12. **Theorem/Definition 命名必须一致**：如果正文中给出了 Theorem 的名称（如 "Theorem 3 (Rollback Availability)"），在 appendix 的证明中引用时也必须使用相同名称和编号。

13. **避免 overclaiming**：
    - 不要说 "first"，除非确实是领域首创且能证明
    - 不要说 "novel" 超过 2 次
    - 用 "to the best of our knowledge" 限定范围声明
    - 实验结果只做数据支撑的声明，不做超出数据的推断

14. **Limitations 必须诚实且具体**：不要写泛泛的 limitation，要指出具体的技术局限和潜在改进方向。审稿人喜欢作者坦诚地讨论局限性。

15. **实验部分的 Setup 叙述化**：不要使用独立的 `\subsubsection{Setup}` 和 `\subsubsection{Results}`，将实验设置融入结果讨论的开头段落。

### 约束条件

- 保持所有 `\cite{...}` 引用、定量数据、公式不变
- 维护 LaTeX 语法有效性

---

## 6. KR 会议写作风格指南（基于 KR2024-2025 论文分析）

以下规范基于对 5 篇 KR 2024-2025 录用论文的系统分析，总结 KR 社区特有的写作惯例。与 NeurIPS/ICML 等 ML 会议有显著差异，务必严格遵守。

### Abstract（KR 风格）

- 控制在 100-180 词（比 NeurIPS/ICML 的 200-300 词更短）
- 三段式结构：Context+Gap → Contribution → Validation
- 技术精确，不写影响力空话（不用 "enabling safer AI systems" 等）
- 常用开头："We investigate..." / "We introduce..." / "There is a growing interest in..."

### Introduction（KR 风格）

- 以领域级别的上下文开头，不用戏剧性 hook
- 使用 **Running Example**：在 Introduction 中引入具体场景（如 Example 1），后续 section 反复引用（这是 KR 的标志性模式）
- Contributions 更强调形式化属性（soundness, completeness, complexity results）而非经验性改进

### Preliminaries（KR 风格 --- 最重要）

- 这是 KR 论文的核心标识，比 ML 论文详细得多（1-2 页）
- Definition 全局编号（Definition 1, 2, 3... 不是 Definition 2.1）
- 每个 Definition 后紧跟 Example 建立直觉
- 符号密度高：自由使用逻辑量词（∀, ∃）、逻辑连接词（∧, ∨, →）

### Method（KR 风格）

- 围绕 Definition-Proposition-Theorem 链组织（不是过程性描述）
- 重点是"什么属性成立以及为什么"，而非"如何高效计算"
- 复杂度结果是 KR 论文的标配（"Problem X is NP-complete for σ ∈ {co, st}"）

### Experiments（KR 风格）

- 较短（1-1.5 页），验证形式化声明而非展示 SOTA
- 重点是：正确性、可扩展性、形式属性是否在实践中成立
- 消融研究关注形式组件（去掉语义约束、改变语义类型）

### Related Work（KR 风格）

- **放在 Section 2**（Introduction 之后），这是 KR 的惯例
- 按方法论类型分类（attribution-based vs. counterfactual）或按形式框架分类（Dung's AF vs. ASPIC+ vs. ABA）
- 比较精确：说明 X 做了什么、为什么不够、我们如何不同

### Conclusion（KR 风格）

- 0.5-1 页，简洁克制
- 不写 broader impact / societal implications
- 只写技术总结 + 具体局限 + 未来技术方向

### KR 通用语调

- 克制而非推销性："We provide evidence that..." 而非 "We dramatically improve..."
- 不用戏剧性开头："In the era of AI..." ← 禁止
- 使用 "w.r.t."、"iff" 等 KR 标准缩写
- 过渡短语："The following theorem establishes that..." / "As a direct consequence of..." / "Continuing with Example X..."

### Running Example 规范（KR 标志性模式）

- Introduction 中引入 Example 1（具体场景），使用 `\label{ex:running}`
- 后续所有 section 用 `Continuing Example~\ref{ex:running}` 或 `Revisiting Example~\ref{ex:running}` 复用同一场景
- Example 必须用具体数据实例化抽象概念（如用 $F_0$, $F_1$ 代入 Definition 中的 AF）
- 引用过渡短语: "Continuing with Example X...", "Observe that in Example X...", "Revisiting Example X..."

### Definition-Example 配对铁律

- **每个 Definition 后必须紧跟 Example**
- Example 使用 running scenario 的具体数据实例化 Definition 中的抽象概念
- 如有多个 Definition 共享相似场景，Example 应递进式展示新概念
- Theorem 后也推荐添加 Example 展示定理含义（尤其是 AGM compliance 类结果）

### KR 过渡短语参考表

| 场景 | 推荐用语 |
|------|---------|
| 引入定义 | "We now define..." / "The following definition captures..." |
| 定义后引例 | "Continuing with Example X..." / "To build intuition, consider..." |
| 定理前铺垫 | "The following theorem establishes that..." / "We now state our main result." |
| 定理推论 | "As a direct consequence of..." / "It follows immediately that..." |
| 段间过渡 | "Observe that..." / "In the following, we..." / "With these foundations in place, we..." |
| 实验连接 | "Revisiting Example X in the experimental setting..." |
| 小节铺垫 | "We turn next to..." / "The preceding analysis motivates..." |

### KR vs ML 风格对比表

| Dimension | KR Style | NeurIPS/ICML Style |
|-----------|----------|-------------------|
| Definitions | Extensive, numbered, rigorous | Minimal, informal |
| Theorems | Central contribution | Supporting material |
| Experiments | 1-1.5 pages, validate formal claims | 2-3 pages, SOTA |
| Running examples | Standard practice | Rare |
| Related Work | Section 2 (early) | Before Conclusion |
| Abstract | 100-180 words | 200-300 words |
| Overclaiming | Very restrained | More common |

### 实验与写作补充规范（跨项目通用经验）

以下规则来自多个项目的审稿经验，适用于所有论文：

1. **实验表格规模**：实验结果主表必须数据丰富，占半页以上、跨双栏，对比组（baseline）≥5个，指标维度≥4个。小而稀疏的表格会被审稿人视为实验不充分
2. **图表顺序**：Figure 1 固定放系统架构图/整体框架图，实验结果图从 Figure 2 或更后开始。架构图是读者理解全文的入口，必须最先出现
3. **Limitation 克制**：Limitation/局限性段落点到为止（2-3句），不深入展开。过度自我否定会削弱论文整体可信度，审稿人需要的是诚实而非自我拆台
4. **括号控制（强化）**：每段正文括号≤2处，**写作时默认不用括号**，只在确实无法用从句、破折号或定语替代时才使用。写完一个 section 后必须回扫括号数量。这是反复出现的顽疾，必须在写作阶段主动控制

---

## 7. 常见审稿问题清单（所有项目汇总）

以下是在 KDD26、ICML26、ICFP2026 等项目的多轮审稿中反复出现的问题。**每次写作和审稿前必须对照检查**：

### A. 数据一致性（Critical）
- [ ] 摘要数据与正文/表格不一致
- [ ] main.tex 宏定义与 experiments.tex 硬编码值不一致
- [ ] results.json 与论文数值不同步
- [ ] 附录数据与正文数据不一致
- [ ] 表格 caption 与正文描述的数值不一致
- [ ] Contributions 中的数据与 Experiments 中的数据不一致

### B. 写作风格（Major -- 审稿人最常抱怨）
- [ ] 段落首句使用 `\textbf{关键词.}` 加粗标签（应自然叙述）
- [ ] Contributions 每项超过 3 行（应简洁 1-2 句）
- [ ] 括号过多（每段 >2 处括号）
- [ ] 列表依赖症（正文中过多 itemize/enumerate）
- [ ] 碎片化单句段落
- [ ] 过渡词使用不当或缺失

### C. 理论/逻辑（Critical）
- [ ] 定理陈述与证明不匹配
- [ ] 消融实验结果不符合预期（移除组件后性能反而提升）
- [ ] 单调性关系不成立
- [ ] 创新点不够强就开始打磨文字（本末倒置）

### D. 引用与 Baseline（Major）
- [ ] Baseline 缺少近两年的强 baseline
- [ ] 引用格式不统一
- [ ] 重要工作漏引
- [ ] Related Work 比较不够精确

### E. 格式（Major）
- [ ] 正文超页数限制
- [ ] 参考文献/附录顺序错误
- [ ] 匿名化不合规（双盲审稿时泄露作者信息）
- [ ] 实验主对比表≥半页双栏，baseline≥5个，指标≥4个
- [ ] Figure 1 为系统架构图，实验结果图从 Figure 2+ 开始
- [ ] Limitation 段落≤3句，无过度自我否定
- [ ] 全文括号回扫：每段≤2处，无括号堆积段

### F. KR 风格专项（Major）
- [ ] 是否有 running example 且贯穿全文（Introduction 引入，后续 section 复用）
- [ ] 每个 Definition 后是否紧跟 Example
- [ ] Related Work 是否在 Section 2（Introduction 之后）
- [ ] 是否使用 KR 过渡短语（"Continuing with Example X...", "Observe that...", "The following theorem establishes..."）
- [ ] 是否避免 ML 推销性语言（禁止 "dramatically improve", "In the era of AI"）
- [ ] 实验是否以验证形式属性为主（而非单纯追求 SOTA 数值）
- [ ] Abstract 是否在 100-180 词范围内

### G. 格式合规（CRITICAL — 所有审查之前必须首先检查！！）

> **铁律**：68 轮内容审查在格式不合规面前毫无意义。格式检查必须在任何内容审查之前完成。

- [ ] **PDF 实际页数验证**：用 `pdfinfo main.pdf | grep Pages` 验证，禁止估算
- [ ] **可数页数 ≤ 限制**：body + appendix 页数之和（不含 references/acknowledgements）≤ 页数限制
- [ ] **Appendix 页数已计入限制**：`\appendix` 写在 `.tex` 文件中 = 计入页数限制！
- [ ] **超限内容处理**：超出限制的内容移到 supplementary material（单独上传），绝不移到 `\appendix`
- [ ] **模板版本验证**：`head -1 styles/kr.sty` 输出的版本号必须与会议官方 authors kit 一致
- [ ] **匿名化完整**：无作者名、无机构、无基金项目名、无自引暴露
- [ ] **PDF 编译无错误**：0 errors, 0 undefined references
- [ ] **投稿系统 ready for review 勾选**

---

## 8. Result Macros（数值单一真相源）

`main.tex` 第 57-69 行定义了 10 个结果宏，是论文中所有数值的唯一来源。Abstract、Introduction、Experiments、Conclusion 均通过宏引用这些数值，确保全文一致。

```latex
% Main results
\newcommand{\resultFaithHotpot}{0.847}       % ARGUS Faithfulness on HotpotQA
\newcommand{\resultFaithFEVER}{0.829}        % ARGUS Faithfulness on FEVER
\newcommand{\resultContestHotpot}{0.791}     % ARGUS Contestability on HotpotQA
\newcommand{\resultContestFEVER}{0.768}      % ARGUS Contestability on FEVER
\newcommand{\resultRepairAccHotpot}{0.883}   % Repair accuracy on HotpotQA
\newcommand{\resultRepairAccFEVER}{0.871}    % Repair accuracy on FEVER
\newcommand{\resultRepairCostHotpot}{3.2}    % Repair edit cost on HotpotQA
\newcommand{\resultRepairCostFEVER}{2.8}     % Repair edit cost on FEVER
% Improvement over ARGORA (strongest argumentation baseline)
\newcommand{\improveFaithfulness}{10.3\%}
\newcommand{\improveContestability}{14.5\%}
```

**修改数值时**：只需更新 `main.tex` 中的宏定义，然后同步更新 `results/results.json`、`placeholders.md` 和 `dagang.md`。编译后全文自动更新。

---

## 9. 论文先行模式

**核心理念**：先用合理的预设数值完成论文框架，确保叙事逻辑完整，再用真实实验结果替换。

**当前状态**：所有数值已从 PRESET 更新为 ACTUAL（`results.json` status: "ACTUAL", last_updated: 2026-02-10）。

### 项目配置文件

| 文件 | 用途 |
|------|------|
| `dagang.md` | 论文大纲，定义各 section 结构和要点 |
| `placeholders.md` | 占位符追踪清单，记录待替换的图表和数值（当前全部 DONE） |
| `results/results.json` | 结构化结果数据，含 8 methods × 2 datasets × 4 metrics + 消融 + 理论验证 |

---

## 10. 论文审稿流程

### 审稿指令速查

| 指令 | 用途 |
|------|------|
| `/review-paper` | 完整论文审查流程 |
| `/review-paper logic` | 重点关注理论性和逻辑性 |
| `/review-paper parentheses` | 检查括号过多问题 |
| `/review-paper consistency` | 数据一致性审查 |
| `/review-paper citations` | 引用审查与修复 |
| `/review-paper full` | 作为顶级会议审稿人全面审查 |

### 审稿输出规范

- 审稿建议写入 `review/` 文件夹（自动创建）
- 文件命名：`review-YYYYMMDD-HHMMSS.md`
- 修改后再审查，新建议写入新文件
- 对照历史审稿问题，避免重复错误

---

## 11. 创新点检查工作流（重要环节）

**核心原则**：先检查创新点强度，再做其他工作。防止所有工作完成后才发现需要大改。

### 工作流步骤

1. **创新点评估**：评估论文 idea 是否能达到目标会议的中稿概率
   - 分析目标会议近年录用论文的创新水平
   - 对比本文贡献与 SOTA 的差异化程度
   - 识别审稿人可能的质疑点
2. **创新点强化**（若评估不达标）：优先更新核心技术贡献
   - 论证语义/形式化深度提升
   - 定理/证明严谨度增强
   - 与现有理论框架的深层连接（Dung's AF, ASPIC+, ABA）
3. **全文联动更新**：创新点确定后，再更新 abstract/intro/conclusion/related work
4. **审查全文**：使用 `/review-paper` 系列指令做最终审查

### 关键竞争对手

| Work | Venue | Key Difference from ARGUS |
|------|-------|---------------------------|
| **ArgLLMs** | AAAI 2025 | LLM-based argumentation but no minimal-change repair |
| **ARGORA** | Recent | Argumentation + LLM but different semantic grounding |
| **MQArgEng** | Recent | Argumentation engine but not focused on LLM self-explanation repair |

### 关键教训

- 创新点是论文的骨架，必须第一时间确定
- 不要在创新点不够强的情况下打磨文字---这是本末倒置
- 每次大改后重新编译验证：`cd paper && latexmk -pdf main.tex`

---

## 12. 数据同步原则

**论文先行，实验后补**：
1. 先检查论文设定是否符合理论和逻辑
2. 若符合，代码和 `results.json` 向论文同步
3. 在论文和图表中更新符合理论逻辑的数值
4. `results.json` 和脚本保持同步
5. 实际实验在服务器执行后更新

---

## 13. Baseline 选择原则

- 搜索近 2 年（2024--2026）相关工作
- 选择强 baseline，确保 SOTA 对比
- 使用 Semantic Scholar / DBLP / Google Scholar 验证
- **必须包含**的关键竞争对手：
  - **ArgLLMs** (AAAI 2025): LLM-based argumentation framework
  - **ARGORA**: Argumentation + LLM integration
  - **MQArgEng**: Modular argumentation engine
- 其他推荐 baseline 类别：
  - 自我一致性/幻觉检测（SelfCheckGPT, Self-consistency）
  - 自我批判/修订（Self-Refine, Reflexion）
  - 检索后修订（RARR, RARE）
  - 推理验证（Deductive Verification, Verifiers for CoT）

---

## 14. 当前项目状态

**状态**: ❌ **DESK REJECTED**（2026-02-25 收到通知，论文格式不合规）

> **根因**：论文 body 9 页 + appendix ~2-3 页 = ~11-12 可数页，超出 9 页限制。`\appendix` 内容被错误地当作不计入限制的 supplementary material。68 轮审查全部聚焦内容质量，**从未真正验证过 PDF 可数页数是否 ≤ 9**。

| 维度 | 状态 |
|------|------|
| 论文内容 | ✅ 内容质量已通过 68 轮审查 |
| **格式合规** | ❌ **DESK REJECTED — 可数页数超限（~11-12 页 vs 限制 9 页）** |
| 数据一致性 | ✅ 118 项检查全部通过 |
| 匿名化 | ✅ 双盲合规（Paper ID 607） |
| 模板版本 | ⚠️ kr.sty v1.2 (Feb 2020)，可能与 KR2026 authors kit 版本不一致 |
| 引用 | ✅ 34 条引用，0 undefined references |
| 审查轮次 | ✅ 68 轮完成（R01-R68），160+ issues found and addressed |

### 审查历程

共进行 68 轮审查（R01-R68），分 6 个阶段：

| 阶段 | 轮次 | 日期 | 焦点 |
|------|------|------|------|
| 初始审查 | R01-R07 | 02-11~12 | 全面初审 + 标题/摘要/修复 |
| 专家审查 | R08-R12 | 02-12 | 理论/实验/写作/对抗/终审 |
| 深度打磨 | R13-R33 | 02-13~14 | 形式化/引用/可复现性/ML Track/竞争定位/匿名化 |
| 批量审稿 | R34-R57 | 02-15 | 风格/交叉引用/相关工作/可复现性/camera-ready + 3 批量轮 |
| 理论深化 | R58-R63 | 02-15 | AGM 深化/统计/引用补充/形式化精确/清晰度/对抗 |
| 最终验证 | R64-R68 | 02-15 | 页面压缩/可读性/对抗/数据一致性/最终回归 |

关键修复（CRITICAL/MAJOR）：
- **R08**: Stable credulous 复杂度应为 NP-complete（非 Σ₂ᴾ），已修正 Theorem 2
- **R13**: Running example AF 攻击关系错误，已重构为 reinstatement 模式
- **R58**: AGM 只讨论 3/8 公设——添加 recovery 失败反例 + 5 个公设完整讨论
- **R59**: Bonferroni 校正 + error analysis + framework 统计
- **R60**: 补充 Bengel & Thimm / Hase et al. / Alfano et al. 三篇引用
- **R64**: 正文从 ~9.5 页压缩到 ≤9 页（移出 Figure 5/6 + Sensitivity/Error Analysis 到 appendix）

### 形式化元素清单

| 元素 | 编号 | 位置 | 内容 |
|------|------|------|------|
| Definition 1 | Def 1 | preliminaries.tex | 抽象论证框架 (AF) |
| Definition 2 | Def 2 | preliminaries.tex | Defense Set |
| Definition 3 | Def 3 | preliminaries.tex | 解释验证任务 |
| Definition 4 | Def 4 | preliminaries.tex | 最小改变解释修复 |
| Definition 5 | Def 5 | method.tex | 修复问题形式化 |
| Algorithm 1 | Alg 1 | method.tex | ARGUS Repair |
| Theorem 1 | Thm 1 | theory.tex | AGM Compliance (success, inclusion, vacuity) |
| Theorem 2 | Thm 2 | theory.tex | 复杂度 (grounded ∈ P, preferred/stable credulous NP-c, skeptical stable Σ₂ᴾ-c) |
| Proposition 1 | Prop 1 | theory.tex | ASP encoding 正确性和完备性 |

### Running Example

- **场景**: 医疗诊断（Lupus case）
- **引入**: Introduction (Example 1, `\label{ex:running}`)
- **复用**: Preliminaries, Method, Theory, Experiments 各 section 通过 `Continuing Example~\ref{ex:running}` 引用

---

## 15. 数值快速参考

### ARGUS 主结果

| 指标 | HotpotQA | FEVER |
|------|----------|-------|
| Faithfulness | 0.847 ± 0.011 | 0.829 ± 0.013 |
| Contestability | 0.791 ± 0.014 | 0.768 ± 0.016 |
| Repair Accuracy | 0.883 ± 0.009 | 0.871 ± 0.010 |
| Repair Cost | 3.2 ± 0.3 | 2.8 ± 0.3 |

### 提升幅度 (vs ARGORA, strongest baseline)

| 指标 | HotpotQA | FEVER |
|------|----------|-------|
| Faithfulness | +10.3% | +10.2% |
| Contestability | +14.5% | +14.3% |
| Repair Accuracy | +10.2% | +10.5% |
| Repair Cost | -37.3% (3.2 vs 5.1) | -40.4% (2.8 vs 4.7) |

### AGM 理论验证

| 属性 | 通过率 |
|------|--------|
| AGM Success | 100% (500 cases) |
| AGM Inclusion | 100% (500 cases) |
| AGM Vacuity | 100% |
| Minimality | 99.7% (500 cases) |

---

## 16. 审稿文件管理规范

### 16.1 编号纪律

> **教训**：2026-02-15 因 context window 压缩丢失实际轮次计数，R13-R18/R19-R22 与已有文件重复，引发 49 文件重命名。根因：plan 文件中的过期编号被当作真实编号。

**铁律**：
1. **开始新审稿前，必须先执行 `ls review/ | tail -5` 确认当前最大轮次编号**，然后从 N+1 开始。
2. **禁止依赖 plan 文件或上下文记忆中的轮次编号**——context 压缩和 session 切换会导致丢失。

### 16.2 命名格式

- **标准格式**：`review_round{N}.md`（N 为轮次号，如 `review_round8.md`）
- **批量文件**：`review_round{start}-{end}.md`（如 `review_round39-45.md`）
- **特殊轮次**：`review_round{N}b.md`（如 `review_round5b.md`，额外修订轮）
- **内部一致**：文件第一行 `# Review Round {N}: {Topic}` 与文件名编号一致

### 16.3 索引维护

- 每个项目 `review/` 下必须有 **INDEX.md**
- 每轮审稿结束后更新索引
- 跳号须在索引中注明原因
- INDEX.md 包含：轮次映射表、累计统计、关键修复追踪、非 FIXED 清单

### 16.4 每轮一文件原则

- **建议**每轮独立文件（利于 git blame 和定位）
- 批量文件（≤7 轮合并）可接受，但须在 INDEX.md 标注
- 每个子轮次用 `## R{NN}: {Topic}` 作为节标题

### 16.5 跨轮修复追踪

- Issue 在后续轮次被修复时，须在 INDEX.md 标注修复轮次
- 最终回归轮使用 `R{原轮}.{序号}` 格式引用（如 R13.1, R13.2）
- 非 FIXED 条目须标注状态（DEFERRED/WONTFIX/ACCEPTED/ACKNOWLEDGED）和理由

---

## 17. Desk Rejection 惨痛教训（2026-02-25）

> **案例**：ARGUS 论文 (Paper #607) 经过 68 轮审查、修复 160+ issues 后被 KR 2026 ML&E Track desk reject。
> 原因：格式不合规（页数超限）。所有内容审查在格式不合规面前 = 白费。

### 17.1 根因分析

**直接原因：Appendix 页数未计入 9 页限制**

论文结构：
```
body (abstract → conclusion)  = ~9 页    ← 以为这就是"正文"
references                    = ~1.5 页   ← 不计入（正确）
\appendix (5 sections)        = ~2-3 页   ← 错误地以为不计入！
```

实际可数页数 = 9 + 2-3 = **~11-12 页**，超出 9 页限制 2-3 页。

**根本原因：R64 的"压缩"是假压缩**

R64 将正文从 ~9.5 页压缩到 ~9 页的做法是：把 Figure 5/6 + Sensitivity Analysis + Error Analysis **移到 `\appendix`**。但 KR 2026 规则明确规定 appendix 计入页数限制！这不是压缩，是自欺欺人。

正确做法应该是：
1. 将附录内容做成单独的 PDF 作为 **supplementary material** 上传（不计入限制）
2. 或者真正删减正文+附录到 ≤ 9 页

**可能的次要原因：模板版本过旧**

使用的 `kr.sty` 是 v1.2 (2020-02-27)，KR2026 的 authors kit 可能包含更新版本。使用错误版本可能触发"wrong format adopted"。

### 17.2 核心教训

1. **格式合规 > 内容质量**：desk rejection 不看内容。68 轮内容审查在格式不合规面前毫无价值。格式检查必须在第一轮审查就完成，不能留到最后。

2. **`\appendix` ≠ supplementary material**：
   - `\appendix`（写在 `.tex` 中，出现在最终 PDF 里）→ **计入页数限制**
   - Supplementary material（单独文件上传到投稿系统）→ **不计入页数限制**
   - 绝对禁止把内容从 body 移到 `\appendix` 来"省页数"

3. **必须验证 PDF 实际页数**：不能靠估算、不能靠"Conclusion 在第 9 页所以没超"。必须用 `pdfinfo` 计算实际可数页数。

4. **模板版本必须核实**：投稿前必须从会议官网下载最新 authors kit，diff 比较 `.sty` 和 `.bst` 文件。

### 17.3 投稿前铁律清单（必须 100% 通过才能投稿）

```
□ 1. 下载会议最新 authors kit，diff 比较 .sty/.bst 版本
□ 2. 编译 PDF：cd paper && latexmk -pdf main.tex
□ 3. 验证 PDF 页数：pdfinfo main.pdf | grep Pages
□ 4. 计算可数页数 = 总页数 - references 页数 - acknowledgements 页数
     注意：appendix 页数计入！！
□ 5. 确认可数页数 ≤ 会议限制
□ 6. 如有 \appendix 内容，确认已计入可数页数
□ 7. 如超限，将多余内容移到 supplementary material（单独上传），不是移到 \appendix
□ 8. 验证匿名化：grep -ri "author_name\|affiliation\|funding_source" *.tex
□ 9. 验证 0 编译错误、0 undefined references
□ 10. 投稿系统中勾选 "ready for review"
```

### 17.4 Appendix vs Supplementary Material 对照表

| 特征 | In-paper Appendix | Supplementary Material |
|------|-------------------|----------------------|
| 位置 | `.tex` 文件中的 `\appendix` | 单独 PDF/ZIP 上传 |
| 出现在最终 PDF 中 | ✅ 是 | ❌ 否（独立文件） |
| 计入页数限制 | ✅ **是！** | ❌ 否 |
| 审稿人必须看 | ✅ 是 | ❌ 否（可选） |
| 适合放什么 | 简短补充（如果页数允许） | 详细证明、额外实验、代码、数据 |
| 要求 | 论文必须 self-contained | 论文必须 self-contained |

### 17.5 防止再犯的工作流改进

1. **审查顺序改为**：格式合规（Section 7.G）→ 创新点（Section 11）→ 内容审查（Section 10）
2. **每次 `/review-paper` 必须首先执行格式合规检查**，不通过则中止所有后续审查
3. **`/submit-check` 命令必须包含完整的铁律清单验证**
4. **禁止在未验证格式的情况下声称"投稿就绪"**

---

## Long-Running Agent Workflow

本项目使用 agent harness 实现跨 session 持续工作。状态文件：
- `task.json` — 结构化任务列表（JSON，防误改）
- `claude-progress.txt` — session 日志
- `init.sh` — 环境验证脚本

### Session 启动（每次必须执行）

1. `bash init.sh` — 验证环境可编译
2. `tail -80 claude-progress.txt` — 读上次进度
3. `git log --oneline -20` — 读 git 历史
4. 解析 task.json → 选最高优先级的可执行任务
5. 向用户报告选定任务，开始执行

### 任务执行

- 按 task.steps 逐步执行，不跳步
- 每次改 .tex 后编译验证（页数 ≤9）
- 所有 task.verification 通过才能标记 completed
- 用 Conventional Commits 提交（feat/fix/docs/chore）

### 障碍处理

- 记录到 progress.txt（OBSTACLE-ID）
- 记录到 task.json notes
- 不标记为 completed
- 切换到下一可用任务

### task.json 修改规则

可改：`status`, `completed_at`, `session_id`, `notes`
禁改：`id`, `title`, `steps`, `verification`, `blocked_by`, `priority`

### 命令映射

| 任务类别 | 命令 |
|---------|------|
| writing | `/paper-write [section]` |
| review | `/review-paper [mode]` |
| formatting | `/academic-polish` |
| submission | `/submit-check` |
| 编译 | `/compile-paper` |
