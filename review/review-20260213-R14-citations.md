# R14: 引用 & Related Work 完整性审计

**日期**: 2026-02-13
**视角**: Prof. Modgil — KR PC 资深成员，广泛了解 argumentation + LLM 文献

## 发现汇总

| ID | 严重级 | 问题 | 状态 |
|----|--------|------|------|
| 14-1 | CRITICAL | 2024-2025 argumentation+LLM 新工作遗漏检查 | **PASS** (无直接竞争者) |
| 14-2 | MAJOR | 缺少的自纠正基线: CoVe, CRITIC | **FIXED** |
| 14-3 | MAJOR | SelfCheckGPT bib 条目: arXiv → EMNLP 2023 | **FIXED** |
| 14-4 | MAJOR | lanham2023measuring bib 格式: booktitle→journal for arXiv | **FIXED** |
| 14-5 | MINOR | BibTeX key-year 不匹配 (cayrol2019→2020, dvorak2012→2018, ling2024→2023) | **ACCEPTED** (keys 为内部标识符，year 字段正确) |
| 14-6 | MINOR | argora2026 Anonymous arXiv — 并发工作 | **ACCEPTED** (合理引用并发工作) |
| 14-7 | MINOR | Cyras et al. (2021) argumentative XAI survey 未引用 | **DEFERRED** (非必须，篇幅受限) |

## 详细分析

### 14-1: 2024-2025 新工作遗漏检查 — PASS

Web search 覆盖: KR2024/2025, AAAI2025, IJCAI2025, NeurIPS2024/2025 中 argumentation + LLM 论文。

**发现**:
- ArgLLMs (Freedman et al., AAAI 2025) — 已引用 ✓
- ARGORA (Anonymous, arXiv 2026) — 已引用 ✓
- MQArgEng (Castagna et al., arXiv 2024) — 已引用 ✓
- **无直接竞争的 "minimal-change repair for LLM explanations" 工作**

"To the best of our knowledge" 声明 (introduction) 仍然成立。

### 14-2: 自纠正基线遗漏 — FIXED

**问题**: Self-Correction 段落缺少两个重要的近期方法:
- Chain-of-Verification (CoVe, Dhuliawala et al., ACL 2024 Findings)
- CRITIC (Gou et al., ICLR 2024)

**修复**: 在 related_work.tex Self-Correction 段落中添加简要提及，强调它们也缺乏 formal guarantees on preservation。

### 14-3: SelfCheckGPT bib 更新 — FIXED

**问题**: `manakul2023selfcheckgpt` 列为 `@article` + arXiv，但已正式发表于 EMNLP 2023。
**修复**: 更新为 `@inproceedings` + EMNLP 2023 venue + pages。

### 14-4: lanham2023measuring 格式 — FIXED

**问题**: 使用 `@inproceedings` + `booktitle={arXiv preprint...}` 混合格式。
**修复**: 改为 `@article` + `journal={arXiv preprint...}`（标准 arXiv 引用格式）。

## 修改文件

| 文件 | 修改 |
|------|------|
| references.bib | SelfCheckGPT → EMNLP 2023; lanham → @article; 新增 dhuliawala2024cove, gou2024critic |
| related_work.tex | Self-Correction 段落增加 CoVe, CRITIC 简要提及 |

## 回归检查

| 历史问题 | 状态 |
|----------|------|
| B1 (credulous/skeptical) | PASS |
| B2 (notation unified) | PASS |
| 8-1 (Theorem 2 complexity) | PASS |
| 9-1 (experiments Σ₂ᴾ sync) | PASS |
| 10-1 (method.tex skeptical) | PASS |
| 10-2 (supplementary removed) | PASS |
| 11-1 (faithfulness protocol) | PASS |
| 13-1 ~ 13-9 (R13 所有修复) | PASS |
| 编译 | 10 pages (9+refs), 0 errors, 0 undefined refs |

## 影响评估

R14 的修复相对保守——主要是 BibTeX 质量提升和两个遗漏基线的补充。CoVe 和 CRITIC 的添加强化了 Self-Correction 段落的完整性，使论文在审稿中不会因遗漏近期重要工作而被质疑。新增引用仅增加约 2 行文本，未影响页数限制。
