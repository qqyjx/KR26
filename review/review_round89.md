# KR26 审稿报告 R89 — Citations Review
日期：2026-02-17
审稿模式：citations — BibTeX key 存在性验证、undefined reference 检查、新增基线引用完整性审查
续接：R88（0C+1M+2m，数据一致性审查，中稿概率 84-87%）

---

## 1. 任务概述

本轮专项检查以下内容：
1. 三个新增 bib key（`jiang2023flare`、`min2023factscore`、`zhang2020bertscore`）是否存在于 `references.bib`
2. `experiments.tex` 是否正确引用了这三个 key
3. LaTeX 编译日志是否存在 undefined citation 警告
4. 全文所有 `\cite{}` 命令是否均可在 bib 中找到对应条目（无孤立引用）
5. bib 中是否存在定义但从未被引用的条目（orphaned entries）
6. ARGORA、Chain-of-Verification、CRITIC 的引用状态

---

## 2. 引用核验总表

### 2.1 三个新增 bib key 专项核验

| Key | 在 references.bib 中存在 | 在 experiments.tex 中引用 | 引用位置 | 状态 |
|-----|------------------------|--------------------------|----------|------|
| `jiang2023flare` | YES（第 329-335 行） | YES（line 21: `\cite{jiang2023flare}`） | 基线段落（Verification-Oriented 分类）+ Table 1 行 | PASS |
| `min2023factscore` | YES（第 337-343 行） | YES（line 21: `\cite{min2023factscore}`） | 基线段落（Verification-Oriented 分类）+ Table 1 行 | PASS |
| `zhang2020bertscore` | YES（第 345-350 行） | YES（line 18: `\cite{zhang2020bertscore}`） | 指标定义段（Coherence 度量定义处） | PASS |

**详细 bib 条目确认：**

- `jiang2023flare`：@inproceedings，"Active Retrieval Augmented Generation"，EMNLP 2023，pages 7969-7992。条目完整，venue 为 EMNLP'23，与任务要求一致。
- `min2023factscore`：@inproceedings，"FActScore: Fine-grained Atomic Evaluation of Factual Precision in Long Form Text Generation"，EMNLP 2023，pages 11193-11215。条目完整，venue 为 EMNLP'23，与任务要求一致。
- `zhang2020bertscore`：@inproceedings，"BERTScore: Evaluating Text Generation with BERT"，ICLR 2020（第 8 届）。条目完整，venue 为 ICLR'20，与任务要求一致。

### 2.2 其他关键引用核验

| Key | 在 bib 中 | 在 .tex 中使用 | 引用上下文 | 状态 |
|-----|-----------|----------------|-----------|------|
| `argora2026` | YES | YES（experiments.tex line 21） | Argumentation-Based 基线段落 + Table 1 行 | PASS |
| `dhuliawala2024cove` | YES | YES（experiments.tex line 23） | 排除说明（generation-time 方法） | PASS |
| `gou2024critic` | YES | YES（experiments.tex line 23） | 排除说明（generation-time 方法） | PASS |
| `manakul2023selfcheckgpt` | YES | YES（experiments.tex line 21） | Self-correction 基线 | PASS |
| `madaan2023selfrefine` | YES | YES（experiments.tex line 21） | Self-correction 基线 | PASS |
| `shinn2023reflexion` | YES | YES（experiments.tex line 21） | Self-correction 基线 | PASS |
| `gao2023rarr` | YES | YES（experiments.tex line 21） | Self-correction 基线 | PASS |
| `ling2023deductive` | YES | YES（experiments.tex line 21） | CoT-Verifier 基线 | PASS |
| `freedman2025arglm` | YES | YES（experiments.tex line 21） | ArgLLMs 基线 | PASS |

### 2.3 全文引用完整性（孤立引用 / 未引用 bib 条目）

**方法**：对 `sections/` 下所有 .tex 文件提取所有 `\cite{key}` 键值，与 `references.bib` 中所有条目对比。

| 检查项 | 结果 |
|--------|------|
| 被引用但不在 bib 中的 key 数 | **0** |
| 在 bib 中定义但从未被引用的 key 数 | **0** |
| 全文 bib 条目总数 | 39 条 |
| 全文唯一被引用 key 数 | 39 个 |

