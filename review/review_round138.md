# R138: 引用审查

**日期**: 2026-02-26
**审查员**: Claude (Citation Reviewer)
**焦点**: natbib 迁移完整性、引用格式、baseline 覆盖、UAI 社区工作

---

## natbib 迁移验证

### 引用命令检查
- `\cite{}` 残留: 0 ✅ (全部迁移到 natbib)
- `\citep{}` 使用: 正确用于括号引用
- `\citet{}` 使用: 正确用于 "Author (year)" 格式
- `\shortcite{}` 残留: 0 ✅ (KR 特有命令已移除)

### 引用格式一致性
| 位置 | 引用样式 | 正确性 |
|------|----------|--------|
| introduction.tex:5 | `\citep{ye2024selfexplanation}` | ✅ 括号引用 |
| introduction.tex:5 | `\citep{lanham2023measuring}` | ✅ |
| introduction.tex:16 | `\citep{madaan2023selfrefine,shinn2023reflexion,gao2023rarr}` | ✅ 多引用 |
| introduction.tex:16 | `\citep{huang2024selfcorrect}` | ✅ |
| introduction.tex:17 | `\citep{freedman2025arglm,argora2026}` | ✅ |
| introduction.tex:81 | `\citet{dung1995acceptability}` | ✅ 文本引用 |
| introduction.tex:83 | `\citep{alchourron1985agm}` | ✅ |
| introduction.tex:83 | `\citep{cayrol2020argumentation}` | ✅ |
| related_work.tex:7 | `\citet{vassiliades2021argumentation}` | ✅ |
| related_work.tex:8 | `\citep{freedman2025arglm}` | ✅ |
| related_work.tex 全文 | 混合 `\citet{}` + `\citep{}` | ✅ 符合 natbib 惯例 |

---

## MAJOR Issues

### M1. 缺少 UAI 社区核心引用 [MAJOR]
**位置**: [related_work.tex](paper/sections/related_work.tex)
**问题**: 与 R134-M3 呼应。以下 UAI 社区重要工作未被引用：
1. **Probabilistic argumentation**: Hunter (2013) "A probabilistic approach to modelling uncertain logical arguments", Li et al. (2021) "Probabilistic abstract argumentation"
2. **Uncertainty in LLM explanations**: Kuhn et al. (2023) "Semantic Uncertainty: Linguistic Invariances for Uncertainty Estimation in Natural Language Generation" — 直接相关于 LLM explanation 的 uncertainty
3. **UAI 发表的 argumentation 工作**: 需要检查 UAI 2023-2025 proceedings 中是否有 argumentation 相关论文

**修复建议**: 在 "Argumentation and LLMs" 段加 1 句定位 probabilistic vs classical argumentation，并引用 1-2 篇 probabilistic argumentation 工作。

### M2. 引文 `argora2026` 和 `freedman2025arglm` 需验证 [MAJOR]
**位置**: 多处
**问题**: 这两篇是 2025-2026 年的论文，需要确认：
- `argora2026`: 是否已正式发表？如果是 preprint，应标注
- `freedman2025arglm`: 同上
如果是未发表的 concurrent work，需要在引用时注明。

### M3. `\citet` vs `\citep` 使用不一致 [MAJOR]
**位置**: [related_work.tex:22](paper/sections/related_work.tex#L22)
**问题**:
```latex
\citet{cayrol2020argumentation} and \citet{baumann2010complexity} study how...
\citet{costemarquis2014enforcement}, \citet{wallner2017complexity}, and \citet{bisquert2013repair} formalize...
```
连续用 5 个 `\citet{}` 列举作者 + 工作，读起来非常冗长。在综述性段落中，更好的做法是用 1 个 `\citep{}` 包含多个引用：
```latex
Structural modifications and their effects on extensions have been extensively studied~\citep{cayrol2020argumentation,baumann2010complexity}; several formalizations of argumentation revision as minimal structural change exist~\citep{costemarquis2014enforcement,wallner2017complexity,bisquert2013repair}.
```

---

## MINOR Issues

### m1. Self-citation 风险 [MINOR]
**状态**: PASS — 论文匿名化正确，no self-identifying references detected。

### m2. 引用年份验证 [MINOR]
抽查几个关键引用的年份：
- Dung (1995) — Artificial Intelligence journal ✅
- AGM (1985) — Journal of Symbolic Logic ✅
- Egly et al. (2010) — JAIR ✅
- Dvořák & Woltran (2018) — AI Communications? → 需验证
**状态**: 需要检查 bib 文件确认

### m3. 首次引用规则 [MINOR]
检查是否有论文被多次引用但应在首次出现时已经介绍：
- `dung1995acceptability`: 首次在 introduction:81 ✅，后续在 preliminaries/method/theory 中复用
- `alchourron1985agm`: 首次在 introduction:83 ✅
- `egly2010asparg`: 首次在 method:63 ✅
**状态**: PASS — 主要引用遵循首次引用规则。

### m4. BibTeX 编译无 undefined citation [MINOR]
**状态**: 编译日志中无 "Citation ... undefined" 警告 ✅

---

## 统计

| 类型 | 数量 |
|------|------|
| CRITICAL | 0 |
| MAJOR | 3 |
| MINOR | 4 |
| PASS | 3 |

**总结**: natbib 迁移完整无残留。主要问题是缺少 UAI 社区引用（与 R134 呼应）和 Related Work 中 `\citet` 过度使用导致句式冗长。