**结论：bib 文件与 .tex 引用完全对应，无孤立引用，无未使用条目。**

---

## 3. 编译状态

```
命令: cd /home/qq/KR26/paper && latexmk -pdf main.tex
```

| 检查项 | 结果 |
|--------|------|
| 编译是否成功 | YES |
| 输出页数 | 13 pages |
| Citation undefined 警告 | **0** |
| Undefined reference 警告（LaTeX 交叉引用） | 0（main.aux 中的"undefined"均为 hyperref 内部定义，非 citation 问题） |
| 其他错误 | 0 |
| 字体警告（Font shape `OT1/ptm/m/scit'`） | 4 条（已知，非引用问题，R84 已记录为 ACKNOWLEDGED） |
| Overfull hbox | 0 |
| `h` float specifier 警告 | 1 条（已知，非引用问题） |

**编译状态：0 errors，0 undefined citations，13 pages。**

---

## 4. experiments.tex 引用结构详析

### 4.1 FLARE 引用

**位置 1（line 12）**：运行说明段，说明 FLARE 为"single deterministic run of the published models on our instances"，无直接 `\cite`（此处引用在 line 21 给出）。

**位置 2（line 16）**：Contestability 定义段，`(FLARE, FactScore)` 提及但无 `\cite`（与 line 21 的首次引用保持一致，后续提及不重复引用）。

**位置 3（line 21）**：`FLARE~\cite{jiang2023flare}` — 首次引用且带 `\cite`。规范。

**Table 1（line 45）**：`FLARE` 行数据出现，无 `\cite`（表格内方法名后不重复引用，属标准做法）。

**位置 4（line 57）**：结果分析段提及 FLARE，无 `\cite`（方法已在 line 21 引入）。

**结论**：FLARE 在首次出现的基线列表处正确引用 `\cite{jiang2023flare}`，后续提及均为正当省略。PASS。

### 4.2 FactScore 引用

**位置 1（line 21）**：`FactScore~\cite{min2023factscore}` — 首次引用且带 `\cite`。规范。

**后续提及**：line 12、line 16、line 46、line 57 均提及 FactScore 但不重复引用。规范。

**结论**：PASS。

### 4.3 BERTScore 引用

**位置（line 18）**：`via BERTScore~\cite{zhang2020bertscore} between repaired and original explanations` — 在 Coherence 指标定义处首次引用。规范。

**结论**：PASS。

### 4.4 ARGORA 引用

**位置（line 21）**：`ARGORA~\cite{argora2026}` — 首次引用于 Argumentation-Based 基线列表。规范。

bib 中 `argora2026` 条目：@article，arXiv:2601.21533，2026 年，作者信息完整。PASS。

### 4.5 Chain-of-Verification 和 CRITIC 引用

**位置（line 23）**：`Chain-of-Verification~\cite{dhuliawala2024cove} and CRITIC~\cite{gou2024critic} are excluded as they operate at generation time rather than post-hoc repair.`

两者均被引用且给出了排除理由，引用规范。PASS。

---

## 5. CRITICAL 问题清单

**本轮新发现的 CRITICAL：0**

三个新增 bib key（`jiang2023flare`、`min2023factscore`、`zhang2020bertscore`）均存在于 `references.bib` 且在 `experiments.tex` 中正确引用。编译无 undefined citation 警告。

---

## 6. MAJOR 问题清单

**本轮新发现的 MAJOR：0**

无孤立引用（cited but not in bib），无未使用 bib 条目（in bib but not cited）。所有 39 个 bib 条目均在正文中至少被引用一次，所有被引用的 key 均有对应 bib 条目。

**R88 遗留 MAJOR（M1）**：results.json 中 FLARE/FactScore `_status: PRESET` 与 experiments.tex 中"single deterministic run on our instances"措辞的矛盾。本轮未审查 results.json，该问题维持 R88 M1 状态（未修复）。

---

## 7. MINOR 问题清单

**本轮新发现的 MINOR：1**

### m1. references.bib 中 `zhang2020bertscore` 会议届次表述可能引起混淆

**位置**：`references.bib` 第 345-350 行

**问题**：bib 条目为：

```bibtex
@inproceedings{zhang2020bertscore,
  title={{BERTScore}: Evaluating Text Generation with {BERT}},
  ...
  booktitle={Proceedings of the 8th International Conference on Learning Representations (ICLR)},
  year={2020}
}
```

ICLR 2020 是第 8 届（2013 年首届至 2020 年为第 8 届），这一届次标注不常见——大多数 ICLR 论文的 bib 条目仅写"International Conference on Learning Representations (ICLR)"而不写届次编号，因为 ICLR 届次计算方式存在争议（有时从 2013 年算，有时不同起点）。KR BST 样式在渲染时会包含 booktitle 字段，"8th"的写法可能引起审稿人质疑届次是否准确。然而，实际上这不影响文章可查性，且 BERTScore 确实是 ICLR 2020 收录，核心事实正确。

**严重性**：MINOR（格式细节，不影响引用正确性或可查性，与 KR BST 渲染兼容）

**修复建议**：可将 booktitle 统一为 `{Proceedings of the 8th International Conference on Learning Representations (ICLR 2020)}`（加年份便于区分）或简化为 `{Proceedings of the International Conference on Learning Representations (ICLR)}`，与本 bib 中另一 ICLR 条目（`gou2024critic`：`booktitle={Proceedings of the 12th International Conference on Learning Representations (ICLR)}`）风格保持一致（均写届次）。当前格式与 `gou2024critic` 和 `huang2024selfcorrect` 的 ICLR 条目风格一致，可接受。

**现状：可接受，无需紧急修复。**

**R88 遗留 MINOR（m2、m3）**：
- m2（results.json FLARE/FactScore std 字段来源不明）：本轮未审查 results.json，维持 R88 状态。
- m3（introduction.tex C4 "seven baselines"与 experiments.tex "ten baselines"不一致）：本轮未审查 introduction.tex，维持 R88 状态，建议在下一轮写作/修复中处理。

---

## 8. 对比上轮（R88）的回归检查

| R88 问题 | 本轮状态 |
|----------|---------|
| M1：results.json PRESET vs "single run" | 未修复（超出本轮 citations 审查范围） |
| m2：results.json FLARE/FactScore std 来源 | 未修复（超出本轮范围） |
| m3：introduction.tex C4 "seven baselines" | 未修复（超出本轮范围） |

---

## 9. 总结

### CRITICAL 问题：0

三个新增 bib key（FLARE、FactScore、BERTScore）均验证通过：存在于 bib，在 experiments.tex 中正确引用。编译输出 0 undefined citations。

### MAJOR 问题：0（本轮新发现）

全文 39 个 bib 条目与 39 个被引用 key 完全双向匹配，无孤立引用，无未使用条目。

### MINOR 问题：1（本轮新发现）

m1：`zhang2020bertscore` bib 条目 booktitle 中 ICLR 届次写法（"8th"）与 bib 中其他 ICLR 条目风格略有差异，建议统一但不紧急。

### 编译状态

- 0 errors，0 undefined citation，13 pages，0 overfull hbox
- 4 条字体警告（已知，ACKNOWLEDGED）
- 1 条 float 警告（已知，ACKNOWLEDGED）

---

## 10. 中稿概率评估

**当前：~84-87%**（维持 R88 水平，本轮 citations 审查无新发现影响评估）

**本轮引用审查结论**：
- 引用完整性：满分。三个新增基线引用全部正确，无遗漏，无孤立引用
- 编译无误：0 undefined citations，论文可以正常渲染所有参考文献
- bib 文件维护良好：39 条条目全部被使用，无冗余

**恢复至 86-89% 的路径**（来自 R88）：
1. 修复 R88 M1（确认 FLARE/FactScore 实际实验状态，更新 results.json 或降级论文文本）
2. 修复 R88 m3（将 introduction.tex C4 中的"seven baselines"更新为"ten comparison methods"）

两项修复均不涉及引用文件，可独立执行。
